import 'package:flutter_test/flutter_test.dart';
import 'package:state_selector/core/api/failure.dart';
import 'package:state_selector/features/domain/models/country_model.dart';
import 'package:state_selector/features/domain/redux/countries/countries_actions.dart';

void main() {
  group('CountriesActions', () {
    test('CountriesActionLoadingStarted should be instantiable and without arguments', () {
      expect(() => const CountriesActionLoadingStarted(), isNotNull);
    });

    test('CountriesActionLoadingFinished should have correct properties', () {
      final countries = [
        const CountryModel(id: 1, name: 'Country 1'),
        const CountryModel(id: 2, name: 'Country 2'),
      ];
      final action = CountriesActionLoadingFinished(countries);
      expect(action.countries, countries);
    });

    test('CountriesActionLoadingFailured should have correct properties', () {
      const failure = Failure(404, 'Not Found');
      const action = CountriesActionLoadingFailured(failure);
      expect(action.failure, failure);
    });

    test('CountriesActionSelectCountry should have correct properties', () {
      const country = CountryModel(id: 1, name: 'Country 1');
      const action = CountriesActionSelectCountry(country);
      expect(action.country, country);
    });

    test('CountriesActionClearSelectedCountry should be instantiable', () {
      expect(() => const CountriesActionClearSelectedCountry(), isNotNull);
    });
  });
}
