import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/tvseries_detail.dart';
import 'package:tvseries/domain/usecases/get_tvseries_detail.dart';
import 'package:tvseries/domain/usecases/get_watchlist_status_tvseries.dart';
import 'package:tvseries/domain/usecases/remove_watchlist_tvseries.dart';
import 'package:tvseries/domain/usecases/save_watchlist_tvseries.dart';

part 'tvseriesdetail_event.dart';
part 'tvseriesdetail_state.dart';

class TvseriesDetailBloc
    extends Bloc<TvseriesDetailEvent, TvseriesDetailState> {
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
    on<FetchTvseriesDetailDataWithId>((event, emit) async {
      emit(state.copyWith(state: RequestState.loading));
      final detailResult = await getTvseriesDetail.execute(event.id);

      detailResult.fold(
        (failure) async {
          emit(state.copyWith(state: RequestState.error));
        },
        (tvseries) async {
          emit(state.copyWith(
            tvseriesDetail: tvseries,
            state: RequestState.loaded,
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
