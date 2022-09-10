import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/data/models/tvseries_detail_model.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tvseries_detail.json'));
      // act
      final result = TvseriesDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, testTvseriesDetailResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = testTvseriesDetailResponse.toJson();

      // assert
      expect(result, testTvseriesDetailResponseMap);
    });
  });
}
