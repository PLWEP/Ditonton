import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_tvseries_detail.dart';
import 'package:tvseries/domain/usecases/get_watchlist_status_tvseries.dart';
import 'package:tvseries/domain/usecases/remove_watchlist_tvseries.dart';
import 'package:tvseries/domain/usecases/save_watchlist_tvseries.dart';
import 'package:tvseries/presentation/bloc/tvseries_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tvseries_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvseriesDetail,
  GetWatchListStatusTvseries,
  SaveWatchlistTvseries,
  RemoveWatchlistTvseries,
])
void main() {
  late TvseriesDetailBloc detailBloc;
  late MockGetTvseriesDetail mockGetTvseriesDetail;
  late MockGetWatchListStatusTvseries mockGetWatchlistStatus;
  late MockSaveWatchlistTvseries mockSaveWatchlist;
  late MockRemoveWatchlistTvseries mockRemoveWatchlist;

  setUp(() {
    mockGetTvseriesDetail = MockGetTvseriesDetail();
    mockGetWatchlistStatus = MockGetWatchListStatusTvseries();
    mockSaveWatchlist = MockSaveWatchlistTvseries();
    mockRemoveWatchlist = MockRemoveWatchlistTvseries();
    detailBloc = TvseriesDetailBloc(
      getTvseriesDetail: mockGetTvseriesDetail,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;

  group('Get Tvseries Detail', () {
    test('initial state should be empty', () {
      expect(detailBloc.state.state, EmptyData());
    });

    blocTest<TvseriesDetailBloc, TvseriesDetailState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvseriesDetail.execute(tId))
            .thenAnswer((_) async => const Right(testTvseriesDetail));
        return detailBloc;
      },
      act: (bloc) => bloc.add(const FetchTvseriesDataWithId(tId)),
      expect: () => [
        detailBloc.state.copyWith(state: LoadingData()),
        detailBloc.state.copyWith(
          tvseriesDetail: testTvseriesDetail,
          state: LoadedData(),
        ),
      ],
      verify: (_) {
        verify(mockGetTvseriesDetail.execute(tId));
      },
    );

    blocTest<TvseriesDetailBloc, TvseriesDetailState>(
      'Should emit [Loading, Error] when get top rated is unsuccessful',
      build: () {
        when(mockGetTvseriesDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return detailBloc;
      },
      act: (bloc) => bloc.add(const FetchTvseriesDataWithId(tId)),
      expect: () => [
        detailBloc.state.copyWith(state: LoadingData()),
        detailBloc.state.copyWith(
          state: const ErrorData('Server Failure'),
        ),
      ],
      verify: (_) {
        verify(mockGetTvseriesDetail.execute(tId));
      },
    );
  });

  group('Watchlist Status', () {
    blocTest<TvseriesDetailBloc, TvseriesDetailState>(
      'Get Watchlist Status',
      build: () {
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        return detailBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchlistStatus(tId)),
      expect: () => [
        detailBloc.state.copyWith(
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<TvseriesDetailBloc, TvseriesDetailState>(
      'Should execute save watchlist when function called',
      build: () {
        when(mockSaveWatchlist.execute(testTvseriesDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(mockGetWatchlistStatus.execute(testTvseriesDetail.id))
            .thenAnswer((_) async => true);
        return detailBloc;
      },
      act: (bloc) => bloc.add(const AddWatchlist(testTvseriesDetail)),
      expect: () => [
        detailBloc.state
            .copyWith(watchlistMessage: 'Success', isAddedToWatchlist: false),
        detailBloc.state
            .copyWith(watchlistMessage: 'Success', isAddedToWatchlist: true),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testTvseriesDetail));
      },
    );

    blocTest<TvseriesDetailBloc, TvseriesDetailState>(
      'should execute remove watchlist when function called',
      build: () {
        when(mockRemoveWatchlist.execute(testTvseriesDetail))
            .thenAnswer((_) async => const Right('Removed'));
        when(mockGetWatchlistStatus.execute(testTvseriesDetail.id))
            .thenAnswer((_) async => false);
        return detailBloc;
      },
      act: (bloc) => bloc.add(const RemoveWatchlist(testTvseriesDetail)),
      expect: () => [
        detailBloc.state
            .copyWith(watchlistMessage: 'Removed', isAddedToWatchlist: false),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testTvseriesDetail));
      },
    );

    blocTest<TvseriesDetailBloc, TvseriesDetailState>(
      'should update watchlist status when add watchlist success',
      build: () {
        when(mockSaveWatchlist.execute(testTvseriesDetail))
            .thenAnswer((_) async => const Right('added to watchlist'));
        when(mockGetWatchlistStatus.execute(testTvseriesDetail.id))
            .thenAnswer((_) async => true);
        return detailBloc;
      },
      act: (bloc) => bloc.add(const AddWatchlist(testTvseriesDetail)),
      expect: () => [
        detailBloc.state.copyWith(
            watchlistMessage: 'added to watchlist', isAddedToWatchlist: false),
        detailBloc.state.copyWith(
            watchlistMessage: 'added to watchlist', isAddedToWatchlist: true),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testTvseriesDetail));
      },
    );

    blocTest<TvseriesDetailBloc, TvseriesDetailState>(
      'should update watchlist message when add watchlist failed',
      build: () {
        when(mockSaveWatchlist.execute(testTvseriesDetail)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetWatchlistStatus.execute(testTvseriesDetail.id))
            .thenAnswer((_) async => false);
        return detailBloc;
      },
      act: (bloc) => bloc.add(const AddWatchlist(testTvseriesDetail)),
      expect: () => [
        detailBloc.state.copyWith(
            watchlistMessage: 'Server Failure', isAddedToWatchlist: false),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testTvseriesDetail));
      },
    );

    blocTest<TvseriesDetailBloc, TvseriesDetailState>(
      'should update watchlist message when remove watchlist failed',
      build: () {
        when(mockRemoveWatchlist.execute(testTvseriesDetail)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetWatchlistStatus.execute(testTvseriesDetail.id))
            .thenAnswer((_) async => false);
        return detailBloc;
      },
      act: (bloc) => bloc.add(const RemoveWatchlist(testTvseriesDetail)),
      expect: () => [
        detailBloc.state.copyWith(
            watchlistMessage: 'Server Failure', isAddedToWatchlist: false),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testTvseriesDetail));
      },
    );
  });
}
