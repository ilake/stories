import "package:flutter/material.dart";
import 'package:cached_network_image/cached_network_image.dart';

import "package:stories/models/home.dart";

class StoryCard extends StatelessWidget {
  final Story story;

  StoryCard(this.story);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0, bottom: 0),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.white54,
          title: Text(
            "[${story.status}]${story.title}",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/story/" + story.id);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18.0),
            child: CachedNetworkImage(
              imageUrl: story.coverUrl,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
