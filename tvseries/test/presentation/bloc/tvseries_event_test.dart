import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/presentation/bloc/tvseries_bloc.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('Cek if props same with the input', () {
    expect([], const FetchTvseriesData().props);
    expect([1], const FetchTvseriesDataWithId(1).props);
    expect([testTvseriesDetail], const AddWatchlist(testTvseriesDetail).props);
    expect(
        [testTvseriesDetail], const RemoveWatchlist(testTvseriesDetail).props);
    expect([1], const LoadWatchlistStatus(1).props);
  });
}
