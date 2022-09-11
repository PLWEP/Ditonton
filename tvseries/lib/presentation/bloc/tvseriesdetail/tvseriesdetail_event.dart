part of 'tvseriesdetail_bloc.dart';

abstract class TvseriesDetailEvent extends Equatable {
  const TvseriesDetailEvent();
}

class FetchTvseriesDetailDataWithId extends TvseriesDetailEvent {
  final int id;
  const FetchTvseriesDetailDataWithId(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlist extends TvseriesDetailEvent {
  final TvseriesDetail tvseriesDetail;

  const AddWatchlist(this.tvseriesDetail);

  @override
  List<Object> get props => [tvseriesDetail];
}

class RemoveWatchlist extends TvseriesDetailEvent {
  final TvseriesDetail tvseriesDetail;

  const RemoveWatchlist(this.tvseriesDetail);

  @override
  List<Object> get props => [tvseriesDetail];
}

class LoadWatchlistStatus extends TvseriesDetailEvent {
  final int id;
  const LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
