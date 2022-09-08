part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
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

class AddWatchlist extends MovieEvent {
  final MovieDetail movie;

  const AddWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveWatchlist extends MovieEvent {
  final MovieDetail movie;

  const RemoveWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class LoadWatchlistStatus extends MovieEvent {
  final int id;
  const LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
