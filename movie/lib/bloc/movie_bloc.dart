import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status_movie.dart';
import 'package:movie/domain/usecases/remove_watchlist_movie.dart';
import 'package:movie/domain/usecases/save_watchlist_movie.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieBloc(this._getNowPlayingMovies) : super(EmptyData()) {
    on<FetchMoviesData>((event, emit) async {
      emit(LoadingData());
      final result = await _getNowPlayingMovies.execute();

      result.fold(
        (failure) {
          emit(ErrorData(failure.message));
        },
        (data) {
          emit(MovieHasData(data));
        },
      );
    });
  }
}

class PopularMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies _getPopularMovies;
  PopularMovieBloc(this._getPopularMovies) : super(EmptyData()) {
    on<FetchMoviesData>((event, emit) async {
      emit(LoadingData());
      final result = await _getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(ErrorData(failure.message));
        },
        (data) {
          emit(MovieHasData(data));
        },
      );
    });
  }
}

class TopRatedMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetTopRatedMovies _getTopRatedMovies;
  TopRatedMovieBloc(this._getTopRatedMovies) : super(EmptyData()) {
    on<FetchMoviesData>((event, emit) async {
      emit(LoadingData());
      final result = await _getTopRatedMovies.execute();

      result.fold(
        (failure) {
          emit(ErrorData(failure.message));
        },
        (data) {
          emit(MovieHasData(data));
        },
      );
    });
  }
}

class WatchlistMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  WatchlistMovieBloc(this._getWatchlistMovies) : super(EmptyData()) {
    on<FetchMoviesData>((event, emit) async {
      emit(LoadingData());
      final result = await _getWatchlistMovies.execute();

      result.fold(
        (failure) {
          emit(ErrorData(failure.message));
        },
        (data) {
          emit(MovieHasData(data));
        },
      );
    });
  }
}

// class MovieDetailBloc extends Bloc<MovieEvent, MovieState> {
//   final GetMovieDetail getMovieDetail;
//   final GetMovieRecommendations getMovieRecommendations;
//   final GetWatchListStatusMovie getWatchListStatus;
//   final SaveWatchlistMovie saveWatchlist;
//   final RemoveWatchlistMovie removeWatchlist;

//   static const watchlistAddSuccessMessage = 'Added to Watchlist';
//   static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

//   MovieDetailBloc({
//     required this.getMovieDetail,
//     required this.getMovieRecommendations,
//     required this.getWatchListStatus,
//     required this.saveWatchlist,
//     required this.removeWatchlist,
//   }) : super(MovieDetailHasData.initial()) {
//     on<FetchMovieDataWithId>((event, emit) async {
//       emit(LoadingData());
//       final detailResult = await getMovieDetail.execute(event.id);
//       final recommendationResult =
//           await getMovieRecommendations.execute(event.id);

//       detailResult.fold(
//         (failure) async {
//           emit(ErrorData(failure.message));
//         },
//         (movie) async {
//           emit(MovieDetailHasData(
//             movieDetail: movie,
//             message: '', isAddedToWatchlist: null, movieRecommendations: [], watchlistMessage: '',
//           ));
//           recommendationResult.fold(
//             (failure) {
//               emit(state.copyWith(
//                   movieRecommendationState: ErrorData(failure.message),
//                   message: failure.message));
//             },
//             (movies) {
//               emit(state.copyWith(
//                 movieRecommendationState: RequestState.Loaded,
//                 movieRecommendations: movies,
//                 message: '',
//               ));
//             },
//           );
//         },
//       );
//     });
//     on<AddToWatchlist>((event, emit) async {
//       final result = await saveWatchlist.execute(event.movieDetail);

//       result.fold((failure) {
//         emit(state.copyWith(watchlistMessage: failure.message));
//       }, (successMessage) {
//         emit(state.copyWith(watchlistMessage: successMessage));
//       });

//       add(LoadWatchlistStatus(event.movieDetail.id));
//     });
//     on<RemoveFromWatchlist>((event, emit) async {
//       final result = await removeWatchlist.execute(event.movieDetail);

//       result.fold((failure) {
//         emit(state.copyWith(watchlistMessage: failure.message));
//       }, (successMessage) {
//         emit(state.copyWith(watchlistMessage: successMessage));
//       });

//       add(LoadWatchlistStatus(event.movieDetail.id));
//     });
//     on<LoadWatchlistStatus>((event, emit) async {
//       final result = await getWatchListStatus.execute(event.id);
//       emit(state.copyWith(isAddedToWatchlist: result));
//     });
//   }
// }
