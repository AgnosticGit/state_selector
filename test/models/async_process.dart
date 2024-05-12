import 'package:flutter_test/flutter_test.dart';
import 'package:state_selector/core/api/async_process.dart';
import 'package:state_selector/core/api/failure.dart';

void main() {
  group('AsyncProcess', () {
    test('should initialize with loading false and no failure', () {
      final process = AsyncProcess();
      expect(process.loading, isFalse);
      expect(process.failure, isNull);
      expect(process.hasFailure, isFalse);
    });

    test('should set loading state', () {
      final process = AsyncProcess()..loading = true;
      expect(process.loading, isTrue);
    });

    test('should set failure', () {
      const failure = Failure(1, '1');
      final process = AsyncProcess()..failure = failure;
      expect(process.failure, failure);
      expect(process.hasFailure, isTrue);
    });
  });
}
