import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/search_tvseries.dart';
import 'package:ditonton/presentation/provider/tvseries/tvseries_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'Tvseries_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvseries])
void main() {
  late TvseriesSearchNotifier provider;
  late MockSearchTvseries mockSearchTvseries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvseries = MockSearchTvseries();
    provider = TvseriesSearchNotifier(searchTvseries: mockSearchTvseries)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvseriesModel = Tvseries(
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
  final tTvseriesList = <Tvseries>[tTvseriesModel];
  final tQuery = 'spiderman';

  group('search Tvseries', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTvseries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvseriesList));
      // act
      provider.fetchTvseriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTvseries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvseriesList));
      // act
      await provider.fetchTvseriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.loaded);
      expect(provider.searchResult, tTvseriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTvseries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvseriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
