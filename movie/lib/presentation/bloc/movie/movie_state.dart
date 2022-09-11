part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class EmptyData extends MovieState {}

class LoadingData extends MovieState {}

class ErrorData extends MovieState {
  final String message;

  const ErrorData(this.message);

  @override
  List<Object> get props => [message];
}

class LoadedData extends MovieState {
  final List<Movie> result;

  const LoadedData(this.result);

  @override
  List<Object> get props => [result];
}
