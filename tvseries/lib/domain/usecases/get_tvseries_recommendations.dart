import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/entities/tvseries.dart';
import 'package:tvseries/domain/repositories/tvseries_repository.dart';
import 'package:core/utils/failure.dart';

class GetTvseriesRecommendations {
  final TvseriesRepository repository;

  GetTvseriesRecommendations(this.repository);

  Future<Either<Failure, List<Tvseries>>> execute(id) {
    return repository.getTvseriesRecommendations(id);
  }
}
