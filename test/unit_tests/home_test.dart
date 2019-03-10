import 'package:flutter_test/flutter_test.dart';
import "package:stories/models/home.dart";
import "package:stories/models/serializers.dart";
import "dart:convert";

void main() {
  test("Home", () {
    var jsonMap = '''{
      "stories": [
        {
          "id": "bar",
          "position": 1,
          "public": true,
          "title": "story2",
          "status": "vip",
          "pages": [
            {"number": 0, "url": "url1"},
            {"number": 1, "url": "url2"}
          ]
        }
      ]
    }
    ''';

    var encodedJson = json.decode(jsonMap);

    Home home = serializers.deserializeWith(Home.serializer, encodedJson);

    expect(home.stories.length, equals(1));
    expect(home.stories.first.pages.length, equals(2));
  });
}
