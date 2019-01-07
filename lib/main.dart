import 'package:flutter/material.dart';
import "dart:math";

import "./widgets/story_card.dart";
import "./models/story.dart";

void main() => runApp(StoriesApp());

class StoriesApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stories',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StoriesPage(),
    );
  }
}

class StoriesPage extends StatelessWidget {
  StoriesPage();

  Random random = Random();
  List<String> urls = [
    "https://firebrandtalent.com/wp-content/uploads/career-story.png",
    "https://i.ytimg.com/vi/TPLSfL5-Y3g/maxresdefault.jpg",
    "https://cdn-images-1.medium.com/max/2000/1*b1T9PtMK3bxboKvnSctNmg.jpeg"
  ];
  List<Widget> _buildstories() {
    return [1, 2, 3, 4, 5, 6, 7].map((i) {
      return StoryCard(
        Story(
          id: i.toString(),
          title: "Title $i",
          pages: [
            Page(
              number: 1,
              url: urls[random.nextInt(3)],
            ),
            Page(
              number: 2,
              url: urls[random.nextInt(3)],
            ),
            Page(
              number: 3,
              url: urls[random.nextInt(3)],
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stories"),
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 4,
          children: _buildstories(),
        ),
      ),
    );
  }
}
