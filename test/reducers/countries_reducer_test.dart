import 'package:flutter_test/flutter_test.dart';
import 'package:state_selector/core/api/failure.dart';
import 'package:state_selector/features/domain/models/country_model.dart';
import 'package:state_selector/features/domain/redux/countries/countries_actions.dart';
import 'package:state_selector/features/domain/redux/countries/countries_reducer.dart';
import 'package:state_selector/features/domain/redux/countries/countries_state.dart';

void main() {
  group('Countries reducer', () {
    test('should sets loading to true and clears failure', () {
      final initialState = CountriesState();
      final newState = countriesReducer(initialState, const CountriesActionLoadingStarted());

      expect(newState.loadingCountriesProccess.loading, true);
      expect(newState.loadingCountriesProccess.failure, null);
    });

    test('should sets loading to false and updates countries', () {
      final initialState = CountriesState();
      final mockCountries = [const CountryModel(id: 1, name: 'Russia')];
      final action = CountriesActionLoadingFinished(mockCountries);
      final newState = countriesReducer(initialState, action);

      expect(newState.loadingCountriesProccess.loading, false);
      expect(newState.countries, mockCountries);
    });

    test('should sets loading to false and updates failure', () {
      final initialState = CountriesState();
      const mockFailure = Failure(1, 'failure');
      const action = CountriesActionLoadingFailured(mockFailure);
      final newState = countriesReducer(initialState, action);

      expect(newState.loadingCountriesProccess.loading, false);
      expect(newState.loadingCountriesProccess.failure, mockFailure);
    });

    test('should updates selectedCountry', () {
      final initialState = CountriesState();
      const mockCountry = CountryModel(id: 1, name: 'Vietnam');
      const action = CountriesActionSelectCountry(mockCountry);
      final newState = countriesReducer(initialState, action);

      expect(newState.selectedCountry, mockCountry);
    });

    test('should sets selectedCountry to null', () {
      final initialState = CountriesState()
        ..countries = [const CountryModel(id: 1, name: 'Thailand')];
      const action = CountriesActionClearSelectedCountry();
      final newState = countriesReducer(initialState, action);

      expect(newState.selectedCountry, null);
    });
  });
}
