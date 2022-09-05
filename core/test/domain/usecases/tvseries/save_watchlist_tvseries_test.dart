import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:core/domain/usecases/tvseries/save_watchlist_tvseries.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvseries usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp(() {
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = SaveWatchlistTvseries(mockTvseriesRepository);
  });

  test('should save Tvseries to the repository', () async {
    // arrange
    when(mockTvseriesRepository.saveWatchlist(testTvseriesDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvseriesDetail);
    // assert
    verify(mockTvseriesRepository.saveWatchlist(testTvseriesDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
