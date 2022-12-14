import 'package:core/data/datasources/db/database_helper.dart';
import 'package:tvseries/data/models/tvseries_table.dart';
import 'package:core/utils/exception.dart';

abstract class TvseriesLocalDataSource {
  Future<String> insertWatchlist(TvseriesTable tvseries);
  Future<String> removeWatchlist(TvseriesTable tvseries);
  Future<TvseriesTable?> getTvseriesById(int id);
  Future<List<TvseriesTable>> getWatchlistTvseries();
  Future<void> cacheNowPlayingTvseries(List<TvseriesTable> tvseries);
  Future<List<TvseriesTable>> getCachedNowPlayingTvseries();
}

class TvseriesLocalDataSourceImpl implements TvseriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvseriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<void> cacheNowPlayingTvseries(List<TvseriesTable> tvseries) async {
    await databaseHelper.clearCacheTvseries('now playing');
    await databaseHelper.insertTvseriesCacheTransaction(
        tvseries, 'now playing');
  }

  @override
  Future<List<TvseriesTable>> getCachedNowPlayingTvseries() async {
    final result = await databaseHelper.getCacheTvseries('now playing');
    if (result.isNotEmpty) {
      return result.map((data) => TvseriesTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<TvseriesTable?> getTvseriesById(int id) async {
    final result = await databaseHelper.getTvseriesById(id);
    if (result != null) {
      return TvseriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvseriesTable>> getWatchlistTvseries() async {
    final result = await databaseHelper.getWatchlistTvseries();
    return result.map((data) => TvseriesTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlist(TvseriesTable tvseries) async {
    try {
      await databaseHelper.insertTvseriesWatchlist(tvseries);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvseriesTable tvseries) async {
    try {
      await databaseHelper.removeTvseriesWatchlist(tvseries);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
