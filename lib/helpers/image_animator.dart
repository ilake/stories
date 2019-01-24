import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MyCustomPainter extends CustomPainter {
  Paint p = Paint();
  Size size = Size.zero;
  ui.Image image;
  BoxFit beginFit;
  BoxFit endFit;
  Animation anim;
  Animation<ui.Rect> srcAnim;
  Animation<ui.Rect> dstAnim;

  MyCustomPainter(this.anim, this.image, this.beginFit, this.endFit)
      : super(repaint: anim);

  @override
  void paint(Canvas canvas, Size size) {
    if (size != this.size && image != null) {
      print('new size $size');
      this.size = size;

      Size imageSize = Size(image.width.toDouble(), image.height.toDouble());
      FittedSizes beginFS = applyBoxFit(beginFit, imageSize, size);
      FittedSizes endFS = applyBoxFit(endFit, imageSize, size);

      Rect imageRect = Offset.zero & imageSize;
      srcAnim = anim.drive(RectTween(
        begin: Alignment.center.inscribe(beginFS.source, imageRect),
        end: Alignment.center.inscribe(endFS.source, imageRect),
      ));
      Rect viewRect = Offset.zero & size;
      dstAnim = anim.drive(RectTween(
        begin: Alignment.center.inscribe(beginFS.destination, viewRect),
        end: Alignment.center.inscribe(endFS.destination, viewRect),
      ));
    }
    if (image != null) {
      canvas.drawImageRect(image, srcAnim.value, dstAnim.value, p);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
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
    return CustomPaint(
      painter: MyCustomPainter(
          widget.controller, _imageInfo?.image, widget.beginFit, widget.endFit),
      child: widget.child,
    );
  }
}
