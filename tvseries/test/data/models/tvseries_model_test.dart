import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('should be a subclass of Tvseries entity', () async {
    final result = testTvseriesModel.toEntity();
    expect(result, testTvseries);
  });
}
