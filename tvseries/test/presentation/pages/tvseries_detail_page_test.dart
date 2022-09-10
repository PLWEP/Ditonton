import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/presentation/bloc/tvseries_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockTvseriesDetailBloc
    extends MockBloc<TvseriesEvent, TvseriesDetailState>
    implements TvseriesDetailBloc {}

class TvseriesDetailStateFake extends Fake implements TvseriesDetailState {}

class TvseriesEventFake extends Fake implements TvseriesEvent {}

void main() {
  // late MockTvseriesDetailBloc mockBloc;

  // setUpAll(() {
  //   registerFallbackValue(TvseriesEventFake());
  //   registerFallbackValue(TvseriesDetailStateFake());
  // });

  // setUp(() {
  //   mockBloc = MockTvseriesDetailBloc();
  // });

  // Widget _makeTestableWidget(Widget body) {
  //   return BlocProvider<TvseriesDetailBloc>.value(
  //     value: mockBloc,
  //     child: MaterialApp(
  //       home: body,
  //     ),
  //   );
  // }

//   testWidgets(
//       'Watchlist button should display add icon when Tvseries not added to watchlist',
//       (WidgetTester tester) async {
//     when(() => mockBloc.state.state).thenReturn(LoadedData());
//     when(() => mockBloc.state.tvseriesDetail).thenReturn(testTvseriesDetail);
//     when(() => mockBloc.state.isAddedToWatchlist).thenReturn(false);
//     when(() => mockBloc.state.watchlistMessage).thenReturn('');
//     final watchlistButtonIcon = find.byIcon(Icons.add);

//     await tester
//         .pumpWidget(_makeTestableWidget(const TvseriesDetailPage(id: 1399)));

//     expect(watchlistButtonIcon, findsOneWidget);
//   });

//   testWidgets(
//       'Watchlist button should dispay check icon when Tvseries is added to wathclist',
//       (WidgetTester tester) async {
//     when(() => mockBloc.state.state).thenReturn(LoadedData());
//     when(() => mockBloc.state.tvseriesDetail).thenReturn(testTvseriesDetail);
//     when(() => mockBloc.state.isAddedToWatchlist).thenReturn(true);

//     final watchlistButtonIcon = find.byIcon(Icons.check);

//     await tester
//         .pumpWidget(_makeTestableWidget(const TvseriesDetailPage(id: 1)));

//     expect(watchlistButtonIcon, findsOneWidget);
//   });

//   testWidgets(
//       'Watchlist button should display Snackbar when added to watchlist',
//       (WidgetTester tester) async {
//     when(() => mockBloc.state.state).thenReturn(LoadedData());
//     when(() => mockBloc.state.tvseriesDetail).thenReturn(testTvseriesDetail);
//     when(() => mockBloc.state.isAddedToWatchlist).thenReturn(false);
//     when(() => mockBloc.state.watchlistMessage)
//         .thenReturn('Added to Watchlist');

//     final watchlistButton = find.byType(ElevatedButton);

//     await tester
//         .pumpWidget(_makeTestableWidget(const TvseriesDetailPage(id: 1)));

//     expect(find.byIcon(Icons.add), findsOneWidget);

//     await tester.tap(watchlistButton);
//     await tester.pump();

//     expect(find.byType(SnackBar), findsOneWidget);
//     expect(find.text('Added to Watchlist'), findsOneWidget);
//   });

//   testWidgets(
//       'Watchlist button should display AlertDialog when add to watchlist failed',
//       (WidgetTester tester) async {
//     when(() => mockBloc.state.state).thenReturn(LoadedData());
//     when(() => mockBloc.state.tvseriesDetail).thenReturn(testTvseriesDetail);
//     when(() => mockBloc.state.isAddedToWatchlist).thenReturn(false);
//     when(() => mockBloc.state.watchlistMessage).thenReturn('Failed');

//     final watchlistButton = find.byType(ElevatedButton);

//     await tester
//         .pumpWidget(_makeTestableWidget(const TvseriesDetailPage(id: 1)));

//     expect(find.byIcon(Icons.add), findsOneWidget);

//     await tester.tap(watchlistButton);
//     await tester.pump();

//     expect(find.byType(AlertDialog), findsOneWidget);
//     expect(find.text('Failed'), findsOneWidget);
//   });
}
