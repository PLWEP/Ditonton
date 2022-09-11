import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/presentation/bloc/tvseriesdetail/tvseriesdetail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('Cek if props same with the input', () {
    expect([1], const FetchTvseriesDetailDataWithId(1).props);
    expect([testTvseriesDetail], const AddWatchlist(testTvseriesDetail).props);
    expect(
        [testTvseriesDetail], const RemoveWatchlist(testTvseriesDetail).props);
    expect([1], const LoadWatchlistStatus(1).props);
  });
}
