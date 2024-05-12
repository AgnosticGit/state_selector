import 'package:state_selector/core/api/failure.dart';
import 'package:state_selector/core/l10n/l10n.dart';

class Failures {
  Failures._();

  static const networkError = Failure(0, L10n.networkError);
  static const countryNotFound = Failure(1, L10n.countryNotFound);
  static const stateNotFound = Failure(2, L10n.stateNotFound);
}
