import 'dart:async';
import "dart:convert";
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

import "./widgets/story_card.dart";
import "./models/story.dart";
import "./pages/story_page.dart";

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
      final Story story = Story(
        id: storyId,
        public: storyData["public"],
        position: storyData["position"],
        title: storyData["title"],
        pages: pageList,
      );
      final storyCard = StoryCard(story);

      storyCardList.add(storyCard);
      storyList.add(story);
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
