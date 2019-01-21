import "package:flutter/material.dart";
import 'package:cached_network_image/cached_network_image.dart';

import "../models/story.dart";

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
  Animation<double> _animation;

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

  Widget _buildCustomAppBar(BuildContext context) {
    return Container(
      height: 60,
      child: AnimatedAppbar(animation: _animation, title: widget.story.title),
    );
  }

  Widget _fullScreenImage(Page page) {
    return CachedNetworkImage(
      imageUrl: page.url,
      placeholder: Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: Icon(Icons.error),
      fit: BoxFit.contain,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
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
  final String title;

  AnimatedAppbar({Key key, Animation<double> animation, this.title})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;

    return FadeSliderTransition(
      animation: animation,
      child: AppBar(
        title: Text(
          title,
        ),
        backgroundColor: Colors.black45,
      ),
    );
  }
}
