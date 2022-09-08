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

class MovieHasData extends MovieState {
  final List<Movie> result;

  const MovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

// class MovieDetailHasData extends MovieState {
//   final MovieDetail? movieDetail;
//   final List<Movie> movieRecommendations;
//   final String message;
//   final String watchlistMessage;
//   final bool isAddedToWatchlist;

//   const MovieDetailHasData({
//     required this.movieDetail,
//     required this.movieRecommendations,
//     required this.message,
//     required this.watchlistMessage,
//     required this.isAddedToWatchlist,
//   });

//   factory MovieDetailHasData.initial() {
//     return const MovieDetailHasData(
//       movieDetail: null,
//       movieRecommendations: [],
//       message: '',
//       watchlistMessage: '',
//       isAddedToWatchlist: false,
//     );
//   }

//   @override
//   List<Object> get props => [
//         movieRecommendations,
//         message,
//         watchlistMessage,
//         isAddedToWatchlist,
//       ];
// }

// class MovieDetailHasData extends MovieState {
//   final MovieDetail? movieDetail;
//   final MovieState movieDetailState;
//   final List<Movie> movieRecommendations;
//   final MovieState movieRecommendationsState;
//   final String message;
//   final String watchlistMessage;
//   final bool isAddedToWatchlist;

//   const MovieDetailHasData({
//     required this.movieDetail,
//     required this.movieDetailState,
//     required this.movieRecommendations,
//     required this.movieRecommendationsState,
//     required this.message,
//     required this.watchlistMessage,
//     required this.isAddedToWatchlist,
//   });

//   MovieDetailHasData copyWith({
//     MovieDetail? movieDetail,
//     List<Movie>? movieRecommendations,
//     MovieState? movieDetailState,
//     MovieState? movieRecommendationState,
//     String? message,
//     String? watchlistMessage,
//     bool? isAddedToWatchlist,
//   }) {
//     return MovieDetailHasData(
//       movieDetail: movieDetail ?? this.movieDetail,
//       movieRecommendations: movieRecommendations ?? this.movieRecommendations,
//       movieDetailState: movieDetailState ?? this.movieDetailState,
//       movieRecommendationsState: movieRecommendationsState,
//       message: message ?? this.message,
//       watchlistMessage: watchlistMessage ?? this.watchlistMessage,
//       isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
//     );
//   }

//   factory MovieDetailHasData.initial() {
//     return MovieDetailHasData(
//       movieDetail: null,
//       movieRecommendations: const [],
//       movieDetailState: EmptyData(),
//       movieRecommendationsState: EmptyData(),
//       message: '',
//       watchlistMessage: '',
//       isAddedToWatchlist: false,
//     );
//   }
// }

// class WatchlistMessage extends MovieState {
//   final String message;
//   const WatchlistMessage(this.message);

//   @override
//   List<Object> get props => [message];
// }

// class WatchlistStatus extends MovieState {
//   final bool status;

//   const WatchlistStatus(this.status);

//   @override
//   List<Object> get props => [status];
// }
