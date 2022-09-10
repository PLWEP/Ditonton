import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_tvseries_recommendations.dart';
import 'package:tvseries/presentation/bloc/tvseries_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'recommendation_tvseries_bloc_test.mocks.dart';

@GenerateMocks([GetTvseriesRecommendations])
void main() {
  late MockGetTvseriesRecommendations mockGetRecommendationTvseries;
  late RecommendationTvseriesBloc recomBloc;

  setUp(() {
    mockGetRecommendationTvseries = MockGetTvseriesRecommendations();
    recomBloc = RecommendationTvseriesBloc(mockGetRecommendationTvseries);
  });

  const tId = 1;

  test('initial state should be empty', () {
    expect(recomBloc.state, EmptyData());
  });

  blocTest<RecommendationTvseriesBloc, TvseriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetRecommendationTvseries.execute(tId))
          .thenAnswer((_) async => Right(testTvseriesList));
      return recomBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesDataWithId(tId)),
    expect: () => [
      LoadingData(),
      TvseriesHasData(testTvseriesList),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationTvseries.execute(tId));
    },
  );

  blocTest<RecommendationTvseriesBloc, TvseriesState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetRecommendationTvseries.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return recomBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesDataWithId(tId)),
    expect: () => [
      LoadingData(),
      const ErrorData('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationTvseries.execute(tId));
    },
  );

  blocTest<RecommendationTvseriesBloc, TvseriesState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetRecommendationTvseries.execute(tId)).thenAnswer(
          (_) async => const Left(ConnectionFailure('Connection Failure')));
      return recomBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesDataWithId(tId)),
    expect: () => [
      LoadingData(),
      const ErrorData('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationTvseries.execute(tId));
    },
  );

  blocTest<RecommendationTvseriesBloc, TvseriesState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetRecommendationTvseries.execute(tId)).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return recomBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesDataWithId(tId)),
    expect: () => [
      LoadingData(),
      const ErrorData('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationTvseries.execute(tId));
    },
  );
}
