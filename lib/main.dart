import 'dart:async';
import "dart:convert";
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

import "package:stories/widgets/story_card.dart";
import "package:stories/models/home.dart";
import "package:stories/models/serializers.dart";
import "package:stories/pages/story_page.dart";

void main() => runApp(StoriesApp());

List<Story> storyList = [];

class StoriesApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stories',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        "/": (BuildContext context) => StoriesPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split("/");

        if (pathElements[0] != "") {
          return null;
        }

        if (pathElements[1] == "story") {
          final String storyId = pathElements[2];
          final Story story =
              storyList.firstWhere((Story _story) => _story.id == storyId);
          return MaterialPageRoute(builder: (BuildContext context) {
            return StoryPage(story);
          });
        }
      },
    );
  }
}

class StoriesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StoriesPageState();
  }
}

class _StoriesPageState extends State<StoriesPage> {
  List<StoryCard> storyCards = [];

  void initState() {
    super.initState();
    _fetchStories();
  }

  Future<void> _fetchStories() async {
    http.Response response =
        await http.get("https://stories-4ea69.firebaseio.com/home.json");
    Home home = serializers.deserializeWith(
        Home.serializer, json.decode(response.body));

    storyList = home.stories.toList()
      ..where((Story story) => story.public)
      ..sort((a, b) => a.position.compareTo(b.position));

    List<StoryCard> storyCardList =
        storyList.map((Story story) => StoryCard(story)).toList();

    if (mounted) {
      setState(() {
        storyCards = storyCardList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stories"),
      ),
      body: SafeArea(
        child: GridView.builder(
          itemCount: storyCards.length,
          itemBuilder: (BuildContext context, int index) {
            return storyCards[index];
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            childAspectRatio: 1.2,
          ),
        ),
      ),
    );
  }
}
