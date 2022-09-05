import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/repositories/tvseries_repository.dart';
import 'package:core/utils/failure.dart';

class GetWatchlistTvseries {
  final TvseriesRepository _repository;

  GetWatchlistTvseries(this._repository);

  Future<Either<Failure, List<Tvseries>>> execute() {
    return _repository.getWatchlistTvseries();
  }
}
