import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/remove_watchlist_tvseries.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTvseries usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp(() {
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = RemoveWatchlistTvseries(mockTvseriesRepository);
  });

  test('should remove watchlist Tvseries from repository', () async {
    // arrange
    when(mockTvseriesRepository.removeWatchlist(testTvseriesDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvseriesDetail);
    // assert
    verify(mockTvseriesRepository.removeWatchlist(testTvseriesDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
