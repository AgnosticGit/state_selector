import 'package:flutter_test/flutter_test.dart';
import 'package:state_selector/core/api/failure.dart';

void main() {
  group('Failure', () {
    test('Failure should have correct properties', () {
      const failure = Failure(404, 'Not Found');
      expect(failure.code, 404);
      expect(failure.message, 'Not Found');
    });
  });
}
