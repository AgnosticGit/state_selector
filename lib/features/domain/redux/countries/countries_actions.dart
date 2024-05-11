import 'package:state_selector/core/api/failure.dart';
import 'package:state_selector/features/domain/models/country_model.dart';

class CountriesActionLoadingStarted {
  const CountriesActionLoadingStarted();
}

class CountriesActionLoadingFinished {
  const CountriesActionLoadingFinished(this.countries);

  final List<CountryModel> countries;

  Map<String, dynamic> toJson() {
    return {
      'countries': countries,
    };
  }
}

class CountriesActionLoadingFailured {
  const CountriesActionLoadingFailured(this.failure);

  final Failure failure;

  Map<String, dynamic> toJson() {
    return {
      'failure': failure,
    };
  }
}

class CountriesActionSelectCountry {
  const CountriesActionSelectCountry(this.country);

  final CountryModel country;

  Map<String, dynamic> toJson() {
    return {
      'country': country,
    };
  }
}

class CountriesActionClearSelectedCountry {
  const CountriesActionClearSelectedCountry();
}
