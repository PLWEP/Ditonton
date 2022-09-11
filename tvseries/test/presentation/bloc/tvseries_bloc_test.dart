import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_now_playing_tvseries.dart';
import 'package:tvseries/presentation/bloc/tvseries/tvseries_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tvseries_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvseries])
void main() {
  late MockGetNowPlayingTvseries mockGetNowPlayingTvseries;
  late TvseriesBloc tvseriesBloc;

  setUp(
    () {
      mockGetNowPlayingTvseries = MockGetNowPlayingTvseries();
      tvseriesBloc = TvseriesBloc(mockGetNowPlayingTvseries);
    },
  );

  test('initial state should be empty', () {
    expect(tvseriesBloc.state, EmptyData());
  });

  blocTest<TvseriesBloc, TvseriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTvseries.execute())
          .thenAnswer((_) async => Right(testTvseriesList));
      return tvseriesBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingData(),
      LoadedData(testTvseriesList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvseries.execute());
    },
  );

  blocTest<TvseriesBloc, TvseriesState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetNowPlayingTvseries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvseriesBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvseries.execute());
    },
  );

  blocTest<TvseriesBloc, TvseriesState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetNowPlayingTvseries.execute()).thenAnswer(
          (_) async => const Left(ConnectionFailure('Connection Failure')));
      return tvseriesBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvseries.execute());
    },
  );

  blocTest<TvseriesBloc, TvseriesState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetNowPlayingTvseries.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return tvseriesBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvseries.execute());
    },
  );
}
