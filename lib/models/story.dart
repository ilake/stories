import "package:flutter/material.dart";

class Story {
  final String id;
  final String title;
  final List<Page> pages;

  Story({
    @required this.id,
    @required this.title,
    @required this.pages,
  });

  String get coverUrl {
    return pages[0].url;
  }
}

class Page {
  final int number;
  final String url;

  Page({
    @required this.number,
    @required this.url,
  });
}