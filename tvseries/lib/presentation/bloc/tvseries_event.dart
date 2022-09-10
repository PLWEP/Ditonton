part of 'tvseries_bloc.dart';

abstract class TvseriesEvent extends Equatable {
  const TvseriesEvent();

  @override
  List<Object> get props => [];
}

class FetchTvseriesData extends TvseriesEvent {
  const FetchTvseriesData();

  @override
  List<Object> get props => [];
}

class FetchTvseriesDataWithId extends TvseriesEvent {
  final int id;
  const FetchTvseriesDataWithId(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlist extends TvseriesEvent {
  final TvseriesDetail tvseriesDetail;

  const AddWatchlist(this.tvseriesDetail);

  @override
  List<Object> get props => [tvseriesDetail];
}

class RemoveWatchlist extends TvseriesEvent {
  final TvseriesDetail tvseriesDetail;

  const RemoveWatchlist(this.tvseriesDetail);

  @override
  List<Object> get props => [tvseriesDetail];
}

class LoadWatchlistStatus extends TvseriesEvent {
  final int id;
  const LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
