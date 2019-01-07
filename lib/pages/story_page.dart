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

class _StoryPageState extends State<StoryPage>
    with SingleTickerProviderStateMixin {
  bool customAppBarShow = true;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: widget.story.pages.length,
    );
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      customAppBarShow = _tabController.index == widget.story.pages.length - 1;
    });
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Container(
      child: AppBar(
        title: Text(
          widget.story.title,
        ),
        backgroundColor: Colors.black45,
      ),
      height: 60,
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
            setState(() {
              customAppBarShow = !customAppBarShow;
            });
          },
          child: Stack(
            children: <Widget>[
              _fullScreenImage(page),
              customAppBarShow ? _buildCustomAppBar(context) : Container(),
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
