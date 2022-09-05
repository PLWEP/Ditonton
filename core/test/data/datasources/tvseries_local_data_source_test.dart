import 'package:core/utils/exception.dart';
import 'package:core/data/datasources/tvseries_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvseriesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource =
        TvseriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTvseriesWatchlist(testTvseriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testTvseriesTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTvseriesWatchlist(testTvseriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testTvseriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvseriesWatchlist(testTvseriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testTvseriesTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvseriesWatchlist(testTvseriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testTvseriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tvseries Detail By Id', () {
    const tId = 1;

    test('should return Tvseries Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTvseriesById(tId))
          .thenAnswer((_) async => testTvseriesMap);
      // act
      final result = await dataSource.getTvseriesById(tId);
      // assert
      expect(result, testTvseriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvseriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvseriesById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist Tvseries', () {
    test('should return list of TvseriesTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvseries())
          .thenAnswer((_) async => [testTvseriesMap]);
      // act
      final result = await dataSource.getWatchlistTvseries();
      // assert
      expect(result, [testTvseriesTable]);
    });
  });

  group('cache now playing tvseries', () {
    test('should call database helper to save data', () async {
      // arrange
      when(mockDatabaseHelper.clearCache('now playing'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cacheNowPlayingTvseries([testTvseriesCache]);
      // assert
      verify(mockDatabaseHelper.clearCache('now playing'));
      verify(mockDatabaseHelper
          .insertTvseriesCacheTransaction([testTvseriesCache], 'now playing'));
    });

    test('should return list of Tvseries from db when data exist', () async {
      // arrange
      when(mockDatabaseHelper.getCache('now playing'))
          .thenAnswer((_) async => [testTvseriesCacheMap]);
      // act
      final result = await dataSource.getCachedNowPlayingTvseries();
      // assert
      expect(result, [testTvseriesCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper.getCache('now playing'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedNowPlayingTvseries();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}
