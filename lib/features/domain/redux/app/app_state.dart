import 'package:state_selector/features/domain/redux/countries/countries_state.dart';
import 'package:state_selector/features/domain/redux/maps/maps_state.dart';
import 'package:state_selector/features/domain/redux/states/states_state.dart';

class AppState {
  const AppState({
    required this.countriesState,
    required this.statesState,
    required this.mapsState,
  });

  final CountriesState countriesState;
  final StatesState statesState;
  final MapsState mapsState;

  factory AppState.initial() {
    return AppState(
      countriesState: CountriesState(),
      statesState: StatesState(),
      mapsState: MapsState(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'countriesState': countriesState,
      'statesState': statesState,
      'mapsState': mapsState,
    };
  }
}
