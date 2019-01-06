import "package:flutter/material.dart";
import 'package:cached_network_image/cached_network_image.dart';

import "../pages/story_page.dart";
import "../models/story.dart";

class StoryCard extends StatelessWidget {
  final Story story;

  StoryCard(this.story);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0, bottom: 0),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          title: Text(
            story.title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return StoryPage(story);
            }));
          },
          child: CachedNetworkImage(
            imageUrl: story.coverUrl,
            placeholder: new CircularProgressIndicator(),
            errorWidget: new Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}