import 'dart:convert';

import 'package:core/utils/exception.dart';
import 'package:core/data/models/tvseries/tvseries_detail_model.dart';
import 'package:core/data/models/tvseries/tvseries_model.dart';
import 'package:core/data/models/tvseries/tvseries_response.dart';
import 'package:http/http.dart' as http;

abstract class TvseriesRemoteDataSource {
  Future<List<TvseriesModel>> getNowPlayingTvseries();
  Future<List<TvseriesModel>> getPopularTvseries();
  Future<List<TvseriesModel>> getTopRatedTvseries();
  Future<TvseriesDetailResponse> getTvseriesDetail(int id);
  Future<List<TvseriesModel>> getTvseriesRecommendations(int id);
  Future<List<TvseriesModel>> searchTvseries(String query);
}

class TvseriesRemoteDataSourceImpl implements TvseriesRemoteDataSource {
  static const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const baseUrl = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvseriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvseriesModel>> getNowPlayingTvseries() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey'));

    if (response.statusCode == 200) {
      return TvseriesResponse.fromJson(json.decode(response.body)).tvseriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvseriesDetailResponse> getTvseriesDetail(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$id?$apiKey'));

    if (response.statusCode == 200) {
      return TvseriesDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvseriesModel>> getTvseriesRecommendations(int id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'));

    if (response.statusCode == 200) {
      return TvseriesResponse.fromJson(json.decode(response.body)).tvseriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvseriesModel>> getPopularTvseries() async {
    final response = await client.get(Uri.parse('$baseUrl/tv/popular?$apiKey'));

    if (response.statusCode == 200) {
      return TvseriesResponse.fromJson(json.decode(response.body)).tvseriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvseriesModel>> getTopRatedTvseries() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey'));

    if (response.statusCode == 200) {
      return TvseriesResponse.fromJson(json.decode(response.body)).tvseriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvseriesModel>> searchTvseries(String query) async {
    final response =
        await client.get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'));

    if (response.statusCode == 200) {
      return TvseriesResponse.fromJson(json.decode(response.body)).tvseriesList;
    } else {
      throw ServerException();
    }
  }
}
