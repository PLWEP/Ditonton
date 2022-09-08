import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:tvseries/domain/entities/tvseries.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/bloc/tvseries/search_tvseries_bloc.dart';
import 'package:search/domain/usecases/search_tvseries.dart';

import 'search_tvseries_bloc_test.mocks.dart';

@GenerateMocks([SearchTvseries])
void main() {
  late SearchTvseriesBloc searchBloc;
  late MockSearchTvseries mockSearchTvseries;

  setUp(() {
    mockSearchTvseries = MockSearchTvseries();
    searchBloc = SearchTvseriesBloc(mockSearchTvseries);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchEmpty());
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
    originCountry: const ["US"],
    genresId: const [18, 9648],
    originalLanguage: "en",
    voteCount: 133,
    name: "Pretty Little Liars",
    title: "Pretty Little Liars",
  );
  final tTvseriesList = <Tvseries>[tTvseries];
  const tQuery = 'Pretty Little Liars';

  blocTest<SearchTvseriesBloc, SearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvseries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvseriesList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasData(tTvseriesList),
    ],
    verify: (bloc) {
      verify(mockSearchTvseries.execute(tQuery));
    },
  );

  blocTest<SearchTvseriesBloc, SearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvseries.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      const SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvseries.execute(tQuery));
    },
  );
}
