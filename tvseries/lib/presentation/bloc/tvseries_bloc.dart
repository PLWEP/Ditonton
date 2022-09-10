import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/tvseries_detail.dart';
import 'package:tvseries/domain/entities/tvseries.dart';
import 'package:tvseries/domain/usecases/get_now_playing_tvseries.dart';
import 'package:tvseries/domain/usecases/get_popular_tvseries.dart';
import 'package:tvseries/domain/usecases/get_top_rated_tvseries.dart';
import 'package:tvseries/domain/usecases/get_tvseries_detail.dart';
import 'package:tvseries/domain/usecases/get_tvseries_recommendations.dart';
import 'package:tvseries/domain/usecases/get_watchlist_status_tvseries.dart';
import 'package:tvseries/domain/usecases/get_watchlist_tvseries.dart';
import 'package:tvseries/domain/usecases/remove_watchlist_tvseries.dart';
import 'package:tvseries/domain/usecases/save_watchlist_tvseries.dart';

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
          emit(TvseriesHasData(data));
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
          emit(TvseriesHasData(data));
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
          emit(TvseriesHasData(data));
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
          emit(TvseriesHasData(data));
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
          emit(TvseriesHasData(data));
        },
      );
    });
  }
}

class TvseriesDetailBloc extends Bloc<TvseriesEvent, TvseriesDetailState> {
  final GetTvseriesDetail getTvseriesDetail;
  final GetWatchListStatusTvseries getWatchListStatus;
  final SaveWatchlistTvseries saveWatchlist;
  final RemoveWatchlistTvseries removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TvseriesDetailBloc({
    required this.getTvseriesDetail,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TvseriesDetailState.initial()) {
    on<FetchTvseriesDataWithId>((event, emit) async {
      emit(state.copyWith(state: LoadingData()));
      final detailResult = await getTvseriesDetail.execute(event.id);

      detailResult.fold(
        (failure) async {
          emit(state.copyWith(state: ErrorData(failure.message)));
        },
        (tvseries) async {
          emit(state.copyWith(
            state: LoadedData(),
            tvseriesDetail: tvseries,
          ));
        },
      );
    });
    on<AddWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.tvseriesDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      });

      add(LoadWatchlistStatus(event.tvseriesDetail.id));
    });
    on<RemoveWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.tvseriesDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      });

      add(LoadWatchlistStatus(event.tvseriesDetail.id));
    });
    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });
  }
}
