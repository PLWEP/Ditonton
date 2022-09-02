import 'package:ditonton/data/models/tvseries/tvseries_model.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:equatable/equatable.dart';

class TvseriesTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  TvseriesTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory TvseriesTable.fromEntity(TvseriesDetail tvseries) => TvseriesTable(
        id: tvseries.id,
        title: tvseries.originalName,
        posterPath: tvseries.posterPath,
        overview: tvseries.overview,
      );

  factory TvseriesTable.fromMap(Map<String, dynamic> map) => TvseriesTable(
        id: map['id'],
        title: map['originalName'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  factory TvseriesTable.fromDTO(TvseriesModel tvseries) => TvseriesTable(
        id: tvseries.id,
        title: tvseries.originalName,
        posterPath: tvseries.posterPath,
        overview: tvseries.overview,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
      };

  Tvseries toEntity() => Tvseries.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: title,
      );

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
