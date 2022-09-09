part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class EmptyData extends MovieState {}

class LoadingData extends MovieState {}

class LoadedData extends MovieState {}

class ErrorData extends MovieState {
  final String message;

  const ErrorData(this.message);

  @override
  List<Object> get props => [message];
}

class MovieHasData extends MovieState {
  final List<Movie> result;

  const MovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieDetailState extends Equatable {
  final MovieDetail? movieDetail;
  final String watchlistMessage;
  final bool isAddedToWatchlist;
  final MovieState state;

  const MovieDetailState({
    required this.movieDetail,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
    required this.state,
  });

  MovieDetailState copyWith({
    MovieDetail? movieDetail,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
    MovieState? state,
  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      state: state ?? this.state,
    );
  }

  factory MovieDetailState.initial() {
    return MovieDetailState(
      movieDetail: null,
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
