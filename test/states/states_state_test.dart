import 'package:flutter_test/flutter_test.dart';
import 'package:state_selector/core/api/async_process.dart';
import 'package:state_selector/features/domain/models/state_model.dart';
import 'package:state_selector/features/domain/redux/states/states_state.dart';

void main() {
  group('StatesState', () {
    test('should initialize empty', () {
      final state = StatesState();
      expect(state.states, isEmpty);
      expect(state.selectedState, isNull);
      expect(state.loadingStatesProccess.loading, isFalse);
      expect(state.loadingStatesProccess.failure, isNull);
    });

    test('should set states list', () {
      final states = [
        const StateModel(id: 1, name: 'State 1'),
        const StateModel(id: 2, name: 'State 2'),
      ];
      final stateState = StatesState()..states = states;
      expect(stateState.states, equals(states));
    });

    test('should set selectedState', () {
      const selectedState = StateModel(id: 3, name: 'Selected State');
      final stateState = StatesState()..selectedState = selectedState;
      expect(stateState.selectedState, equals(selectedState));
    });

    test('should set loadingStatesProccess', () {
      final loadingProcess = AsyncProcess()..loading = true;
      final stateState = StatesState()..loadingStatesProccess = loadingProcess;
      expect(stateState.loadingStatesProccess.loading, isTrue);
    });
  });
}
