import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:state_selector/core/api/async_process.dart';
import 'package:state_selector/core/constants/enums.dart';
import 'package:state_selector/features/domain/models/geo_data_model.dart';
import 'package:state_selector/features/domain/redux/maps/maps_state.dart';

void main() {
  group('MapsState', () {
    test('should initialize empty', () {
      final mapsState = MapsState();
      expect(mapsState.countryGeoData, isNull);
      expect(mapsState.stateGeoData, isNull);
      expect(mapsState.loadingGeoDataProccess.loading, isFalse);
      expect(mapsState.loadingGeoDataProccess.failure, isNull);
    });

    test('should set countryGeoData', () {
      const countryGeoData = GeoDataModel(
        geoDataType: GeoDataType.multiPolygon,
        center: LatLng(0.0, 0.0),
        coordinates: [
          [
            [0.0, 0.0],
            [1.0, 0.0],
            [1.0, 1.0],
            [0.0, 1.0],
            [0.0, 0.0]
          ]
        ],
      );
      final mapsState = MapsState()..countryGeoData = countryGeoData;
      expect(mapsState.countryGeoData, countryGeoData);
    });

    test('should set stateGeoData', () {
      const stateGeoData = GeoDataModel(
        geoDataType: GeoDataType.polygon,
        center: LatLng(1.0, 1.0),
        coordinates: [
          [0.0, 0.0],
          [2.0, 0.0],
          [2.0, 2.0],
          [0.0, 2.0],
          [0.0, 0.0]
        ],
      );
      final mapsState = MapsState()..stateGeoData = stateGeoData;
      expect(mapsState.stateGeoData, stateGeoData);
    });

    test('should set loadingGeoDataProccess', () {
      final loadingProcess = AsyncProcess()..loading = true;
      final mapsState = MapsState()..loadingGeoDataProccess = loadingProcess;
      expect(mapsState.loadingGeoDataProccess.loading, isTrue);
    });
  });
}
