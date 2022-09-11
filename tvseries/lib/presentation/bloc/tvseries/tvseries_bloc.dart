import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/domain/entities/tvseries.dart';
import 'package:tvseries/domain/usecases/get_now_playing_tvseries.dart';
import 'package:tvseries/domain/usecases/get_popular_tvseries.dart';
import 'package:tvseries/domain/usecases/get_top_rated_tvseries.dart';
import 'package:tvseries/domain/usecases/get_tvseries_recommendations.dart';
import 'package:tvseries/domain/usecases/get_watchlist_tvseries.dart';

part 'tvseries_event.dart';
part 'tvseries_state.dart';

class TvseriesBloc extends Bloc<TvseriesEvent, TvseriesState> {
  final GetNowPlayingTvseries _getNowPlayingTvseries;

  TvseriesBloc(this._getNowPlayingTvseries) : super(EmptyData()) {
    on<FetchTvseriesData>((event, emit) async {
      emit(LoadingData());
      final result = await _getNowPlayingTvseries.execute();

      result.fold(
        (failure) {
          emit(ErrorData(failure.message));
        },
        (data) {
          emit(LoadedData(data));
        },
      );
    });
  }
}

class PopularTvseriesBloc extends Bloc<TvseriesEvent, TvseriesState> {
  final GetPopularTvseries _getPopularTvseries;
  PopularTvseriesBloc(this._getPopularTvseries) : super(EmptyData()) {
    on<FetchTvseriesData>((event, emit) async {
      emit(LoadingData());
      final result = await _getPopularTvseries.execute();

      result.fold(
        (failure) {
          emit(ErrorData(failure.message));
        },
        (data) {
          emit(LoadedData(data));
        },
      );
    });
  }
}

class TopRatedTvseriesBloc extends Bloc<TvseriesEvent, TvseriesState> {
  final GetTopRatedTvseries _getTopRatedTvseries;
  TopRatedTvseriesBloc(this._getTopRatedTvseries) : super(EmptyData()) {
    on<FetchTvseriesData>((event, emit) async {
      emit(LoadingData());
      final result = await _getTopRatedTvseries.execute();

      result.fold(
        (failure) {
          emit(ErrorData(failure.message));
        },
        (data) {
          emit(LoadedData(data));
        },
      );
    });
  }
}

class WatchlistTvseriesBloc extends Bloc<TvseriesEvent, TvseriesState> {
  final GetWatchlistTvseries _getWatchlistTvseries;
  WatchlistTvseriesBloc(this._getWatchlistTvseries) : super(EmptyData()) {
    on<FetchTvseriesData>((event, emit) async {
      emit(LoadingData());
      final result = await _getWatchlistTvseries.execute();

      result.fold(
        (failure) {
          emit(ErrorData(failure.message));
        },
        (data) {
          emit(LoadedData(data));
        },
      );
    });
  }
}

class RecommendationTvseriesBloc extends Bloc<TvseriesEvent, TvseriesState> {
  final GetTvseriesRecommendations _getTvseriesRecommendations;

  RecommendationTvseriesBloc(
    this._getTvseriesRecommendations,
  ) : super(EmptyData()) {
    on<FetchTvseriesDataWithId>((event, emit) async {
      final id = event.id;
      emit(LoadingData());
      final result = await _getTvseriesRecommendations.execute(id);

      result.fold(
        (failure) {
          emit(ErrorData(failure.message));
        },
        (data) {
          emit(LoadedData(data));
        },
      );
    });
  }
}
