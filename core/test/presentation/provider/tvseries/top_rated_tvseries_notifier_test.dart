import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_top_rated_tvseries.dart';
import 'package:core/presentation/provider/tvseries/top_rated_tvseries_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tvseries_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTvseries])
void main() {
  late MockGetTopRatedTvseries mockGetTopRatedTvseries;
  late TopRatedTvseriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTvseries = MockGetTopRatedTvseries();
    notifier =
        TopRatedTvseriesNotifier(getTopRatedTvseries: mockGetTopRatedTvseries)
          ..addListener(() {
            listenerCallCount++;
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
    originCountry: const ["US"],
    genresId: const [18, 9648],
    originalLanguage: "en",
    voteCount: 133,
    name: "Pretty Little Liars",
    title: "Pretty Little Liars",
  );

  final tTvseriesList = <Tvseries>[tTvseries];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedTvseries.execute())
        .thenAnswer((_) async => Right(tTvseriesList));
    // act
    notifier.fetchTopRatedTvseries();
    // assert
    expect(notifier.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change Tvseries data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetTopRatedTvseries.execute())
        .thenAnswer((_) async => Right(tTvseriesList));
    // act
    await notifier.fetchTopRatedTvseries();
    // assert
    expect(notifier.state, RequestState.loaded);
    expect(notifier.tvseries, tTvseriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedTvseries.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedTvseries();
    // assert
    expect(notifier.state, RequestState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
