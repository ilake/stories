// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const StatusType _$normal = const StatusType._('normal');
const StatusType _$vip = const StatusType._('vip');

StatusType _$statusTypeValueOf(String name) {
  switch (name) {
    case 'normal':
      return _$normal;
    case 'vip':
      return _$vip;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<StatusType> _$statusTypeValues =
    new BuiltSet<StatusType>(const <StatusType>[
  _$normal,
  _$vip,
]);

Serializer<Home> _$homeSerializer = new _$HomeSerializer();
Serializer<Story> _$storySerializer = new _$StorySerializer();
Serializer<Page> _$pageSerializer = new _$PageSerializer();
Serializer<StatusType> _$statusTypeSerializer = new _$StatusTypeSerializer();

class _$HomeSerializer implements StructuredSerializer<Home> {
  @override
  final Iterable<Type> types = const [Home, _$Home];
  @override
  final String wireName = 'Home';

  @override
  Iterable serialize(Serializers serializers, Home object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'stories',
      serializers.serialize(object.stories,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Story)])),
    ];

    return result;
  }

  @override
  Home deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HomeBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'stories':
          result.stories.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Story)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$StorySerializer implements StructuredSerializer<Story> {
  @override
  final Iterable<Type> types = const [Story, _$Story];
  @override
  final String wireName = 'Story';

  @override
  Iterable serialize(Serializers serializers, Story object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'position',
      serializers.serialize(object.position,
          specifiedType: const FullType(int)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'public',
      serializers.serialize(object.public, specifiedType: const FullType(bool)),
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(StatusType)),
    ];
    if (object.pages != null) {
      result
        ..add('pages')
        ..add(serializers.serialize(object.pages,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Page)])));
    }

    return result;
  }

  @override
  Story deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new StoryBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'pages':
          result.pages.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Page)]))
              as BuiltList);
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'position':
          result.position = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'public':
          result.public = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(StatusType)) as StatusType;
          break;
      }
    }

    return result.build();
  }
}

class _$PageSerializer implements StructuredSerializer<Page> {
  @override
  final Iterable<Type> types = const [Page, _$Page];
  @override
  final String wireName = 'Page';

  @override
  Iterable serialize(Serializers serializers, Page object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
      'number',
      serializers.serialize(object.number, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  Page deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'number':
          result.number = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$StatusTypeSerializer implements PrimitiveSerializer<StatusType> {
  @override
  final Iterable<Type> types = const <Type>[StatusType];
  @override
  final String wireName = 'StatusType';

  @override
  Object serialize(Serializers serializers, StatusType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  StatusType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      StatusType.valueOf(serialized as String);
}

class _$Home extends Home {
  @override
  final BuiltList<Story> stories;

  factory _$Home([void updates(HomeBuilder b)]) =>
      (new HomeBuilder()..update(updates)).build();

  _$Home._({this.stories}) : super._() {
    if (stories == null) {
      throw new BuiltValueNullFieldError('Home', 'stories');
    }
  }

  @override
  Home rebuild(void updates(HomeBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  HomeBuilder toBuilder() => new HomeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Home && stories == other.stories;
  }

  @override
  int get hashCode {
    return $jf($jc(0, stories.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Home')..add('stories', stories))
        .toString();
  }
}

class HomeBuilder implements Builder<Home, HomeBuilder> {
  _$Home _$v;

  ListBuilder<Story> _stories;
  ListBuilder<Story> get stories =>
      _$this._stories ??= new ListBuilder<Story>();
  set stories(ListBuilder<Story> stories) => _$this._stories = stories;

  HomeBuilder();

  HomeBuilder get _$this {
    if (_$v != null) {
      _stories = _$v.stories?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Home other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Home;
  }

  @override
  void update(void updates(HomeBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Home build() {
    _$Home _$result;
    try {
      _$result = _$v ?? new _$Home._(stories: stories.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'stories';
        stories.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Home', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Story extends Story {
  @override
  final BuiltList<Page> pages;
  @override
  final String id;
  @override
  final int position;
  @override
  final String title;
  @override
  final bool public;
  @override
  final StatusType status;

  factory _$Story([void updates(StoryBuilder b)]) =>
      (new StoryBuilder()..update(updates)).build();

  _$Story._(
      {this.pages,
      this.id,
      this.position,
      this.title,
      this.public,
      this.status})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Story', 'id');
    }
    if (position == null) {
      throw new BuiltValueNullFieldError('Story', 'position');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Story', 'title');
    }
    if (public == null) {
      throw new BuiltValueNullFieldError('Story', 'public');
    }
    if (status == null) {
      throw new BuiltValueNullFieldError('Story', 'status');
    }
  }

  @override
  Story rebuild(void updates(StoryBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  StoryBuilder toBuilder() => new StoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Story &&
        pages == other.pages &&
        id == other.id &&
        position == other.position &&
        title == other.title &&
        public == other.public &&
        status == other.status;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, pages.hashCode), id.hashCode),
                    position.hashCode),
                title.hashCode),
            public.hashCode),
        status.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Story')
          ..add('pages', pages)
          ..add('id', id)
          ..add('position', position)
          ..add('title', title)
          ..add('public', public)
          ..add('status', status))
        .toString();
  }
}

class StoryBuilder implements Builder<Story, StoryBuilder> {
  _$Story _$v;

  ListBuilder<Page> _pages;
  ListBuilder<Page> get pages => _$this._pages ??= new ListBuilder<Page>();
  set pages(ListBuilder<Page> pages) => _$this._pages = pages;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  int _position;
  int get position => _$this._position;
  set position(int position) => _$this._position = position;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  bool _public;
  bool get public => _$this._public;
  set public(bool public) => _$this._public = public;

  StatusType _status;
  StatusType get status => _$this._status;
  set status(StatusType status) => _$this._status = status;

  StoryBuilder();

  StoryBuilder get _$this {
    if (_$v != null) {
      _pages = _$v.pages?.toBuilder();
      _id = _$v.id;
      _position = _$v.position;
      _title = _$v.title;
      _public = _$v.public;
      _status = _$v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Story other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Story;
  }

  @override
  void update(void updates(StoryBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Story build() {
    _$Story _$result;
    try {
      _$result = _$v ??
          new _$Story._(
              pages: _pages?.build(),
              id: id,
              position: position,
              title: title,
              public: public,
              status: status);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'pages';
        _pages?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Story', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Page extends Page {
  @override
  final String url;
  @override
  final int number;

  factory _$Page([void updates(PageBuilder b)]) =>
      (new PageBuilder()..update(updates)).build();

  _$Page._({this.url, this.number}) : super._() {
    if (url == null) {
      throw new BuiltValueNullFieldError('Page', 'url');
    }
    if (number == null) {
      throw new BuiltValueNullFieldError('Page', 'number');
    }
  }

  @override
  Page rebuild(void updates(PageBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  PageBuilder toBuilder() => new PageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Page && url == other.url && number == other.number;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, url.hashCode), number.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Page')
          ..add('url', url)
          ..add('number', number))
        .toString();
  }
}

class PageBuilder implements Builder<Page, PageBuilder> {
  _$Page _$v;

  String _url;
  String get url => _$this._url;
  set url(String url) => _$this._url = url;

  int _number;
  int get number => _$this._number;
  set number(int number) => _$this._number = number;

  PageBuilder();

  PageBuilder get _$this {
    if (_$v != null) {
      _url = _$v.url;
      _number = _$v.number;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Page other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Page;
  }

  @override
  void update(void updates(PageBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Page build() {
    final _$result = _$v ?? new _$Page._(url: url, number: number);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
