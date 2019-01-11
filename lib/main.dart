import "dart:convert";
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

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
        await http.get("https://stories-4ea69.firebaseio.com/stories.json");
    final Map<String, dynamic> storiesData = json.decode(response.body);

    List<StoryCard> storyCardList = [];

    storiesData.forEach((String storyId, dynamic storyData) {
      final List<Page> pageList = storyData["pages"].map<Page>((dynamic page) {
        return Page(
          url: page["url"],
          number: page["number"],
        );
      }).toList();
      pageList.sort((a, b) => a.number.compareTo(b.number));

      final storyCard = StoryCard(Story(
        id: storyId,
        public: storyData["public"],
        position: storyData["position"],
        title: storyData["title"],
        pages: pageList,
      ));

      storyCardList.add(storyCard);
    });

    storyCardList =
        storyCardList.where((StoryCard card) => card.story.public).toList();

    storyCardList.sort((a, b) => a.story.position.compareTo(b.story.position));

    setState(() {
      storyCards = storyCardList;
    });
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
          children: storyCards,
        ),
      ),
    );
  }
}
