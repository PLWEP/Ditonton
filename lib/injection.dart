import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:core/utils/network_info.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:movie/presentation/bloc/movie/movie_bloc.dart';
import 'package:movie/presentation/bloc/moviedetail/moviedetail_bloc.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status_movie.dart';
import 'package:movie/domain/usecases/remove_watchlist_movie.dart';
import 'package:movie/domain/usecases/save_watchlist_movie.dart';
import 'package:search/presentation/bloc/movie/search_movie_bloc.dart';
import 'package:search/presentation/bloc/tvseries/search_tvseries_bloc.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tvseries.dart';
import 'package:tvseries/presentation/bloc/tvseries/tvseries_bloc.dart';
import 'package:tvseries/presentation/bloc/tvseriesdetail/tvseriesdetail_bloc.dart';
import 'package:tvseries/data/datasources/tvseries_local_data_source.dart';
import 'package:tvseries/data/datasources/tvseries_remote_data_source.dart';
import 'package:tvseries/data/repositories/tvseries_repository_impl.dart';
import 'package:tvseries/domain/repositories/tvseries_repository.dart';
import 'package:tvseries/domain/usecases/get_now_playing_tvseries.dart';
import 'package:tvseries/domain/usecases/get_popular_tvseries.dart';
import 'package:tvseries/domain/usecases/get_top_rated_tvseries.dart';
import 'package:tvseries/domain/usecases/get_tvseries_detail.dart';
import 'package:tvseries/domain/usecases/get_tvseries_recommendations.dart';
import 'package:tvseries/domain/usecases/get_watchlist_status_tvseries.dart';
import 'package:tvseries/domain/usecases/get_watchlist_tvseries.dart';
import 'package:tvseries/domain/usecases/remove_watchlist_tvseries.dart';
import 'package:tvseries/domain/usecases/save_watchlist_tvseries.dart';

final locator = GetIt.instance;

void init() {
  // provider

  // Movie
  locator.registerFactory(
    () => MovieBloc(locator()),
  );
  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => RecommendationMoviesBloc(locator()),
  );
  locator.registerFactory(
    () => PopularMovieBloc(locator()),
  );
  locator.registerFactory(
    () => TopRatedMovieBloc(locator()),
  );
  locator.registerFactory(
    () => WatchlistMovieBloc(locator()),
  );
  locator.registerFactory(
    () => SearchMovieBloc(
      locator(),
    ),
  );

  // Tvseries
  locator.registerFactory(
    () => TvseriesBloc(locator()),
  );
  locator.registerFactory(
    () => TvseriesDetailBloc(
      getTvseriesDetail: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => RecommendationTvseriesBloc(locator()),
  );
  locator.registerFactory(
    () => PopularTvseriesBloc(locator()),
  );
  locator.registerFactory(
    () => TopRatedTvseriesBloc(locator()),
  );
  locator.registerFactory(
    () => WatchlistTvseriesBloc(locator()),
  );
  locator.registerFactory(
    () => SearchTvseriesBloc(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusMovie(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTvseries(locator()));
  locator.registerLazySingleton(() => GetPopularTvseries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvseries(locator()));
  locator.registerLazySingleton(() => GetTvseriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvseriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvseries(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvseries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvseries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvseries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvseries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  locator.registerLazySingleton<TvseriesRepository>(
    () => TvseriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvseriesRemoteDataSource>(
      () => TvseriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvseriesLocalDataSource>(
      () => TvseriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
