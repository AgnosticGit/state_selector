import 'package:redux/redux.dart';
import 'package:state_selector/core/ui_kit/failure_handlers.dart';
import 'package:state_selector/features/domain/redux/countries/countries_actions.dart';
import 'package:state_selector/features/domain/redux/maps/maps_actions.dart';
import 'package:state_selector/main.dart';
import '../app_state.dart';

dynamic failureHandlingMiddleware(Store<AppState> _, action, NextDispatcher next) {
  if (action is MapsActionLoadGeoDataFailured) {
    FailureHandlers.bottomErrorSnackBar(
      Application.globalContextKey.currentContext!,
      action.failure,
    );
  }

  return next(action);
}
