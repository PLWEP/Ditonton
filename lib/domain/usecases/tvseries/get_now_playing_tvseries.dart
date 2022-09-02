import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetNowPlayingTvseries {
  final TvseriesRepository repository;

  GetNowPlayingTvseries(this.repository);

  Future<Either<Failure, List<Tvseries>>> execute() {
    return repository.getNowPlayingTvseries();
  }
}
