import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetWatchlistTvseries {
  final TvseriesRepository _repository;

  GetWatchlistTvseries(this._repository);

  Future<Either<Failure, List<Tvseries>>> execute() {
    return _repository.getWatchlistTvseries();
  }
}
