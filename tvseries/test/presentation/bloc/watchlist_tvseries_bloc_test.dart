import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_watchlist_tvseries.dart';
import 'package:tvseries/presentation/bloc/tvseries/tvseries_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tvseries_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvseries])
void main() {
  late MockGetWatchlistTvseries mockGetWatchlistTvseries;
  late WatchlistTvseriesBloc watchlistBloc;

  setUp(() {
    mockGetWatchlistTvseries = MockGetWatchlistTvseries();
    watchlistBloc = WatchlistTvseriesBloc(mockGetWatchlistTvseries);
  });

  test('initial state should be empty', () {
    expect(watchlistBloc.state, EmptyData());
  });

  blocTest<WatchlistTvseriesBloc, TvseriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvseries.execute())
          .thenAnswer((_) async => Right([testWatchlistTvseries]));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingData(),
      LoadedData([testWatchlistTvseries]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvseries.execute());
    },
  );

  blocTest<WatchlistTvseriesBloc, TvseriesState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetWatchlistTvseries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvseries.execute());
    },
  );

  blocTest<WatchlistTvseriesBloc, TvseriesState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetWatchlistTvseries.execute()).thenAnswer(
          (_) async => const Left(ConnectionFailure('Connection Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvseries.execute());
    },
  );

  blocTest<WatchlistTvseriesBloc, TvseriesState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetWatchlistTvseries.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const FetchTvseriesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvseries.execute());
    },
  );
}
