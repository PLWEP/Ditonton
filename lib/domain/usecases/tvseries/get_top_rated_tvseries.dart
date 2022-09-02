import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetTopRatedTvseries {
  final TvseriesRepository repository;

  GetTopRatedTvseries(this.repository);

  Future<Either<Failure, List<Tvseries>>> execute() {
    return repository.getTopRatedTvseries();
  }
}
