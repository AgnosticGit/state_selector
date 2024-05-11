import 'package:state_selector/core/api/failure.dart';
import 'package:state_selector/features/domain/models/state_model.dart';

class StatesActionLoadingStarted {
  const StatesActionLoadingStarted();
}

class StatesActionLoadingFinished {
  const StatesActionLoadingFinished(this.states);

  final List<StateModel> states;

  Map<String, dynamic> toJson() {
    return {
      'states': states,
    };
  }
}

class StatesActionLoadingFailured {
  const StatesActionLoadingFailured(this.failure);

  final Failure failure;

  Map<String, dynamic> toJson() {
    return {
      'failure': failure,
    };
  }
}

class StatesActionClearStates {
  const StatesActionClearStates();
}

class StatesActionSelectState {
  const StatesActionSelectState(this.state);

  final StateModel state;

  Map<String, dynamic> toJson() {
    return {
      'state': state,
    };
  }
}

class StatesActionClearSelectedState {
  const StatesActionClearSelectedState();
}
