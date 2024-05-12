import 'package:flutter_test/flutter_test.dart';
import 'package:state_selector/core/api/failure.dart';
import 'package:state_selector/core/constants/enums.dart';
import 'package:state_selector/features/domain/models/geo_data_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:state_selector/features/domain/redux/maps/maps_actions.dart';

void main() {
  group('MapsActions', () {
    test('MapsActionLoadGeoDataStarted should be instantiable and without arguments', () {
      expect(() => const MapsActionLoadGeoDataStarted(), isNotNull);
    });

    test('MapsActionLoadCountryGeoDataFinished should have correct properties', () {
      const geoDataModel = GeoDataModel(
        geoDataType: GeoDataType.multiPolygon,
        center: LatLng(51.5072, 0.1275),
        coordinates: [
          [
            [51.5072, 0.1275],
            [51.5075, 0.1276],
            [51.5077, 0.1274],
            [51.5072, 0.1275],
          ]
        ],
      );
      const action = MapsActionLoadCountryGeoDataFinished(geoDataModel);
      expect(action.countryGeoData, geoDataModel);
    });

    test('MapsActionLoadStateGeoDataFinished should have correct properties', () {
      const geoDataModel = GeoDataModel(
        geoDataType: GeoDataType.polygon,
        center: LatLng(37.7749, -122.4194),
        coordinates: [
          [
            [37.7749, -122.4194],
            [37.7753, -122.4192],
            [37.7751, -122.4191],
            [37.7749, -122.4194],
          ]
        ],
      );
      const action = MapsActionLoadStateGeoDataFinished(geoDataModel);
      expect(action.stateGeoData, geoDataModel);
    });

    test('MapsActionLoadGeoDataFailured should have correct properties', () {
      const failure = Failure(1, 'failure');
      const action = MapsActionLoadGeoDataFailured(failure);
      expect(action.failure, failure);
    });
  });
}
