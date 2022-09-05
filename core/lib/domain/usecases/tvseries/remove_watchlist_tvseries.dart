import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tvseries_detail.dart';
import 'package:core/domain/repositories/tvseries_repository.dart';

class RemoveWatchlistTvseries {
  final TvseriesRepository repository;

  RemoveWatchlistTvseries(this.repository);

  Future<Either<Failure, String>> execute(TvseriesDetail tvseries) {
    return repository.removeWatchlist(tvseries);
  }
}
