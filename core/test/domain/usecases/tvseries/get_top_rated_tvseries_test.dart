import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_top_rated_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvseries usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp(() {
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = GetTopRatedTvseries(mockTvseriesRepository);
  });

  final tTvseries = <Tvseries>[];

  test('should get list of Tvseries from repository', () async {
    // arrange
    when(mockTvseriesRepository.getTopRatedTvseries())
        .thenAnswer((_) async => Right(tTvseries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvseries));
  });
}
