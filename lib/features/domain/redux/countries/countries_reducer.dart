import 'package:state_selector/features/domain/redux/countries/countries_actions.dart';
import 'package:state_selector/features/domain/redux/countries/countries_state.dart';
import 'package:redux/redux.dart';

final countriesReducer = combineReducers<CountriesState>([
  TypedReducer<CountriesState, CountriesActionLoadingStarted>(
    (state, _) => _loadCountriesStarted(state),
  ),
  TypedReducer<CountriesState, CountriesActionLoadingFinished>(_loadCountriesFinished),
  TypedReducer<CountriesState, CountriesActionLoadingFailured>(_loadCountriesFailured),
  TypedReducer<CountriesState, CountriesActionSelectCountry>(_selectCountry),
  TypedReducer<CountriesState, CountriesActionClearSelectedCountry>(_clearSelectedCountry),
]);

CountriesState _loadCountriesStarted(CountriesState state) {
  state.loadingCountriesProccess.loading = true;
  state.loadingCountriesProccess.failure = null;

  return state;
}

CountriesState _loadCountriesFinished(CountriesState state, CountriesActionLoadingFinished action) {
  state.loadingCountriesProccess.loading = false;
  state.countries = action.countries;

  return state;
}

CountriesState _loadCountriesFailured(CountriesState state, CountriesActionLoadingFailured action) {
  state.loadingCountriesProccess.loading = false;
  state.loadingCountriesProccess.failure = action.failure;

  return state;
}

CountriesState _selectCountry(CountriesState state, CountriesActionSelectCountry action) {
  state.selectedCountry = action.country;

  return state;
}

CountriesState _clearSelectedCountry(
  CountriesState state,
  CountriesActionClearSelectedCountry action,
) {
  state.selectedCountry = null;

  return state;
}
