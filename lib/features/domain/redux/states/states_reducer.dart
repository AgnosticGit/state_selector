import 'package:redux/redux.dart';
import 'package:state_selector/features/domain/redux/states/states_actions.dart';
import 'package:state_selector/features/domain/redux/states/states_state.dart';

final statesReducer = combineReducers<StatesState>([
  TypedReducer<StatesState, StatesActionLoadingStarted>(
    (state, _) => _loadStatesStarted(state),
  ),
  TypedReducer<StatesState, StatesActionLoadingFinished>(_loadStatesFinished),
  TypedReducer<StatesState, StatesActionLoadingFailured>(_loadStatesFailure),
  TypedReducer<StatesState, StatesActionSelectState>(_selectState),
  TypedReducer<StatesState, StatesActionClearSelectedState>(_clearSelectedState),
  TypedReducer<StatesState, StatesActionClearStates>((state, _) => _clearStates(state)),
]);

StatesState _loadStatesStarted(StatesState state) {
  state.loadingStatesProccess.loading = true;
  state.loadingStatesProccess.failure = null;

  return state;
}

StatesState _loadStatesFinished(StatesState state, StatesActionLoadingFinished action) {
  state.loadingStatesProccess.loading = false;
  state.states = action.states;

  return state;
}

StatesState _loadStatesFailure(StatesState state, StatesActionLoadingFailured action) {
  state.loadingStatesProccess.loading = false;
  state.loadingStatesProccess.failure = action.failure;

  return state;
}

StatesState _selectState(StatesState state, StatesActionSelectState action) {
  state.selectedState = action.state;

  return state;
}

StatesState _clearSelectedState(StatesState state, StatesActionClearSelectedState action) {
  state.selectedState = null;

  return state;
}

StatesState _clearStates(StatesState state) {
  state.states.clear();

  return state;
}
