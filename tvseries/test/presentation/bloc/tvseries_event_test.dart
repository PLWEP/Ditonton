import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/presentation/bloc/tvseries/tvseries_bloc.dart';

void main() {
  test('Cek if props same with the input', () {
    expect([], const FetchTvseriesData().props);
    expect([1], const FetchTvseriesDataWithId(1).props);
  });
}
