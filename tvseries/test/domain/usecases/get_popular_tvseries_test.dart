import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/entities/tvseries.dart';
import 'package:tvseries/domain/usecases/get_popular_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvseries usecase;
  late MockTvseriesRepository mockTvseriesRpository;

  setUp(() {
    mockTvseriesRpository = MockTvseriesRepository();
    usecase = GetPopularTvseries(mockTvseriesRpository);
  });

  final tTvseries = <Tvseries>[];

  group('GetPopularTvseries Tests', () {
    group('execute', () {
      test(
          'should get list of Tvseries from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvseriesRpository.getPopularTvseries())
            .thenAnswer((_) async => Right(tTvseries));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTvseries));
      });
    });
  });
}
