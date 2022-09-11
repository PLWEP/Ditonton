part of 'tvseries_bloc.dart';

abstract class TvseriesState extends Equatable {
  const TvseriesState();

  @override
  List<Object> get props => [];
}

class EmptyData extends TvseriesState {}

class LoadingData extends TvseriesState {}

class ErrorData extends TvseriesState {
  final String message;

  const ErrorData(this.message);

  @override
  List<Object> get props => [message];
}

class LoadedData extends TvseriesState {
  final List<Tvseries> result;

  const LoadedData(this.result);

  @override
  List<Object> get props => [result];
}
