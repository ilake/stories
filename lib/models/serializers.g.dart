// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializers;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(Home.serializer)
      ..add(Page.serializer)
      ..add(StatusType.serializer)
      ..add(Story.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Page)]),
          () => new ListBuilder<Page>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Story)]),
          () => new ListBuilder<Story>()))
    .build();

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new