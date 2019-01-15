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
  Animation<Offset> _animation;

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

    _animation = Tween<Offset>(
      begin: Offset(0, -2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    ));

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
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ),
        child: SlideTransition(
          position: _animation,
          child: AppBar(
            title: Text(
              widget.story.title,
            ),
            backgroundColor: Colors.black45,
          ),
        ),
      ),
    );
  }

  Widget _fullScreenImage(Page page) {
    return CachedNetworkImage(
      imageUrl: page.url,
      placeholder: CircularProgressIndicator(),
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
