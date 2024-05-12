import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:redux/redux.dart';
import 'package:state_selector/core/api/failure.dart';
import 'package:state_selector/core/constants/enums.dart';
import 'package:state_selector/features/domain/models/geo_data_model.dart';
import 'package:state_selector/features/domain/redux/app/app_reducer.dart';
import 'package:state_selector/features/domain/redux/app/app_state.dart';
import 'package:state_selector/features/domain/redux/maps/maps_actions.dart';

void main() {
  late Store<AppState> store;

  setUp(() {
    store = Store<AppState>(
      appReducer,
      initialState: AppState.initial(),
    );
  });

  group('Maps Reducer', () {
    test('MapsActionLoadGeoDataStarted changes loading state', () {
      expect(store.state.mapsState.loadingGeoDataProccess.loading, false);
      store.dispatch(const MapsActionLoadGeoDataStarted());
      expect(store.state.mapsState.loadingGeoDataProccess.loading, true);
    });

    test('MapsActionLoadCountryGeoDataFinished updates countryGeoData', () {
      expect(store.state.mapsState.countryGeoData, null);
      const countryGeoData = GeoDataModel(
        geoDataType: GeoDataType.polygon,
        center: LatLng(0, 0),
        coordinates: [],
      );
      store.dispatch(const MapsActionLoadCountryGeoDataFinished(countryGeoData));
      expect(store.state.mapsState.countryGeoData, countryGeoData);
    });

    test('MapsActionLoadStateGeoDataFinished updates stateGeoData', () {
      expect(store.state.mapsState.stateGeoData, null);
      const stateGeoData = GeoDataModel(
        geoDataType: GeoDataType.polygon,
        center: LatLng(0, 0),
        coordinates: [],
      );
      store.dispatch(const MapsActionLoadStateGeoDataFinished(stateGeoData));
      expect(store.state.mapsState.stateGeoData, stateGeoData);
    });

    test('MapsActionLoadGeoDataFailured updates failure state', () {
      expect(store.state.mapsState.loadingGeoDataProccess.failure, null);
      const failure = Failure(1, 'failure');
      store.dispatch(const MapsActionLoadGeoDataFailured(failure));
      expect(store.state.mapsState.loadingGeoDataProccess.failure, failure);
    });
  });
}
