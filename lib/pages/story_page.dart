import "package:flutter/material.dart";
import 'package:cached_network_image/cached_network_image.dart';

import "../models/story.dart";
import "../helpers/image_animator.dart";

class StoryPage extends StatefulWidget {
  final Story story;

  StoryPage(this.story);

  @override
  State<StatefulWidget> createState() {
    return _StoryPageState();
  }
}

class _StoryPageState extends State<StoryPage> with TickerProviderStateMixin {
  bool customAppBarShow = true;
  TabController _tabController;
  AnimationController _animationController;
  AnimationController _fullscreenController;
  Animation<double> _animation;
  bool isFullScreen = false;
  GlobalKey imageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: widget.story.pages.length,
    );
    _tabController.addListener(_handleTabSelection);
    _animationController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    _fullscreenController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    // By default, the AnimationController object ranges from 0.0 to 1.0.
    _animation = _animationController.drive(
      CurveTween(
        curve: Curves.fastOutSlowIn,
      ),
    );

    _animationController.forward();
  }

  void _handleTabSelection() {
    if (_tabController.index == widget.story.pages.length - 1) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _toggleFullScreen() {
    // final RenderBox renderBox = imageKey.currentContext.findRenderObject();
    // print("SIZE of Red: ${renderBox.size}");
    if (_fullscreenController.isDismissed) {
      _fullscreenController.forward();
    } else {
      _fullscreenController.reverse();
    }
    setState(() {
      isFullScreen = !isFullScreen;
    });
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Container(
      height: 60,
      child: AnimatedAppbar(
        animation: _animation,
        story: widget.story,
        toggleFullScreen: _toggleFullScreen,
        isFullScreen: isFullScreen,
      ),
    );
  }

  Widget _fullScreenImage(Page page) {
    // final LimitedBox box = LimitedBox(
    //     child: Container(
    //         key: imageKey,
    //         decoration: BoxDecoration(
    //             image: DecorationImage(image: NetworkImage(page.url)))));

    // final RenderBox renderBox = imageKey.currentContext.findRenderObject();
    // print("SIZE of Red: ${renderBox.size}");
    // Try to get container size
    // Image image = Image.network(page.url);
    // Image limage = Image(image: AssetImage("assets/aruru1.png").resolve());
    // NetworkImage nimage = NetworkImage(page.url);
    // ImageInfo img = ImageInfo(image: );

    // Image.asset("assets/aruru1.png")
    //     .image
    //     .resolve(createLocalImageConfiguration(context))
    //     .addListener((ImageInfo image, bool synchronousCall) {
    //       print(image);
    //     });
    // Size outputSize;
    // NetworkImage(page.url)
    //     .resolve(createLocalImageConfiguration(context))
    //     .addListener((ImageInfo image, bool synchronousCall) {
    //   print(image);
    //   Size imageSize =
    //       Size(image.image.width.toDouble(), image.image.height.toDouble());

    //   FittedSizes beginFS =
    //       applyBoxFit(BoxFit.contain, imageSize, MediaQuery.of(context).size);
    //   print(beginFS.destination);
    // });
    // final RenderBox renderBox = imageKey.currentContext.findRenderObject();
    // print("SIZE of Red: ${renderBox.size}");
    return ImageAnimator(
      child: Container(
        width: double.infinity,
        height: double.infinity,
      ),
      controller: _fullscreenController,
      imageProvider: CachedNetworkImageProvider("https://placekitten.com/g/200/300"),
      beginFit: BoxFit.contain,
      endFit: BoxFit.cover,
    );

    // return CachedNetworkImage(
    //   imageUrl: page.url,
    //   placeholder: Center(
    //     child: CircularProgressIndicator(),
    //   ),
    //   errorWidget: Icon(Icons.error),
    //   fit: isFullScreen ? BoxFit.cover : BoxFit.contain,
    //   width: double.infinity,
    //   height: double.infinity,
    //   alignment: Alignment.center,
    // );
  }

  List<Widget> _buildPages(BuildContext context) {
    return widget.story.pages.map<Widget>(
      (Page page) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isDismissed) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
          },
          child: Stack(
            children: <Widget>[
              _fullScreenImage(page),
              _buildCustomAppBar(context),
            ],
          ),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: _buildPages(context),
      ),
    );
  }
}

class FadeSliderTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  FadeSliderTransition({this.child, this.animation});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: const Offset(0, -1), // Slightly down.
            end: Offset.zero,
          ),
        ),
        child: child,
      ),
    );
  }
}

class AnimatedAppbar extends AnimatedWidget {
  final Story story;
  final Function toggleFullScreen;
  final bool isFullScreen;

  AnimatedAppbar(
      {Key key,
      Animation<double> animation,
      this.story,
      this.toggleFullScreen,
      this.isFullScreen})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;

    return FadeSliderTransition(
      animation: animation,
      child: AppBar(
        title: Text(
          story.title,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen),
            onPressed: toggleFullScreen,
          ),
        ],
        backgroundColor: Colors.black45,
      ),
    );
  }
}
