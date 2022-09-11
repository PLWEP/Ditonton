part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class FetchMoviesData extends MovieEvent {
  const FetchMoviesData();

  @override
  List<Object> get props => [];
}

class FetchMovieDataWithId extends MovieEvent {
  final int id;
  const FetchMovieDataWithId(this.id);

  @override
  List<Object> get props => [id];
}
