import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tvseries_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvseriesDetail usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp(() {
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = GetTvseriesDetail(mockTvseriesRepository);
  });

  final tId = 1;

  test('should get Tvseries detail from the repository', () async {
    // arrange
    when(mockTvseriesRepository.getTvseriesDetail(tId))
        .thenAnswer((_) async => Right(testTvseriesDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvseriesDetail));
  });
}
