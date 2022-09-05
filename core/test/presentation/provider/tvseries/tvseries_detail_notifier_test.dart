import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/usecases/tvseries/get_tvseries_detail.dart';
import 'package:core/domain/usecases/tvseries/get_tvseries_recommendations.dart';
import 'package:core/domain/usecases/tvseries/get_watchlist_status_tvseries.dart';
import 'package:core/domain/usecases/tvseries/remove_watchlist_tvseries.dart';
import 'package:core/domain/usecases/tvseries/save_watchlist_tvseries.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/presentation/provider/tvseries/tvseries_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tvseries_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvseriesDetail,
  GetTvseriesRecommendations,
  GetWatchListStatusTvseries,
  SaveWatchlistTvseries,
  RemoveWatchlistTvseries,
])
void main() {
  late TvseriesDetailNotifier provider;
  late MockGetTvseriesDetail mockGetTvseriesDetail;
  late MockGetTvseriesRecommendations mockGetTvseriesRecommendations;
  late MockGetWatchListStatusTvseries mockGetWatchlistStatus;
  late MockSaveWatchlistTvseries mockSaveWatchlist;
  late MockRemoveWatchlistTvseries mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvseriesDetail = MockGetTvseriesDetail();
    mockGetTvseriesRecommendations = MockGetTvseriesRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatusTvseries();
    mockSaveWatchlist = MockSaveWatchlistTvseries();
    mockRemoveWatchlist = MockRemoveWatchlistTvseries();
    provider = TvseriesDetailNotifier(
      getTvseriesDetail: mockGetTvseriesDetail,
      getTvseriesRecommendations: mockGetTvseriesRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tId = 1;

  final tTvseries = Tvseries(
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    popularity: 47.432451,
    id: 31917,
    backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
    voteAverage: 5.04,
    overview:
        "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
    firstAirDate: "2010-06-08",
    originCountry: const ["US"],
    genresId: const [18, 9648],
    originalLanguage: "en",
    voteCount: 133,
    name: "Pretty Little Liars",
    title: "Pretty Little Liars",
  );
  final tTvseriesList = <Tvseries>[tTvseries];

  void _arrangeUsecase() {
    when(mockGetTvseriesDetail.execute(tId))
        .thenAnswer((_) async => const Right(testTvseriesDetail));
    when(mockGetTvseriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvseriesList));
  }

  group('Get Tvseries Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvseriesDetail(tId);
      // assert
      verify(mockGetTvseriesDetail.execute(tId));
      verify(mockGetTvseriesRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvseriesDetail(tId);
      // assert
      expect(provider.tvseriesState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change Tvseries when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvseriesDetail(tId);
      // assert
      expect(provider.tvseriesState, RequestState.loaded);
      expect(provider.tvseries, testTvseriesDetail);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation Tvseries when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvseriesDetail(tId);
      // assert
      expect(provider.tvseriesState, RequestState.loaded);
      expect(provider.tvseriesRecommendations, tTvseriesList);
    });
  });

  group('Get Tvseries Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvseriesDetail(tId);
      // assert
      verify(mockGetTvseriesRecommendations.execute(tId));
      expect(provider.tvseriesRecommendations, tTvseriesList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvseriesDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.loaded);
      expect(provider.tvseriesRecommendations, tTvseriesList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvseriesDetail.execute(tId))
          .thenAnswer((_) async => const Right(testTvseriesDetail));
      when(mockGetTvseriesRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvseriesDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTvseriesDetail))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetWatchlistStatus.execute(testTvseriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvseriesDetail);
      // assert
      verify(mockSaveWatchlist.execute(testTvseriesDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlist.execute(testTvseriesDetail))
          .thenAnswer((_) async => const Right('Removed'));
      when(mockGetWatchlistStatus.execute(testTvseriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvseriesDetail);
      // assert
      verify(mockRemoveWatchlist.execute(testTvseriesDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTvseriesDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchlistStatus.execute(testTvseriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvseriesDetail);
      // assert
      verify(mockGetWatchlistStatus.execute(testTvseriesDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTvseriesDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(testTvseriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvseriesDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvseriesDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(mockGetTvseriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvseriesList));
      // act
      await provider.fetchTvseriesDetail(tId);
      // assert
      expect(provider.tvseriesState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
