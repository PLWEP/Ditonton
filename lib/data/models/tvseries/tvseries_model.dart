import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:equatable/equatable.dart';

class TvseriesModel extends Equatable {
  TvseriesModel({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    required this.originCountry,
    required this.genresId,
    required this.originalLanguage,
    required this.voteCount,
    required this.name,
    required this.originalName,
  });

  final String? posterPath;
  final double popularity;
  final int id;
  final String? backdropPath;
  final double voteAverage;
  final String overview;
  final String? firstAirDate;
  final List<String> originCountry;
  final List<int> genresId;
  final String originalLanguage;
  final int voteCount;
  final String name;
  final String originalName;

  factory TvseriesModel.fromJson(Map<String, dynamic> json) => TvseriesModel(
        posterPath: json["poster_path"],
        popularity: json["popularity"].toDouble(),
        id: json["id"],
        backdropPath: json["backdrop_path"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        firstAirDate: json["first_air_date"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        genresId: List<int>.from(json["genre_ids"].map((x) => x)),
        originalLanguage: json["original_language"],
        voteCount: json["vote_count"],
        name: json["name"],
        originalName: json["original_name"],
      );

  Map<String, dynamic> toJson() => {
        "poster_path": posterPath,
        "popularity": popularity,
        "id": id,
        "backdrop_path": backdropPath,
        "vote_average": voteAverage,
        "overview": overview,
        "first_air_date": firstAirDate,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "genre_ids": List<dynamic>.from(genresId.map((x) => x)),
        "original_language": originalLanguage,
        "vote_count": voteCount,
        "name": name,
        "original_name": originalName,
      };

  Tvseries toEntity() {
    return Tvseries(
      posterPath: this.posterPath,
      popularity: this.popularity,
      id: this.id,
      backdropPath: this.backdropPath,
      voteAverage: this.voteAverage,
      overview: this.overview,
      firstAirDate: this.firstAirDate,
      originCountry: this.originCountry,
      genresId: this.genresId,
      originalLanguage: this.originalLanguage,
      voteCount: this.voteCount,
      name: this.name,
      originalName: this.originalName,
    );
  }

  @override
  List<Object?> get props => [
        posterPath,
        popularity,
        id,
        backdropPath,
        voteAverage,
        overview,
        firstAirDate,
        originCountry,
        genresId,
        originalLanguage,
        voteCount,
        name,
        originalName
      ];
}