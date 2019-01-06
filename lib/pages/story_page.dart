import "package:flutter/material.dart";
import 'package:cached_network_image/cached_network_image.dart';

import "../models/story.dart";

class StoryPage extends StatelessWidget {
  final Story story;

  List<Widget> _buildPages() {
    return story.pages.map<Widget>(
      (Page page) {
        return Center(
          child: CachedNetworkImage(
            imageUrl: page.url,
            placeholder: CircularProgressIndicator(),
            errorWidget: Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        );
      },
    ).toList();
  }

  StoryPage(this.story);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(story.title),
      ),
      body: DefaultTabController(
        length: story.pages.length,
        child: TabBarView(
          children: _buildPages(),
        ),
      ),
    );
  }
}
