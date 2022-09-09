part of 'tvseries_bloc.dart';

abstract class TvseriesState extends Equatable {
  const TvseriesState();

  @override
  List<Object> get props => [];
}

class EmptyData extends TvseriesState {}

class LoadingData extends TvseriesState {}

class LoadedData extends TvseriesState {}

class ErrorData extends TvseriesState {
  final String message;

  const ErrorData(this.message);

  @override
  List<Object> get props => [message];
}

class TvseriesHasData extends TvseriesState {
  final List<Tvseries> result;

  const TvseriesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvseriesDetailState extends Equatable {
  final TvseriesDetail? tvseriesDetail;
  final String watchlistMessage;
  final bool isAddedToWatchlist;
  final TvseriesState state;

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
    TvseriesState? state,
  }) {
    return TvseriesDetailState(
      tvseriesDetail: tvseriesDetail ?? this.tvseriesDetail,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      state: state ?? this.state,
    );
  }

  factory TvseriesDetailState.initial() {
    return TvseriesDetailState(
      tvseriesDetail: null,
      watchlistMessage: '',
      isAddedToWatchlist: false,
      state: EmptyData(),
    );
  }

  @override
  List<Object> get props => [
        watchlistMessage,
        isAddedToWatchlist,
        state,
      ];
}
