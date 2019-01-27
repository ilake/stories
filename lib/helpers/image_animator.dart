import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MyCustomPainter extends CustomPainter {
  Paint p = Paint();
  Size size = Size.zero;
  ui.Image image;
  BoxFit beginFit;
  BoxFit endFit;
  Animation anim;
  Animation<ui.Rect> dstAnim;
  Rect imageRect;

  MyCustomPainter(this.anim, this.image, this.beginFit, this.endFit)
      : super(repaint: anim);

  @override
  void paint(Canvas canvas, Size size) {
    Rect viewRect = Offset.zero & size;

    if (size != this.size && image != null) {
      print('new size $size');
      this.size = size;

      imageRect =
          Rect.fromLTRB(0, 0, image.width.toDouble(), image.height.toDouble());
      Size beginS = applyBoxFit(beginFit, imageRect.size, size);
      Size endS = applyBoxFit(endFit, imageRect.size, size);

      dstAnim = RectTween(
        begin: Alignment.center.inscribe(beginS, viewRect),
        end: Alignment.center.inscribe(endS, viewRect),
      ).animate(anim);
    }
    if (image != null) {
      // if (debugPaintSizeEnabled) {
      //   p.style = ui.PaintingStyle.stroke;
      //   p.color = Colors.red;
      //   canvas.drawRect(dstAnim.value, p);
      // }
      canvas.clipRect(viewRect);
      canvas.drawImageRect(image, imageRect, dstAnim.value, p);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  Size applyBoxFit(BoxFit fit, Size ins, Size outs) {
    if (fit == BoxFit.fill) return Size.copy(outs);
    if (fit == BoxFit.none || (fit == BoxFit.scaleDown && ins < outs))
      return Size.copy(ins);
    if (fit == BoxFit.contain || fit == BoxFit.scaleDown) {
      if (outs.aspectRatio > ins.aspectRatio)
        return ins * (outs.height / ins.height);
      return ins * (outs.width / ins.width);
    }
    if (fit == BoxFit.cover) {
      if (outs.aspectRatio > ins.aspectRatio)
        return ins * (outs.width / ins.width);
      return ins * (outs.height / ins.height);
    }
    if (fit == BoxFit.fitWidth) return ins * (outs.width / ins.width);
    if (fit == BoxFit.fitHeight) return ins * (outs.height / ins.height);
    
    return Size.copy(outs);
  }
}

class ImageAnimator extends StatefulWidget {
  final AnimationController controller;
  final ImageProvider imageProvider;
  final Widget child;
  final BoxFit beginFit;
  final BoxFit endFit;

  const ImageAnimator(
      {Key key,
      @required this.child,
      @required this.controller,
      @required this.imageProvider,
      @required this.beginFit,
      @required this.endFit})
      : assert(child != null),
        assert(controller != null),
        assert(imageProvider != null),
        assert(beginFit != null),
        assert(endFit != null),
        super(key: key);

  @override
  _ImageAnimatorState createState() => _ImageAnimatorState();
}

class _ImageAnimatorState extends State<ImageAnimator>
    with SingleTickerProviderStateMixin {
  ImageStream _imageStream;
  ImageInfo _imageInfo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // We call _getImage here because createLocalImageConfiguration() needs to
    // be called again if the dependencies changed, in case the changes relate
    // to the DefaultAssetBundle, MediaQuery, etc, which that method uses.
    _getImage();
  }

  @override
  void didUpdateWidget(ImageAnimator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageProvider != oldWidget.imageProvider) {
      _getImage();
    }
  }

  void _getImage() {
    final ImageStream oldImageStream = _imageStream;
    _imageStream =
        widget.imageProvider.resolve(createLocalImageConfiguration(context));
    if (_imageStream.key != oldImageStream?.key) {
      // If the keys are the same, then we got the same image back, and so we don't
      // need to update the listeners. If the key changed, though, we must make sure
      // to switch our listeners to the new image stream.
      oldImageStream?.removeListener(_updateImage);
      _imageStream.addListener(_updateImage);
    }
  }

  void _updateImage(ImageInfo imageInfo, bool synchronousCall) {
    setState(() {
      // Trigger a build whenever the image changes.
      _imageInfo = imageInfo;
    });
  }

  @override
  void dispose() {
    _imageStream.removeListener(_updateImage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_imageInfo == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return CustomPaint(
      painter: MyCustomPainter(
          widget.controller, _imageInfo?.image, widget.beginFit, widget.endFit),
      child: widget.child,
    );
  }
}
