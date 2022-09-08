import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/usecases/get_tvseries_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvseriesDetail usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp(() {
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = GetTvseriesDetail(mockTvseriesRepository);
  });

  const tId = 1;

  test('should get Tvseries detail from the repository', () async {
    // arrange
    when(mockTvseriesRepository.getTvseriesDetail(tId))
        .thenAnswer((_) async => const Right(testTvseriesDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, const Right(testTvseriesDetail));
  });
}
