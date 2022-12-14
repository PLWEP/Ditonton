import 'dart:convert';

import 'package:tvseries/data/models/tvseries_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_air.json'));
      // act
      final result = TvseriesResponse.fromJson(jsonMap);
      // assert
      expect(result, testTvseriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = testTvseriesResponseModel.toJson();

      // assert
      expect(result, testTvseriesResponseModelMap);
    });
  });
}
