import 'package:flutter_test/flutter_test.dart';
import 'package:state_selector/features/domain/models/country_model.dart';

void main() {
  group('CountryModel', () {
    test('CountryModel should be instantiable from valid JSON', () {
      final json = {
        'id': 1,
        'value': 'Country 1',
      };
      expect(() => CountryModel.fromJson(json), isNotNull);
    });

    test('CountryModel should have correct properties', () {
      const countryModel = CountryModel(id: 1, name: 'Country 1');
      expect(countryModel.id, 1);
      expect(countryModel.name, 'Country 1');
    });
  });
}
