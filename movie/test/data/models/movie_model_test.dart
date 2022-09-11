import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('should be a subclass of Movie entity', () async {
    final result = testMovieModel.toEntity();
    expect(result, testMovie);
  });
}
