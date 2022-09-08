import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvseries/domain/entities/tvseries_detail.dart';
import 'package:tvseries/domain/repositories/tvseries_repository.dart';

class SaveWatchlistTvseries {
  final TvseriesRepository repository;

  SaveWatchlistTvseries(this.repository);

  Future<Either<Failure, String>> execute(TvseriesDetail tvseries) {
    return repository.saveWatchlist(tvseries);
  }
}
