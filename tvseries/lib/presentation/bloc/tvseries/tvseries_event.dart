part of 'tvseries_bloc.dart';

abstract class TvseriesEvent extends Equatable {
  const TvseriesEvent();
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
