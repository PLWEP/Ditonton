import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_tvseries_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvseriesRecommendations usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp(() {
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = GetTvseriesRecommendations(mockTvseriesRepository);
  });

  const tId = 1;
  final tTvseriess = <Tvseries>[];

  test('should get list of Tvseries recommendations from the repository',
      () async {
    // arrange
    when(mockTvseriesRepository.getTvseriesRecommendations(tId))
        .thenAnswer((_) async => Right(tTvseriess));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTvseriess));
  });
}
