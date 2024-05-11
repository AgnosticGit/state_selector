import 'package:redux/redux.dart';
import 'package:state_selector/features/domain/redux/countries/countries_actions.dart';
import 'package:state_selector/features/domain/redux/maps/maps_actions.dart';
import 'package:state_selector/features/domain/redux/maps/maps_state.dart';
import 'package:state_selector/features/domain/redux/states/states_actions.dart';

final mapsReducer = combineReducers<MapsState>([
  TypedReducer<MapsState, MapsActionLoadGeoDataStarted>((state, _) => _loadGeoDataStarted(state)),
  TypedReducer<MapsState, MapsActionLoadCountryGeoDataFinished>(_loadCountryGeoDataFinished),
  TypedReducer<MapsState, MapsActionLoadStateGeoDataFinished>(_loadStateGeoDataFinished),
  TypedReducer<MapsState, MapsActionLoadGeoDataFailured>(_loadGeoDataFailured),
  TypedReducer<MapsState, StatesActionClearSelectedState>((state, _) => _clearStateGeoData(state)),
  TypedReducer<MapsState, CountriesActionClearSelectedCountry>(
    (state, _) => _clearCountryGeoData(state),
  ),
]);

MapsState _loadGeoDataStarted(MapsState state) {
  state.loadingGeoDataProccess.loading = true;
  state.loadingGeoDataProccess.failure = null;

  return state;
}

MapsState _loadCountryGeoDataFinished(
  MapsState state,
  MapsActionLoadCountryGeoDataFinished action,
) {
  state.loadingGeoDataProccess.loading = false;
  state.countryGeoData = action.countryGeoData;

  return state;
}

MapsState _loadStateGeoDataFinished(
  MapsState state,
  MapsActionLoadStateGeoDataFinished action,
) {
  state.loadingGeoDataProccess.loading = false;
  state.stateGeoData = action.stateGeoData;

  return state;
}

MapsState _loadGeoDataFailured(MapsState state, MapsActionLoadGeoDataFailured action) {
  state.loadingGeoDataProccess.loading = false;
  state.loadingGeoDataProccess.failure = action.failure;

  return state;
}

MapsState _clearStateGeoData(MapsState state) {
  state.stateGeoData = null;

  return state;
}

MapsState _clearCountryGeoData(MapsState state) {
  state.countryGeoData = null;

  return state;
}
