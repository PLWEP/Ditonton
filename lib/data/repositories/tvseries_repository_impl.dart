import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/network_info.dart';
import 'package:ditonton/data/datasources/tvseries_local_data_source.dart';
import 'package:ditonton/data/datasources/tvseries_remote_data_source.dart';
import 'package:ditonton/data/models/tvseries/tvseries_table.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class TvseriesRepositoryImpl implements TvseriesRepository {
  final TvseriesRemoteDataSource remoteDataSource;
  final TvseriesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TvseriesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Tvseries>>> getNowPlayingTvseries() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getNowPlayingTvseries();
        localDataSource.cacheNowPlayingTvseries(
            result.map((tvseries) => TvseriesTable.fromDTO(tvseries)).toList());
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      try {
        final result = await localDataSource.getCachedNowPlayingTvseries();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, TvseriesDetail>> getTvseriesDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvseriesDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tvseries>>> getTvseriesRecommendations(
      int id) async {
    try {
      final result = await remoteDataSource.getTvseriesRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tvseries>>> getPopularTvseries() async {
    try {
      final result = await remoteDataSource.getPopularTvseries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tvseries>>> getTopRatedTvseries() async {
    try {
      final result = await remoteDataSource.getTopRatedTvseries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tvseries>>> searchTvseries(String query) async {
    try {
      final result = await remoteDataSource.searchTvseries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TvseriesDetail tvseries) async {
    try {
      final result = await localDataSource
          .insertWatchlist(TvseriesTable.fromEntity(tvseries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(
      TvseriesDetail tvseries) async {
    try {
      final result = await localDataSource
          .removeWatchlist(TvseriesTable.fromEntity(tvseries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getTvseriesById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Tvseries>>> getWatchlistTvseries() async {
    final result = await localDataSource.getWatchlistTvseries();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
