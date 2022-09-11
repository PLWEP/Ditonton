part of 'tvseriesdetail_bloc.dart';

class TvseriesDetailState extends Equatable {
  final TvseriesDetail? tvseriesDetail;
  final String watchlistMessage;
  final bool isAddedToWatchlist;
  final RequestState state;

  const TvseriesDetailState({
    required this.tvseriesDetail,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
    required this.state,
  });

  TvseriesDetailState copyWith({
    TvseriesDetail? tvseriesDetail,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
    RequestState? state,
  }) {
    return TvseriesDetailState(
      tvseriesDetail: tvseriesDetail ?? this.tvseriesDetail,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      state: state ?? this.state,
    );
  }

  factory TvseriesDetailState.initial() {
    return const TvseriesDetailState(
      tvseriesDetail: null,
      watchlistMessage: '',
      isAddedToWatchlist: false,
      state: RequestState.empty,
    );
  }

  @override
  List<Object> get props => [
        watchlistMessage,
        isAddedToWatchlist,
        state,
      ];
}
