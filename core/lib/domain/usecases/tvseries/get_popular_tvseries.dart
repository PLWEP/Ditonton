import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/repositories/tvseries_repository.dart';

class GetPopularTvseries {
  final TvseriesRepository repository;

  GetPopularTvseries(this.repository);

  Future<Either<Failure, List<Tvseries>>> execute() {
    return repository.getPopularTvseries();
  }
}
