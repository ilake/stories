import "package:flutter/material.dart";
import 'package:cached_network_image/cached_network_image.dart';

import "package:stories/models/home.dart";
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
  PageController _pageController;
  AnimationController _fadeSliderController;
  AnimationController _fullscreenController;
  Animation<double> _fadeSliderAnimation;

  @override
  void initState() {
    super.initState();

    _pageController = PageController()..addListener(_handleTabSelection);

    _fadeSliderController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    // By default, the _fadeSliderController object ranges from 0.0 to 1.0.
    _fadeSliderAnimation = CurvedAnimation(
        parent: _fadeSliderController, curve: Curves.fastOutSlowIn);

    _fullscreenController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeSliderController.forward();
  }

  void _handleTabSelection() {
    if (_pageController.page == widget.story.sortPages.length - 1) {
      _fadeSliderController.forward();
    } else {
      _fadeSliderController.reverse();
    }
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Container(
      height: 85,
      child: AnimatedAppbar(
        fadeSliderAnimation: _fadeSliderAnimation,
        fullscreenController: _fullscreenController,
        story: widget.story,
      ),
    );
  }

  Widget _fullScreenImage(Page page) {
    return ImageAnimator(
      child: Container(
        width: double.infinity,
        height: double.infinity,
      ),
      controller: _fullscreenController,
      imageProvider: CachedNetworkImageProvider(page.url),
      beginFit: BoxFit.contain,
      endFit: BoxFit.cover,
    );
  }

  List<Widget> _buildPages(BuildContext context) {
    return widget.story.sortPages.map<Widget>(
      (Page page) {
        return GestureDetector(
          onTap: () {
            if (_fadeSliderController.isDismissed) {
              _fadeSliderController.forward();
            } else {
              _fadeSliderController.reverse();
            }
          },
          onScaleEnd: (ScaleEndDetails details) {
            if (_fullscreenController.isDismissed) {
              _fullscreenController.forward();
            } else {
              _fullscreenController.reverse();
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
      body: PageView(
        controller: _pageController,
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
        position: Tween<Offset>(
          begin: Offset(0, -1), // Slightly down.
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}

class AnimatedAppbar extends StatelessWidget {
  final Story story;
  final Animation fadeSliderAnimation;
  final AnimationController fullscreenController;

  AnimatedAppbar({
    this.fadeSliderAnimation,
    this.fullscreenController,
    this.story,
  });

  Widget build(BuildContext context) {
    return FadeSliderTransition(
      animation: fadeSliderAnimation,
      child: AppBar(
        title: Text(
          story.title,
        ),
        actions: <Widget>[
          IconButton(
            icon: AnimatedBuilder(
              animation: fullscreenController,
              builder: (context, child) => Icon(
                    fullscreenController.isCompleted
                        ? Icons.fullscreen_exit
                        : Icons.fullscreen,
                  ),
            ),
            onPressed: () {
              if (fullscreenController.isDismissed) {
                fullscreenController.forward();
              } else {
                fullscreenController.reverse();
              }
            },
          ),
        ],
        backgroundColor: Colors.black45,
      ),
    );
  }
}
