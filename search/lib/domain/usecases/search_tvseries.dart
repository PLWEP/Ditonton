import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvseries/domain/entities/tvseries.dart';
import 'package:tvseries/domain/repositories/tvseries_repository.dart';

class SearchTvseries {
  final TvseriesRepository repository;

  SearchTvseries(this.repository);

  Future<Either<Failure, List<Tvseries>>> execute(String query) {
    return repository.searchTvseries(query);
  }
}
