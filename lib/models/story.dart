import "package:flutter/material.dart";

class Story {
  final String id;
  final int position;
  final String title;
  final List<Page> pages;
  final bool public;

  Story({
    @required this.id,
    @required this.position,
    @required this.title,
    @required this.pages,
    @required this.public
  });

  String get coverUrl {
    return pages[0].url;
  }
}

class Page {
  final String url;
  final int number;

  Page({
    @required this.url,
    @required this.number,
  });
}