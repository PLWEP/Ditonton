import 'package:tvseries/domain/entities/tvseries.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tvseries.dart';

import '../../../../tvseries/test/helpers/test_helper.mocks.dart';

void main() {
  late SearchTvseries usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp(() {
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = SearchTvseries(mockTvseriesRepository);
  });

  final tTvseries = <Tvseries>[];
  const tQuery = 'Game Of Throne';

  test('should get list of Tvseries from the repository', () async {
    // arrange
    when(mockTvseriesRepository.searchTvseries(tQuery))
        .thenAnswer((_) async => Right(tTvseries));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvseries));
  });
}
