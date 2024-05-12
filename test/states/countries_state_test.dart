import 'package:flutter_test/flutter_test.dart';
import 'package:state_selector/core/api/async_process.dart';
import 'package:state_selector/features/domain/models/country_model.dart';
import 'package:state_selector/features/domain/redux/countries/countries_state.dart';

void main() {
  group('CountriesState', () {
    test('should initialize empty', () {
      final state = CountriesState();
      expect(state.countries, isEmpty);
      expect(state.selectedCountry, isNull);
      expect(state.loadingCountriesProccess.loading, isFalse);
      expect(state.loadingCountriesProccess.failure, isNull);
    });

    test('should set countries list', () {
      final countries = [
        const CountryModel(id: 1, name: 'Country 1'),
        const CountryModel(id: 2, name: 'Country 2'),
      ];
      final state = CountriesState()..countries = countries;
      expect(state.countries, countries);
    });

    test('should set selectedCountry', () {
      const selectedCountry = CountryModel(id: 3, name: 'Selected Country');
      final state = CountriesState()..selectedCountry = selectedCountry;
      expect(state.selectedCountry, selectedCountry);
    });

    test('should set loadingCountriesProcess', () {
      final loadingProcess = AsyncProcess()..loading = true;
      final state = CountriesState()..loadingCountriesProccess = loadingProcess;
      expect(state.loadingCountriesProccess.loading, isTrue);
    });
  });
}
