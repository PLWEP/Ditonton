import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/presentation/bloc/tvseries/tvseries_bloc.dart';
import 'package:tvseries/presentation/pages/top_rated_tvseries_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedTvseriesBloc extends MockBloc<TvseriesEvent, TvseriesState>
    implements TopRatedTvseriesBloc {}

class TvseriesStateFake extends Fake implements TvseriesState {}

class TvseriesEventFake extends Fake implements TvseriesEvent {}

void main() {
  late MockTopRatedTvseriesBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(TvseriesEventFake());
    registerFallbackValue(TvseriesStateFake());
  });

  setUp(() {
    mockBloc = MockTopRatedTvseriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvseriesBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(LoadingData());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvseriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(LoadedData(testTvseriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvseriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should not display progressbar and listview when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(const ErrorData('Error message'));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvseriesPage()));

    expect(progressBarFinder, findsNothing);
    expect(listViewFinder, findsNothing);
  });

  testWidgets('Page should not display progressbar and listview when Empty',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(EmptyData());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvseriesPage()));

    expect(progressBarFinder, findsNothing);
    expect(listViewFinder, findsNothing);
  });
}
