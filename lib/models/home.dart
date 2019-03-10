import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'home.g.dart';

abstract class Home implements Built<Home, HomeBuilder> {
  static Serializer<Home> get serializer => _$homeSerializer;
  BuiltList<Story> get stories;

  Home._();
  factory Home([updates(HomeBuilder b)]) = _$Home;
}

abstract class Story implements Built<Story, StoryBuilder> {
  static Serializer<Story> get serializer => _$storySerializer;
  @nullable
  BuiltList<Page> get pages;

  String get id;
  int get position;
  String get title;
  bool get public;
  StatusType get status;

  get coverUrl {
    return pages[0].url;
  }

  List<Page> get sortPages {
    pages.toList().sort((a, b) => a.number.compareTo(b.number));
    return pages.toList();
  }

  Story._();
  factory Story([updates(StoryBuilder b)]) = _$Story;
}

abstract class Page implements Built<Page, PageBuilder> {
  static Serializer<Page> get serializer => _$pageSerializer;
  String get url;
  int get number;

  Page._();
  factory Page([updates(PageBuilder b)]) = _$Page;
}

class StatusType extends EnumClass {
  static Serializer<StatusType> get serializer => _$statusTypeSerializer;

  const StatusType._(String name) : super(name);

  static const StatusType normal = _$normal;
  static const StatusType vip = _$vip;

  static BuiltSet<StatusType> get values => _$statusTypeValues;
  static StatusType valueOf(String name) => _$statusTypeValueOf(name);
}
