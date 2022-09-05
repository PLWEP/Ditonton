import 'dart:convert';
import 'dart:io';

import 'package:core/data/datasources/tvseries_remote_data_source.dart';
import 'package:core/utils/exception.dart';
import 'package:core/data/models/tvseries/tvseries_detail_model.dart';
import 'package:core/data/models/tvseries/tvseries_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late TvseriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvseriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing Tvseries', () {
    final tTvseriesList = TvseriesResponse.fromJson(
            json.decode(readJson('dummy_data/now_air.json')))
        .tvseriesList;

    test('should return list of Tvseries Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/now_air.json'), 200, headers: {
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=utf-8',
              }));
      // act
      final result = await dataSource.getNowPlayingTvseries();
      // assert
      expect(result, equals(tTvseriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingTvseries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tvseries', () {
    final tTvseriesList = TvseriesResponse.fromJson(
            json.decode(readJson('dummy_data/popular_tvseries.json')))
        .tvseriesList;

    test('should return list of Tvseries when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/popular_tvseries.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getPopularTvseries();
      // assert
      expect(result, tTvseriesList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTvseries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tvseries', () {
    final tTvseries = TvseriesResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_tvseries.json')))
        .tvseriesList;

    test('should return list of movies when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/top_rated_tvseries.json'), 200));
      // act
      final result = await dataSource.getTopRatedTvseries();
      // assert
      expect(result, tTvseries);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTvseries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Tvseries detail', () {
    const tId = 1;
    final tTvseriesDetail = TvseriesDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tvseries_detail.json')));

    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tvseries_detail.json'), 200));
      // act
      final result = await dataSource.getTvseriesDetail(tId);
      // assert
      expect(result, equals(tTvseriesDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvseriesDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Tvseries recommendations', () {
    final tTvseriesList = TvseriesResponse.fromJson(
            json.decode(readJson('dummy_data/tvseries_recommendations.json')))
        .tvseriesList;
    const tId = 1;

    test('should return list of Tvseries Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tvseries_recommendations.json'), 200));
      // act
      final result = await dataSource.getTvseriesRecommendations(tId);
      // assert
      expect(result, equals(tTvseriesList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvseriesRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search Tvseries', () {
    final tSearchResult = TvseriesResponse.fromJson(
            json.decode(readJson('dummy_data/search_got_tvseries.json')))
        .tvseriesList;
    const tQuery = 'Game of Thrones';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_got_tvseries.json'), 200));
      // act
      final result = await dataSource.searchTvseries(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTvseries(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
