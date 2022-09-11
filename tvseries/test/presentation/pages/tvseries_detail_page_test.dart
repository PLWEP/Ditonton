import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/presentation/bloc/tvseries/tvseries_bloc.dart';
import 'package:tvseries/presentation/bloc/tvseriesdetail/tvseriesdetail_bloc.dart';
import 'package:tvseries/presentation/pages/tvseries_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvseriesDetailBloc
    extends MockBloc<TvseriesDetailEvent, TvseriesDetailState>
    implements TvseriesDetailBloc {}

class TvseriesStateFake extends Fake implements TvseriesDetailState {}

class TvseriesEventFake extends Fake implements TvseriesEvent {}

class MockRecommendationTvseriesBloc
    extends MockBloc<TvseriesEvent, TvseriesState>
    implements RecommendationTvseriesBloc {}

void main() {
  late MockTvseriesDetailBloc mockBloc;
  late MockRecommendationTvseriesBloc mockBlocRecom;

  setUpAll(() {
    registerFallbackValue(TvseriesEventFake());
    registerFallbackValue(TvseriesStateFake());
  });

  setUp(() {
    mockBloc = MockTvseriesDetailBloc();
    mockBlocRecom = MockRecommendationTvseriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvseriesDetailBloc>.value(value: mockBloc),
        BlocProvider<RecommendationTvseriesBloc>.value(value: mockBlocRecom),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(' Page should display Progressbar when tvseriesdetail loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
        TvseriesDetailState.initial().copyWith(state: RequestState.loading));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester
        .pumpWidget(_makeTestableWidget(const TvseriesDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(' Page should display Progressbar when recommendation loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(TvseriesDetailState.initial().copyWith(
      state: RequestState.loaded,
      isAddedToWatchlist: false,
      tvseriesDetail: testTvseriesDetail,
    ));
    when(() => mockBlocRecom.state).thenReturn(LoadingData());

    final progressBarFinder = find.byType(CircularProgressIndicator).first;

    await tester
        .pumpWidget(_makeTestableWidget(const TvseriesDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when Tv Show not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(TvseriesDetailState.initial().copyWith(
      state: RequestState.loaded,
      isAddedToWatchlist: false,
      tvseriesDetail: testTvseriesDetail,
    ));
    when(() => mockBlocRecom.state).thenReturn(LoadedData(testTvseriesList));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(_makeTestableWidget(const TvseriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when Tvseries is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(TvseriesDetailState.initial().copyWith(
      state: RequestState.loaded,
      tvseriesDetail: testTvseriesDetail,
      isAddedToWatchlist: true,
    ));
    when(() => mockBlocRecom.state).thenReturn(LoadedData(testTvseriesList));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(_makeTestableWidget(const TvseriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
