import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvseries/domain/entities/tvseries_detail.dart';
import 'package:tvseries/domain/repositories/tvseries_repository.dart';

class RemoveWatchlistTvseries {
  final TvseriesRepository repository;

  RemoveWatchlistTvseries(this.repository);

  Future<Either<Failure, String>> execute(TvseriesDetail tvseries) {
    return repository.removeWatchlist(tvseries);
  }
}
