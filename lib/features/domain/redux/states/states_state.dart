import 'package:state_selector/core/api/async_process.dart';
import 'package:state_selector/features/domain/models/state_model.dart';

class StatesState {
  List<StateModel> states = [];
  StateModel? selectedState;
  AsyncProcess loadingStatesProccess = AsyncProcess();

  Map<String, dynamic> toJson() {
    return {
      'states': states,
      'selectedState': selectedState,
      'loadingStatesProccess': loadingStatesProccess,
    };
  }
}
