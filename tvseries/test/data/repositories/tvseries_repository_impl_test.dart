import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:tvseries/data/models/tvseries_detail_model.dart';
import 'package:tvseries/data/models/tvseries_model.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:tvseries/data/models/tvseries_table.dart';
import 'package:tvseries/data/repositories/tvseries_repository_impl.dart';
import 'package:tvseries/domain/entities/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvseriesRepositoryImpl repository;
  late MockTvseriesRemoteDataSource mockRemoteDataSource;
  late MockTvseriesLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockTvseriesRemoteDataSource();
    mockLocalDataSource = MockTvseriesLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TvseriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tTvseriesModel = TvseriesModel(
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    popularity: 47.432451,
    id: 31917,
    backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
    voteAverage: 5.04,
    overview:
        "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
    firstAirDate: "2010-06-08",
    originCountry: ["US"],
    genresId: [18, 9648],
    originalLanguage: "en",
    voteCount: 133,
    name: "Pretty Little Liars",
    title: "Pretty Little Liars",
  );

  final tTvseries = Tvseries(
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    popularity: 47.432451,
    id: 31917,
    backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
    voteAverage: 5.04,
    overview:
        "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
    firstAirDate: "2010-06-08",
    originCountry: const ["US"],
    genresId: const [18, 9648],
    originalLanguage: "en",
    voteCount: 133,
    name: "Pretty Little Liars",
    title: "Pretty Little Liars",
  );

  final tTvseriesModelList = <TvseriesModel>[tTvseriesModel];
  final tTvseriesList = <Tvseries>[tTvseries];

  group('Now Playing Tvseries', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getNowPlayingTvseries())
          .thenAnswer((_) async => []);
      // act
      await repository.getNowPlayingTvseries();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingTvseries())
            .thenAnswer((_) async => tTvseriesModelList);
        // act
        final result = await repository.getNowPlayingTvseries();
        // assert
        verify(mockRemoteDataSource.getNowPlayingTvseries());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvseriesList);
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingTvseries())
            .thenAnswer((_) async => tTvseriesModelList);
        // act
        await repository.getNowPlayingTvseries();
        // assert
        verify(mockRemoteDataSource.getNowPlayingTvseries());
        verify(mockLocalDataSource.cacheNowPlayingTvseries(tTvseriesModelList
            .map((tvseries) => TvseriesTable.fromDTO(tvseries))
            .toList()));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingTvseries())
            .thenThrow(ServerException());
        // act
        final result = await repository.getNowPlayingTvseries();
        // assert
        verify(mockRemoteDataSource.getNowPlayingTvseries());
        expect(result, equals(const Left(ServerFailure(''))));
      });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        // arrange
        when(mockLocalDataSource.getCachedNowPlayingTvseries())
            .thenAnswer((_) async => [testTvseriesCache]);
        // act
        final result = await repository.getNowPlayingTvseries();
        // assert
        verify(mockLocalDataSource.getCachedNowPlayingTvseries());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvseriesFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedNowPlayingTvseries())
            .thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getNowPlayingTvseries();
        // assert
        verify(mockLocalDataSource.getCachedNowPlayingTvseries());
        expect(result, const Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Popular Tvseries', () {
    test('should return Tvseries list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvseries())
          .thenAnswer((_) async => tTvseriesModelList);
      // act
      final result = await repository.getPopularTvseries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvseriesList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvseries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvseries();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvseries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvseries();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Tvseries', () {
    test('should return Tvseries list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvseries())
          .thenAnswer((_) async => tTvseriesModelList);
      // act
      final result = await repository.getTopRatedTvseries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvseriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvseries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvseries();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvseries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvseries();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tvseries Detail', () {
    const tId = 1399;
    const tTvseriesResponse = TvseriesDetailResponse(
      backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
      genres: [GenreModel(id: 10765, name: "Sci-Fi & Fantasy")],
      id: 1399,
      numberOfEpisodes: 73,
      numberOfSeasons: 8,
      title: "Game of Thrones",
      overview:
          "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
      popularity: 369.594,
      posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
      status: "Ended",
      voteAverage: 8.3,
      voteCount: 11504,
      episodeRunTime: [60],
      firstAirDate: "2011-04-17",
      homepage: "http://www.hbo.com/game-of-thrones",
      inProduction: false,
      languages: ["en"],
      lastAirDate: "2019-05-19",
      name: "Game of Thrones",
      nextEpisodeToAir: false,
      originalLanguage: 'en',
      originCountry: ["US"],
      tagline: "Winter Is Coming",
      type: 'script',
    );

    test(
        'should return Tvseries data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvseriesDetail(tId))
          .thenAnswer((_) async => tTvseriesResponse);
      // act
      final result = await repository.getTvseriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvseriesDetail(tId));
      expect(result, equals(const Right(testTvseriesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvseriesDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvseriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvseriesDetail(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvseriesDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvseriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvseriesDetail(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tvseries Recommendations', () {
    final tTvseriesList = <TvseriesModel>[];
    const tId = 1;

    test('should return data (Tvseries list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvseriesRecommendations(tId))
          .thenAnswer((_) async => tTvseriesList);
      // act
      final result = await repository.getTvseriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvseriesRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvseriesList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvseriesRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvseriesRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvseriesRecommendations(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvseriesRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvseriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvseriesRecommendations(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Tvseries', () {
    const tQuery = 'Game Of Throne';

    test('should return Tvseries list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvseries(tQuery))
          .thenAnswer((_) async => tTvseriesModelList);
      // act
      final result = await repository.searchTvseries(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvseriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvseries(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvseries(tQuery);
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvseries(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvseries(tQuery);
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource
              .insertWatchlist(TvseriesTable.fromEntity(testTvseriesDetail)))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvseriesDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource
              .insertWatchlist(TvseriesTable.fromEntity(testTvseriesDetail)))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvseriesDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource
              .removeWatchlist(TvseriesTable.fromEntity(testTvseriesDetail)))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTvseriesDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource
              .removeWatchlist(TvseriesTable.fromEntity(testTvseriesDetail)))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvseriesDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockLocalDataSource.getTvseriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist Tvseries', () {
    test('should return list of Tvseries', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvseries())
          .thenAnswer((_) async => [testTvseriesTable]);
      // act
      final result = await repository.getWatchlistTvseries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvseries]);
    });
  });
}
