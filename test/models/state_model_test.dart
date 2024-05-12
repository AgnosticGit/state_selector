import 'package:flutter_test/flutter_test.dart';
import 'package:state_selector/features/domain/models/state_model.dart';

void main() {
  group('StateModel', () {
    test('should create an instance of StateModel', () {
      const stateModel = StateModel(id: 1, name: 'State 1');
      expect(stateModel.id, 1);
      expect(stateModel.name, 'State 1');
    });

    test('should create an instance of StateModel from JSON', () {
      final stateModel = StateModel.fromJson({'id': 1, 'value': 'State 1'});
      expect(stateModel.id, 1);
      expect(stateModel.name, 'State 1');
    });
  });
}
