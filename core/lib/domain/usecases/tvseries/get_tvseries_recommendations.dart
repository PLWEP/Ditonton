import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/repositories/tvseries_repository.dart';
import 'package:core/utils/failure.dart';

class GetTvseriesRecommendations {
  final TvseriesRepository repository;

  GetTvseriesRecommendations(this.repository);

  Future<Either<Failure, List<Tvseries>>> execute(id) {
    return repository.getTvseriesRecommendations(id);
  }
}
