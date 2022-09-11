part of 'moviedetail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class FetchMovieDetailDataWithId extends MovieDetailEvent {
  final int id;
  const FetchMovieDetailDataWithId(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const AddWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const RemoveWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class LoadWatchlistStatus extends MovieDetailEvent {
  final int id;
  const LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
