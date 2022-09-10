import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_popular_tvseries.dart';
import 'package:tvseries/presentation/bloc/tvseries_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tvseries_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvseries])
void main() {
  late MockGetPopularTvseries mockGetPopularTvseries;
  late PopularTvseriesBloc popularBloc;

  setUp(() {
    mockGetPopularTvseries = MockGetPopularTvseries();
    popularBloc = PopularTvseriesBloc(mockGetPopularTvseries);
  });

  test('initial state should be empty', () {
    expect(popularBloc.state, EmptyData());
  });

  blocTest<PopularTvseriesBloc, TvseriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvseries.execute())
          .thenAnswer((_) async => Right(testTvseriesList));
      return popularBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingData(),
      TvseriesHasData(testTvseriesList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvseries.execute());
    },
  );

  blocTest<PopularTvseriesBloc, TvseriesState>(
    'Should emit [Loading, Error] when get popular is unsuccessful',
    build: () {
      when(mockGetPopularTvseries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvseries.execute());
    },
  );

  blocTest<PopularTvseriesBloc, TvseriesState>(
    'Should emit [Loading, Error] when get popular is unsuccessful',
    build: () {
      when(mockGetPopularTvseries.execute()).thenAnswer(
          (_) async => const Left(ConnectionFailure('Connection Failure')));
      return popularBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvseries.execute());
    },
  );

  blocTest<PopularTvseriesBloc, TvseriesState>(
    'Should emit [Loading, Error] when get popular is unsuccessful',
    build: () {
      when(mockGetPopularTvseries.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return popularBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvseries.execute());
    },
  );
}
