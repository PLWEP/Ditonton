import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/moviedetail/moviedetail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('Cek if props same with the input', () {
    expect([1], const FetchMovieDetailDataWithId(1).props);
    expect([testMovieDetail], const AddWatchlist(testMovieDetail).props);
    expect([testMovieDetail], const RemoveWatchlist(testMovieDetail).props);
    expect([1], const LoadWatchlistStatus(1).props);
  });
}
