import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:state_selector/core/api/failure.dart';
import 'package:state_selector/features/domain/models/state_model.dart';
import 'package:state_selector/features/domain/redux/app/app_reducer.dart';
import 'package:state_selector/features/domain/redux/app/app_state.dart';
import 'package:state_selector/features/domain/redux/states/states_actions.dart';

void main() {
  group('State reducer', () {
    late Store<AppState> store;

    setUp(() {
      store = Store<AppState>(
        appReducer,
        initialState: AppState.initial(),
      );
    });

    test('Test loading states finished', () {
      final initialState = store.state;
      final mockStates = [const StateModel(name: 'Mock State', id: 1)];
      final action = StatesActionLoadingFinished(mockStates);
      store.dispatch(action);
      expect(store.state.statesState.loadingStatesProccess.loading, false);
      expect(store.state.statesState.states, equals(mockStates));
      expect(store.state, isNot(equals(initialState)));
    });

    test('Test loading states failure', () {
      final initialState = store.state;
      const failure = Failure(404, 'Not Found');
      const action = StatesActionLoadingFailured(failure);
      store.dispatch(action);
      expect(store.state.statesState.loadingStatesProccess.loading, false);
      expect(store.state.statesState.loadingStatesProccess.failure, equals(failure));
      expect(store.state, isNot(equals(initialState)));
    });

    test('Test selecting state', () {
      final initialState = store.state;
      const StateModel mockState = StateModel(name: 'Mock State', id: 1);
      const action = StatesActionSelectState(mockState);
      store.dispatch(action);
      expect(store.state.statesState.selectedState, equals(mockState));
      expect(store.state, isNot(equals(initialState)));
    });

    test('Test clearing selected state', () {
      const mockState = StateModel(name: 'Mock State', id: 1);
      store.dispatch(const StatesActionSelectState(mockState));
      final initialState = store.state;
      store.dispatch(const StatesActionClearSelectedState());
      expect(store.state.statesState.selectedState, isNull);
      expect(store.state, isNot(equals(initialState)));
    });

    test('Test clearing states', () {
      final mockStates = [
        const StateModel(name: 'Mock State 1', id: 1),
        const StateModel(name: 'Mock State 2', id: 2),
      ];
      store.dispatch(StatesActionLoadingFinished(mockStates));
      final initialState = store.state;
      store.dispatch(const StatesActionClearStates());
      expect(store.state.statesState.states.isEmpty, true);
      expect(store.state, isNot(equals(initialState)));
    });
  });
}
