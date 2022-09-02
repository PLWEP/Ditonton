import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Tvseries extends Equatable {
  Tvseries({
    required this.backdropPath,
    required this.genresId,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.voteAverage,
    required this.voteCount,
  });

  String? backdropPath;
  List<int>? genresId;
  int? id;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? status;
  double? voteAverage;
  int? voteCount;

  Tvseries.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.originalName,
  });

  @override
  List<Object?> get props => [
        backdropPath,
        genresId,
        id,
        originalName,
        overview,
        popularity,
        posterPath,
        status,
        voteAverage,
        voteCount
      ];
}
