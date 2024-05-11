import 'package:state_selector/core/api/failure.dart';

class Failures {
  Failures._();

  static const networkError = Failure(0, 'Network error, try again later');
  static const countryNotFound = Failure(1, 'Country not found, try another one');
  static const stateNotFound = Failure(2, 'State not found, try another one');
}
