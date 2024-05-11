import 'package:state_selector/core/api/async_process.dart';
import 'package:state_selector/features/domain/models/country_model.dart';

class CountriesState {
  List<CountryModel> countries = [];
  CountryModel? selectedCountry;
  AsyncProcess loadingCountriesProccess = AsyncProcess();

  Map<String, dynamic> toJson() {
    return {
      'countries': countries,
      'selectedCountry': selectedCountry,
      'loadingCountriesProcess': loadingCountriesProccess,
    };
  }
}
