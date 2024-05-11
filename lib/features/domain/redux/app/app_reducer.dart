import 'package:state_selector/features/domain/redux/countries/countries_reducer.dart';
import 'package:state_selector/features/domain/redux/maps/maps_reducer.dart';
import 'package:state_selector/features/domain/redux/states/states_reducer.dart';

import 'app_state.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    countriesState: countriesReducer(state.countriesState, action),
    statesState: statesReducer(state.statesState, action),
    mapsState: mapsReducer(state.mapsState, action),
  );
}
