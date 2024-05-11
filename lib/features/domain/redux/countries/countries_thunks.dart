import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:state_selector/features/data/countries_repository.dart';
import 'package:state_selector/features/domain/redux/app/app_state.dart';
import 'package:state_selector/features/domain/redux/countries/countries_actions.dart';

class CountriesThunkLoadCountries extends CallableThunkAction<AppState> {
  @override
  Future<void> call(Store<AppState> store) async {
    store.dispatch(const CountriesActionLoadingStarted());

    final lor = await CountriesRepository.getCountries();
    
    if (lor.isRight) {
      store.dispatch(CountriesActionLoadingFinished(lor.right));
    } else {
      store.dispatch(CountriesActionLoadingFailured(lor.left));
    }
  }
}
