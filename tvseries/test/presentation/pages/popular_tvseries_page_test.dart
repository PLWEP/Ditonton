import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/bloc/tvseries/tvseries_bloc.dart';
import 'package:tvseries/presentation/pages/popular_tvseries_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularTvseriesBloc extends MockBloc<TvseriesEvent, TvseriesState>
    implements PopularTvseriesBloc {}

class TvseriesStateFake extends Fake implements TvseriesState {}

class TvseriesEventFake extends Fake implements TvseriesEvent {}

void main() {
  late MockPopularTvseriesBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(TvseriesEventFake());
    registerFallbackValue(TvseriesStateFake());
  });

  setUp(() {
    mockBloc = MockPopularTvseriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvseriesBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(LoadingData());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvseriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(LoadedData(testTvseriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvseriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should not display progressbar and listview when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(const ErrorData('Error message'));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvseriesPage()));

    expect(progressBarFinder, findsNothing);
    expect(listViewFinder, findsNothing);
  });

  testWidgets('Page should not display progressbar and listview when Empty',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(EmptyData());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvseriesPage()));

    expect(progressBarFinder, findsNothing);
    expect(listViewFinder, findsNothing);
  });
}
