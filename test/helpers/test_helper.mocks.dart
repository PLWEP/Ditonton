// Mocks generated by Mockito 5.3.0 from annotations
// in ditonton/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:convert' as _i20;
import 'dart:typed_data' as _i21;

import 'package:dartz/dartz.dart' as _i2;
import 'package:ditonton/common/failure.dart' as _i7;
import 'package:ditonton/common/network_info.dart' as _i19;
import 'package:ditonton/data/datasources/db/database_helper.dart' as _i17;
import 'package:ditonton/data/datasources/movie_local_data_source.dart' as _i15;
import 'package:ditonton/data/datasources/movie_remote_data_source.dart'
    as _i13;
import 'package:ditonton/data/models/movie/movie_detail_model.dart' as _i3;
import 'package:ditonton/data/models/movie/movie_model.dart' as _i14;
import 'package:ditonton/data/models/movie/movie_table.dart' as _i16;
import 'package:ditonton/domain/entities/movie.dart' as _i8;
import 'package:ditonton/domain/entities/movie_detail.dart' as _i9;
import 'package:ditonton/domain/entities/tvseries.dart' as _i11;
import 'package:ditonton/domain/entities/tvseries_detail.dart' as _i12;
import 'package:ditonton/domain/repositories/movie_repository.dart' as _i5;
import 'package:ditonton/domain/repositories/tvseries_repository.dart' as _i10;
import 'package:http/http.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i18;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeMovieDetailResponse_1 extends _i1.SmartFake
    implements _i3.MovieDetailResponse {
  _FakeMovieDetailResponse_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeResponse_2 extends _i1.SmartFake implements _i4.Response {
  _FakeResponse_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeStreamedResponse_3 extends _i1.SmartFake
    implements _i4.StreamedResponse {
  _FakeStreamedResponse_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i5.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
                      _FakeEither_0<_i7.Failure, List<_i8.Movie>>(
                          this, Invocation.method(#getNowPlayingMovies, []))))
          as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
              returnValue:
                  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
                      _FakeEither_0<_i7.Failure, List<_i8.Movie>>(
                          this, Invocation.method(#getPopularMovies, []))))
          as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
              returnValue:
                  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
                      _FakeEither_0<_i7.Failure, List<_i8.Movie>>(
                          this, Invocation.method(#getTopRatedMovies, []))))
          as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, _i9.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue:
                  _i6.Future<_i2.Either<_i7.Failure, _i9.MovieDetail>>.value(
                      _FakeEither_0<_i7.Failure, _i9.MovieDetail>(
                          this, Invocation.method(#getMovieDetail, [id]))))
          as _i6.Future<_i2.Either<_i7.Failure, _i9.MovieDetail>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
                      _FakeEither_0<_i7.Failure, List<_i8.Movie>>(this,
                          Invocation.method(#getMovieRecommendations, [id]))))
          as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
                      _FakeEither_0<_i7.Failure, List<_i8.Movie>>(
                          this, Invocation.method(#searchMovies, [query]))))
          as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> saveWatchlist(
          _i9.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie]),
              returnValue: _i6.Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>(
                      this, Invocation.method(#saveWatchlist, [movie]))))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> removeWatchlist(
          _i9.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: _i6.Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>(
                      this, Invocation.method(#removeWatchlist, [movie]))))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: _i6.Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue:
                  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
                      _FakeEither_0<_i7.Failure, List<_i8.Movie>>(
                          this, Invocation.method(#getWatchlistMovies, []))))
          as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
}

/// A class which mocks [TvseriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvseriesRepository extends _i1.Mock
    implements _i10.TvseriesRepository {
  MockTvseriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.Tvseries>>>
      getNowPlayingTvseries() => (super.noSuchMethod(
          Invocation.method(#getNowPlayingTvseries, []),
          returnValue:
              _i6.Future<_i2.Either<_i7.Failure, List<_i11.Tvseries>>>.value(
                  _FakeEither_0<_i7.Failure, List<_i11.Tvseries>>(this,
                      Invocation.method(#getNowPlayingTvseries, [])))) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i11.Tvseries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.Tvseries>>>
      getPopularTvseries() => (super.noSuchMethod(
          Invocation.method(#getPopularTvseries, []),
          returnValue:
              _i6.Future<_i2.Either<_i7.Failure, List<_i11.Tvseries>>>.value(
                  _FakeEither_0<_i7.Failure, List<_i11.Tvseries>>(
                      this, Invocation.method(#getPopularTvseries, [])))) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i11.Tvseries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.Tvseries>>>
      getTopRatedTvseries() => (super.noSuchMethod(
          Invocation.method(#getTopRatedTvseries, []),
          returnValue:
              _i6.Future<_i2.Either<_i7.Failure, List<_i11.Tvseries>>>.value(
                  _FakeEither_0<_i7.Failure, List<_i11.Tvseries>>(this,
                      Invocation.method(#getTopRatedTvseries, [])))) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i11.Tvseries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, _i12.TvseriesDetail>> getTvseriesDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvseriesDetail, [id]),
          returnValue:
              _i6.Future<_i2.Either<_i7.Failure, _i12.TvseriesDetail>>.value(
                  _FakeEither_0<_i7.Failure, _i12.TvseriesDetail>(this,
                      Invocation.method(#getTvseriesDetail, [id])))) as _i6
          .Future<_i2.Either<_i7.Failure, _i12.TvseriesDetail>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.Tvseries>>>
      getTvseriesRecommendations(int? id) => (super.noSuchMethod(
              Invocation.method(#getTvseriesRecommendations, [id]),
              returnValue:
                  _i6.Future<_i2.Either<_i7.Failure, List<_i11.Tvseries>>>.value(
                      _FakeEither_0<_i7.Failure, List<_i11.Tvseries>>(this,
                          Invocation.method(#getTvseriesRecommendations, [id]))))
          as _i6.Future<_i2.Either<_i7.Failure, List<_i11.Tvseries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.Tvseries>>> searchTvseries(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvseries, [query]),
          returnValue:
              _i6.Future<_i2.Either<_i7.Failure, List<_i11.Tvseries>>>.value(
                  _FakeEither_0<_i7.Failure, List<_i11.Tvseries>>(this,
                      Invocation.method(#searchTvseries, [query])))) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i11.Tvseries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> saveWatchlist(
          _i12.TvseriesDetail? tvseries) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [tvseries]),
              returnValue: _i6.Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>(
                      this, Invocation.method(#saveWatchlist, [tvseries]))))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> removeWatchlist(
          _i12.TvseriesDetail? tvseries) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tvseries]),
              returnValue: _i6.Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>(
                      this, Invocation.method(#removeWatchlist, [tvseries]))))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: _i6.Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.Tvseries>>>
      getWatchlistTvseries() => (super.noSuchMethod(
          Invocation.method(#getWatchlistTvseries, []),
          returnValue:
              _i6.Future<_i2.Either<_i7.Failure, List<_i11.Tvseries>>>.value(
                  _FakeEither_0<_i7.Failure, List<_i11.Tvseries>>(this,
                      Invocation.method(#getWatchlistTvseries, [])))) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i11.Tvseries>>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i13.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<_i14.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  _i6.Future<List<_i14.MovieModel>>.value(<_i14.MovieModel>[]))
          as _i6.Future<List<_i14.MovieModel>>);
  @override
  _i6.Future<List<_i14.MovieModel>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
              returnValue:
                  _i6.Future<List<_i14.MovieModel>>.value(<_i14.MovieModel>[]))
          as _i6.Future<List<_i14.MovieModel>>);
  @override
  _i6.Future<List<_i14.MovieModel>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
              returnValue:
                  _i6.Future<List<_i14.MovieModel>>.value(<_i14.MovieModel>[]))
          as _i6.Future<List<_i14.MovieModel>>);
  @override
  _i6.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue: _i6.Future<_i3.MovieDetailResponse>.value(
                  _FakeMovieDetailResponse_1(
                      this, Invocation.method(#getMovieDetail, [id]))))
          as _i6.Future<_i3.MovieDetailResponse>);
  @override
  _i6.Future<List<_i14.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  _i6.Future<List<_i14.MovieModel>>.value(<_i14.MovieModel>[]))
          as _i6.Future<List<_i14.MovieModel>>);
  @override
  _i6.Future<List<_i14.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  _i6.Future<List<_i14.MovieModel>>.value(<_i14.MovieModel>[]))
          as _i6.Future<List<_i14.MovieModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i15.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<String> insertWatchlist(_i16.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: _i6.Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<String> removeWatchlist(_i16.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: _i6.Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<_i16.MovieTable?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: _i6.Future<_i16.MovieTable?>.value())
          as _i6.Future<_i16.MovieTable?>);
  @override
  _i6.Future<List<_i16.MovieTable>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue:
                  _i6.Future<List<_i16.MovieTable>>.value(<_i16.MovieTable>[]))
          as _i6.Future<List<_i16.MovieTable>>);
  @override
  _i6.Future<void> cacheNowPlayingMovies(List<_i16.MovieTable>? movies) =>
      (super.noSuchMethod(Invocation.method(#cacheNowPlayingMovies, [movies]),
              returnValue: _i6.Future<void>.value(),
              returnValueForMissingStub: _i6.Future<void>.value())
          as _i6.Future<void>);
  @override
  _i6.Future<List<_i16.MovieTable>> getCachedNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getCachedNowPlayingMovies, []),
              returnValue:
                  _i6.Future<List<_i16.MovieTable>>.value(<_i16.MovieTable>[]))
          as _i6.Future<List<_i16.MovieTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i17.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i18.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: _i6.Future<_i18.Database?>.value())
          as _i6.Future<_i18.Database?>);
  @override
  _i6.Future<void> insertCacheTransaction(
          List<_i16.MovieTable>? movies, String? category) =>
      (super.noSuchMethod(
              Invocation.method(#insertCacheTransaction, [movies, category]),
              returnValue: _i6.Future<void>.value(),
              returnValueForMissingStub: _i6.Future<void>.value())
          as _i6.Future<void>);
  @override
  _i6.Future<List<Map<String, dynamic>>> getCacheMovies(String? category) =>
      (super.noSuchMethod(Invocation.method(#getCacheMovies, [category]),
              returnValue: _i6.Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i6.Future<List<Map<String, dynamic>>>);
  @override
  _i6.Future<int> clearCache(String? category) =>
      (super.noSuchMethod(Invocation.method(#clearCache, [category]),
          returnValue: _i6.Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<int> insertWatchlist(_i16.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: _i6.Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<int> removeWatchlist(_i16.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: _i6.Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: _i6.Future<Map<String, dynamic>?>.value())
          as _i6.Future<Map<String, dynamic>?>);
  @override
  _i6.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue: _i6.Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i6.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i19.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: _i6.Future<bool>.value(false)) as _i6.Future<bool>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i4.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i4.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
                  this, Invocation.method(#head, [url], {#headers: headers}))))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
                  this, Invocation.method(#get, [url], {#headers: headers}))))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i20.Encoding? encoding}) =>
      (super
          .noSuchMethod(Invocation.method(#post, [url], {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
                  this,
                  Invocation.method(#post, [
                    url
                  ], {
                    #headers: headers,
                    #body: body,
                    #encoding: encoding
                  })))) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i20.Encoding? encoding}) =>
      (super
          .noSuchMethod(Invocation.method(#put, [url], {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
                  this,
                  Invocation.method(#put, [
                    url
                  ], {
                    #headers: headers,
                    #body: body,
                    #encoding: encoding
                  })))) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i20.Encoding? encoding}) =>
      (super
          .noSuchMethod(Invocation.method(#patch, [url], {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
                  this,
                  Invocation.method(#patch, [
                    url
                  ], {
                    #headers: headers,
                    #body: body,
                    #encoding: encoding
                  })))) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i20.Encoding? encoding}) =>
      (super
          .noSuchMethod(Invocation.method(#delete, [url], {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
                  this,
                  Invocation.method(#delete, [
                    url
                  ], {
                    #headers: headers,
                    #body: body,
                    #encoding: encoding
                  })))) as _i6.Future<_i4.Response>);
  @override
  _i6.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: _i6.Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<_i21.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: _i6.Future<_i21.Uint8List>.value(_i21.Uint8List(0)))
          as _i6.Future<_i21.Uint8List>);
  @override
  _i6.Future<_i4.StreamedResponse> send(_i4.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue: _i6.Future<_i4.StreamedResponse>.value(
                  _FakeStreamedResponse_3(
                      this, Invocation.method(#send, [request]))))
          as _i6.Future<_i4.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}
