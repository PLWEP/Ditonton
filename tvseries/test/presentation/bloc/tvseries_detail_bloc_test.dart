import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_tvseries_detail.dart';
import 'package:tvseries/domain/usecases/get_watchlist_status_tvseries.dart';
import 'package:tvseries/domain/usecases/remove_watchlist_tvseries.dart';
import 'package:tvseries/domain/usecases/save_watchlist_tvseries.dart';
import 'package:tvseries/presentation/bloc/tvseriesdetail/tvseriesdetail_bloc.dart';

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
      expect(detailBloc.state.state, RequestState.empty);
    });

    blocTest<TvseriesDetailBloc, TvseriesDetailState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTvseriesDetail.execute(tId))
            .thenAnswer((_) async => const Right(testTvseriesDetail));
        return detailBloc;
      },
      act: (bloc) => bloc.add(const FetchTvseriesDetailDataWithId(tId)),
      expect: () => [
        TvseriesDetailState.initial().copyWith(state: RequestState.loading),
        TvseriesDetailState.initial().copyWith(
          state: RequestState.loaded,
          tvseriesDetail: testTvseriesDetail,
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
      act: (bloc) => bloc.add(const FetchTvseriesDetailDataWithId(tId)),
      expect: () => [
        TvseriesDetailState.initial().copyWith(state: RequestState.loading),
        TvseriesDetailState.initial().copyWith(
          state: RequestState.error,
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
        TvseriesDetailState.initial().copyWith(
          tvseriesDetail: testTvseriesDetail,
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
        TvseriesDetailState.initial().copyWith(
            tvseriesDetail: testTvseriesDetail,
            isAddedToWatchlist: false,
            watchlistMessage: 'Success'),
        TvseriesDetailState.initial().copyWith(
            tvseriesDetail: testTvseriesDetail,
            isAddedToWatchlist: true,
            watchlistMessage: 'Success'),
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
        TvseriesDetailState.initial().copyWith(
            tvseriesDetail: testTvseriesDetail,
            isAddedToWatchlist: false,
            watchlistMessage: 'Removed'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testTvseriesDetail));
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
        TvseriesDetailState.initial().copyWith(
            tvseriesDetail: testTvseriesDetail,
            isAddedToWatchlist: false,
            watchlistMessage: 'Server Failure'),
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
        TvseriesDetailState.initial().copyWith(
            tvseriesDetail: testTvseriesDetail,
            isAddedToWatchlist: false,
            watchlistMessage: 'Server Failure'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testTvseriesDetail));
      },
    );
  });
}
