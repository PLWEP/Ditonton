import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/usecases/get_watchlist_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvseries usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp(() {
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = GetWatchlistTvseries(mockTvseriesRepository);
  });

  test('should get list of Tvseries from the repository', () async {
    // arrange
    when(mockTvseriesRepository.getWatchlistTvseries())
        .thenAnswer((_) async => Right(testTvseriesList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvseriesList));
  });
}
