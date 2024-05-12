import 'package:flutter_test/flutter_test.dart';
import 'package:state_selector/core/api/failure.dart';
import 'package:state_selector/core/constants/enums.dart';
import 'package:state_selector/features/domain/models/geo_data_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:state_selector/features/domain/models/state_model.dart';
import 'package:state_selector/features/domain/redux/maps/maps_actions.dart';
import 'package:state_selector/features/domain/redux/states/states_actions.dart';

void main() {
  group('States actions', () {
    test('should create an instance of StatesActionLoadingStarted without arguments', () {
      const action = StatesActionLoadingStarted();
      expect(action, isNotNull);
    });

    test('should create an instance of StatesActionLoadingFinished', () {
      final states = [
        const StateModel(id: 1, name: 'State 1'),
        const StateModel(id: 2, name: 'State 2'),
      ];
      final action = StatesActionLoadingFinished(states);
      expect(action, isA<StatesActionLoadingFinished>());
      expect(action.states, equals(states));
    });

    test('should create an instance of StatesActionLoadingFailured', () {
      const failure = Failure(404, 'Not found');
      const action = StatesActionLoadingFailured(failure);
      expect(action, isA<StatesActionLoadingFailured>());
      expect(action.failure, equals(failure));
    });

    test('should create an instance of StatesActionClearStates without arguments', () {
      const action = StatesActionClearStates();
      expect(action, isNotNull);
    });

    test('should create an instance of StatesActionSelectState', () {
      const state = StateModel(id: 1, name: 'State 1');
      const action = StatesActionSelectState(state);
      expect(action.state, equals(state));
    });

    test('should create an instance of StatesActionClearSelectedState without arguments', () {
      const action = StatesActionClearSelectedState();
      expect(action, isNotNull);
    });
  });
}
