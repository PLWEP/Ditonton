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
  final MovieDetail movieDetail;

  const AddWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveWatchlist extends MovieEvent {
  final MovieDetail movieDetail;

  const RemoveWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class LoadWatchlistStatus extends MovieEvent {
  final int id;
  const LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
