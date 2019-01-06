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

class _StoryPageState extends State<StoryPage> {
  int pageNumber = 0;
  bool tweak = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.story.title),
      ),
      body: Center(
        child: Dismissible(
          key: Key("page-$pageNumber-$tweak"),
          child: CachedNetworkImage(
            imageUrl: widget.story.pages[pageNumber].url,
            placeholder: CircularProgressIndicator(),
            errorWidget: Icon(Icons.error),
            fit: BoxFit.cover,
          ),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              if (pageNumber < widget.story.pages.length - 1) {
                pageNumber += 1;
              }
            } else {
              if (pageNumber > 0) {
                pageNumber -= 1;
              }
            }
            setState(() {
              pageNumber = pageNumber;
              tweak = !tweak;
            });
          },
        ),
      ),
    );
  }
}
