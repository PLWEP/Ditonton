import 'package:flutter_test/flutter_test.dart';
import 'package:search/presentation/bloc/movie/search_movie_bloc.dart';

void main() {
  test('Cek if props same with the input', () {
    expect(['Hail'], const OnQueryChanged('Hail').props);
  });
}
