import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_top_rated_tvseries.dart';
import 'package:tvseries/presentation/bloc/tvseries_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tvseries_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvseries])
void main() {
  late MockGetTopRatedTvseries mockGetTopRatedTvseries;
  late TopRatedTvseriesBloc topRatedBloc;

  setUp(() {
    mockGetTopRatedTvseries = MockGetTopRatedTvseries();
    topRatedBloc = TopRatedTvseriesBloc(mockGetTopRatedTvseries);
  });

  test('initial state should be empty', () {
    expect(topRatedBloc.state, EmptyData());
  });

  blocTest<TopRatedTvseriesBloc, TvseriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvseries.execute())
          .thenAnswer((_) async => Right(testTvseriesList));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingData(),
      TvseriesHasData(testTvseriesList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvseries.execute());
    },
  );

  blocTest<TopRatedTvseriesBloc, TvseriesState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetTopRatedTvseries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvseries.execute());
    },
  );

  blocTest<TopRatedTvseriesBloc, TvseriesState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetTopRatedTvseries.execute()).thenAnswer(
          (_) async => const Left(ConnectionFailure('Connection Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvseries.execute());
    },
  );

  blocTest<TopRatedTvseriesBloc, TvseriesState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetTopRatedTvseries.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvseries.execute());
    },
  );
}
