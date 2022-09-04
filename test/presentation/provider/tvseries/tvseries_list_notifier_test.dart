import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_now_playing_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_popular_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_top_rated_tvseries.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tvseries/tvseries_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tvseries_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvseries, GetPopularTvseries, GetTopRatedTvseries])
void main() {
  late TvseriesListNotifier provider;
  late MockGetNowPlayingTvseries mockGetNowPlayingTvseries;
  late MockGetPopularTvseries mockGetPopularTvseries;
  late MockGetTopRatedTvseries mockGetTopRatedTvseries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvseries = MockGetNowPlayingTvseries();
    mockGetPopularTvseries = MockGetPopularTvseries();
    mockGetTopRatedTvseries = MockGetTopRatedTvseries();
    provider = TvseriesListNotifier(
      getNowPlayingTvseries: mockGetNowPlayingTvseries,
      getPopularTvseries: mockGetPopularTvseries,
      getTopRatedTvseries: mockGetTopRatedTvseries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvseries = Tvseries(
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    popularity: 47.432451,
    id: 31917,
    backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
    voteAverage: 5.04,
    overview:
        "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
    firstAirDate: "2010-06-08",
    originCountry: ["US"],
    genresId: [18, 9648],
    originalLanguage: "en",
    voteCount: 133,
    name: "Pretty Little Liars",
    title: "Pretty Little Liars",
  );
  final tTvseriesList = <Tvseries>[tTvseries];

  group('now playing Tvseries', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingTvseries.execute())
          .thenAnswer((_) async => Right(tTvseriesList));
      // act
      provider.fetchNowPlayingTvseries();
      // assert
      verify(mockGetNowPlayingTvseries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingTvseries.execute())
          .thenAnswer((_) async => Right(tTvseriesList));
      // act
      provider.fetchNowPlayingTvseries();
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change Tvseries when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingTvseries.execute())
          .thenAnswer((_) async => Right(tTvseriesList));
      // act
      await provider.fetchNowPlayingTvseries();
      // assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingTvseries, tTvseriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingTvseries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingTvseries();
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular Tvseries', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTvseries.execute())
          .thenAnswer((_) async => Right(tTvseriesList));
      // act
      provider.fetchPopularTvseries();
      // assert
      expect(provider.popularTvseriesState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change Tvseries data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTvseries.execute())
          .thenAnswer((_) async => Right(tTvseriesList));
      // act
      await provider.fetchPopularTvseries();
      // assert
      expect(provider.popularTvseriesState, RequestState.Loaded);
      expect(provider.popularTvseries, tTvseriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvseries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvseries();
      // assert
      expect(provider.popularTvseriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated Tvseries', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTvseries.execute())
          .thenAnswer((_) async => Right(tTvseriesList));
      // act
      provider.fetchTopRatedTvseries();
      // assert
      expect(provider.topRatedTvseriesState, RequestState.Loading);
    });

    test('should change Tvseries data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTvseries.execute())
          .thenAnswer((_) async => Right(tTvseriesList));
      // act
      await provider.fetchTopRatedTvseries();
      // assert
      expect(provider.topRatedTvseriesState, RequestState.Loaded);
      expect(provider.topRatedTvseries, tTvseriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTvseries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvseries();
      // assert
      expect(provider.topRatedTvseriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
