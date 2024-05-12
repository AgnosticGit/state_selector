import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:state_selector/features/data/states_repository.dart';
import 'package:state_selector/features/domain/models/country_model.dart';
import 'package:state_selector/features/domain/redux/app/app_state.dart';
import 'package:state_selector/features/domain/redux/countries/countries_actions.dart';
import 'package:state_selector/features/domain/redux/states/states_actions.dart';

class StatesThunkLoadStates extends CallableThunkAction<AppState> {
  StatesThunkLoadStates(this.country);

  final CountryModel country;

  @override
  Future<void> call(Store<AppState> store) async {
    store.dispatch(CountriesActionSelectCountry(country));
    store.dispatch(const StatesActionLoadingStarted());

    final lor = await StatesRepository.getStates(country.id);

    if (lor.isRight) {
      store.dispatch(StatesActionLoadingFinished(lor.right));
    } else {
      store.dispatch(StatesActionLoadingFailured(lor.left));
    }
  }
}
