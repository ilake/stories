import 'package:flutter/material.dart';

import "./widgets/story_card.dart";
import "./models/story.dart";

void main() => runApp(StoriesApp());

class StoriesApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StoriesPage(),
    );
  }
}

class StoriesPage extends StatelessWidget {
  List<Widget> _buildstories() {
    return [1, 2, 3].map((i) {
      return StoryCard(
        Story(
          id: i.toString(),
          title: "Title $i",
          pages: [
            Page(
              number: 1,
              url: "https://cdn-images-1.medium.com/max/2000/1*b1T9PtMK3bxboKvnSctNmg.jpeg",
            ),
            Page(
              number: 2,
              url: "https://pi.tedcdn.com/r/talkstar-assets.s3.amazonaws.com/production/playlists/playlist_62/how_to_tell_a_story_update_1200x627.jpg",
            ),
          ],
        ),
      );
    }).toList();
  }


  StoriesPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stories"),
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          children: _buildstories(),
        ),
      ),
    );
  }
}
