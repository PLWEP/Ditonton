import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/entities/tvseries.dart';
import 'package:tvseries/domain/usecases/get_now_playing_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTvseries usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp(() {
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = GetNowPlayingTvseries(mockTvseriesRepository);
  });

  final tTvseries = <Tvseries>[];

  test('should get list of Tvseries from the repository', () async {
    // arrange
    when(mockTvseriesRepository.getNowPlayingTvseries())
        .thenAnswer((_) async => Right(tTvseries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvseries));
  });
}
