import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/movie/movie_bloc.dart';

void main() {
  test('Cek if props same with the input', () {
    expect([], const FetchMoviesData().props);
    expect([1], const FetchMovieDataWithId(1).props);
  });
}
