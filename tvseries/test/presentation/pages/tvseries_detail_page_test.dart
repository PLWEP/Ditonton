import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/presentation/bloc/tvseries_bloc.dart';
import 'package:tvseries/presentation/pages/tvseries_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvseriesDetailBloc
    extends MockBloc<TvseriesEvent, TvseriesDetailState>
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

  testWidgets(' Page should display Progressbar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
        TvseriesDetailState.initial().copyWith(state: LoadingData()));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester
        .pumpWidget(_makeTestableWidget(const TvseriesDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(' Page should display DetailContent when loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvseriesDetailState.initial()
        .copyWith(
            state: LoadedData(),
            tvseriesDetail: testTvseriesDetail,
            isAddedToWatchlist: false,
            watchlistMessage: ''));

    final detailContentFinder = find.byType(DetailContent);

    await tester
        .pumpWidget(_makeTestableWidget(const TvseriesDetailPage(id: 1)));

    expect(detailContentFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when Tvseries is not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(TvseriesDetailState.initial().copyWith(
      state: EmptyData(),
      tvseriesDetail: testTvseriesDetail,
      isAddedToWatchlist: false,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(_makeTestableWidget(const TvseriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  // testWidgets(
  //     'Watchlist button should display check icon when Tvseries is added to wathclist',
  //     (WidgetTester tester) async {
  //   when(() => mockBloc.state)
  //       .thenReturn(TvseriesDetailState.initial().copyWith(
  //     state: LoadedData(),
  //     tvseriesDetail: testTvseriesDetail,
  //     isAddedToWatchlist: true,
  //   ));

  //   final watchlistButtonIcon = find.byIcon(Icons.check);

  //   await tester
  //       .pumpWidget(_makeTestableWidget(const TvseriesDetailPage(id: 1)));

  //   expect(watchlistButtonIcon, findsOneWidget);
  // });

  // testWidgets(
  //     'Watchlist button should display Snackbar when added to watchlist',
  //     (WidgetTester tester) async {
  //   whenListen(
  //       mockBloc,
  //       Stream.fromIterable([
  //         TvseriesDetailState.initial().copyWith(
  //           state: LoadedData(),
  //           tvseriesDetail: testTvseriesDetail,
  //           isAddedToWatchlist: false,
  //         ),
  //         TvseriesDetailState.initial().copyWith(
  //           state: LoadedData(),
  //           tvseriesDetail: testTvseriesDetail,
  //           isAddedToWatchlist: true,
  //           watchlistMessage: 'Added to Watchlist',
  //         ),
  //       ]),
  //       initialState: TvseriesDetailState.initial());

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester
  //       .pumpWidget(_makeTestableWidget(const TvseriesDetailPage(id: 1)));
  //   await tester.pump();

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   expect(find.byType(SnackBar), findsOneWidget);
  //   expect(find.text('Added to Watchlist'), findsOneWidget);
  // });

  // testWidgets(
  //     'Watchlist button should display Snackbar when removed from watchlist',
  //     (WidgetTester tester) async {
  //   whenListen(
  //       mockBloc,
  //       Stream.fromIterable([
  //         TvseriesDetailState.initial().copyWith(
  //           state: LoadedData(),
  //           tvseriesDetail: testTvseriesDetail,
  //           isAddedToWatchlist: true,
  //         ),
  //         TvseriesDetailState.initial().copyWith(
  //           state: LoadedData(),
  //           tvseriesDetail: testTvseriesDetail,
  //           isAddedToWatchlist: false,
  //           watchlistMessage: 'Removed from Watchlist',
  //         ),
  //       ]),
  //       initialState: TvseriesDetailState.initial());

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester
  //       .pumpWidget(_makeTestableWidget(const TvseriesDetailPage(id: 1)));
  //   await tester.pump();

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   expect(find.byType(SnackBar), findsOneWidget);
  //   expect(find.text('Removed from Watchlist'), findsOneWidget);
  // });

  // testWidgets(
  //     'Watchlist button should display AlertDialog when add to watchlist failed',
  //     (WidgetTester tester) async {
  //   whenListen(
  //       mockBloc,
  //       Stream.fromIterable([
  //         TvseriesDetailState.initial().copyWith(
  //           TvseriesDetailState: LoadedData(),
  //           tvseriesDetail: testtvseriesDetail,
  //           tvShowRecommendationState: LoadedData(),
  //           tvShowRecommendations: [testTvShow],
  //           isAddedToWatchlist: false,
  //         ),
  //         TvseriesDetailState.initial().copyWith(
  //           TvseriesDetailState: LoadedData(),
  //           tvseriesDetail: testtvseriesDetail,
  //           tvShowRecommendationState: LoadedData(),
  //           tvShowRecommendations: [testTvShow],
  //           isAddedToWatchlist: false,
  //           watchlistMessage: 'Failed',
  //         ),
  //         TvseriesDetailState.initial().copyWith(
  //           TvseriesDetailState: LoadedData(),
  //           tvseriesDetail: testtvseriesDetail,
  //           tvShowRecommendationState: LoadedData(),
  //           tvShowRecommendations: [testTvShow],
  //           isAddedToWatchlist: false,
  //           watchlistMessage: 'Failed ',
  //         ),
  //       ]),
  //       initialState: TvseriesDetailState.initial());

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(_makeTestableWidget(tvseriesDetailPage(id: 1)));
  //   await tester.pump();

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton, warnIfMissed: false);
  //   await tester.pump();

  //   expect(find.byType(AlertDialog), findsOneWidget);
  //   expect(find.text('Failed'), findsOneWidget);
  // });
}
