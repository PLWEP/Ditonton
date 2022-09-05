import 'dart:async';

import 'package:core/data/models/movie/movie_table.dart';
import 'package:core/data/models/tvseries/tvseries_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlist = 'watchlist';
  static const String _tblCache = 'cache';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        type TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblCache (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        category TEXT,
        type TEXT
      );
    ''');
  }

  Future<void> insertMovieCacheTransaction(
      List<MovieTable> movies, String category) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final movie in movies) {
        final movieJson = movie.toJson();
        movieJson['category'] = category;
        movieJson['type'] = "movie";
        txn.insert(_tblCache, movieJson);
      }
    });
  }

  Future<void> insertTvseriesCacheTransaction(
      List<TvseriesTable> tvseries, String category) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final tvseries in tvseries) {
        final tvseriesJson = tvseries.toJson();
        tvseriesJson['category'] = category;
        tvseriesJson['type'] = "tvseries";
        txn.insert(_tblCache, tvseriesJson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCache(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblCache,
      where: 'category = ?',
      whereArgs: [category],
    );

    return results;
  }

  Future<int> clearCache(String category) async {
    final db = await database;
    return await db!.delete(
      _tblCache,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<int> insertMovieWatchlist(MovieTable movie) async {
    final db = await database;
    final movieJson = movie.toJson();
    movieJson['type'] = 'movie';
    return await db!.insert(_tblWatchlist, movieJson);
  }

  Future<int> removeMovieWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ? and type = "movie" ',
      whereArgs: [movie.id],
    );
  }

  Future<int> insertTvseriesWatchlist(TvseriesTable tvseries) async {
    final db = await database;

    final tvseriesJson = tvseries.toJson();
    tvseriesJson['type'] = 'tvseries';
    return await db!.insert(_tblWatchlist, tvseriesJson);
  }

  Future<int> removeTvseriesWatchlist(TvseriesTable tvseries) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ? and type = "tvseries"',
      whereArgs: [tvseries.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ? and type = "movie"',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovie() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblWatchlist,
      where: 'type = "movie"',
    );

    return results;
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvseries() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblWatchlist,
      where: 'type = "tvseries"',
    );

    return results;
  }

  Future<Map<String, dynamic>?> getTvseriesById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ? and type = "tvseries"',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }
}
