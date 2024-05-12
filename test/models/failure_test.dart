import 'package:flutter_test/flutter_test.dart';
import 'package:state_selector/core/api/failure.dart';
import 'package:state_selector/core/constants/enums.dart';
import 'package:state_selector/features/domain/models/geo_data_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:state_selector/features/domain/redux/maps/maps_actions.dart';

void main() {
  group('Failure', () {
    test('Failure should have correct properties', () {
      const failure = Failure(404, 'Not Found');
      expect(failure.code, 404);
      expect(failure.message, 'Not Found');
    });
  });
}
