import 'package:flutter_test/flutter_test.dart';
import 'package:state_selector/core/constants/enums.dart';
import 'package:state_selector/features/domain/models/geo_data_model.dart';
import 'package:latlong2/latlong.dart';

void main() {
  group('GeoDataModel', () {
    test('GeoDataModel should be instantiable from valid JSON', () {
      final json = {
        'geojson': {
          'type': 'MultiPolygon',
          'coordinates': [
            [
              [
                [51.5072, 0.1275],
                [51.5075, 0.1276],
                [51.5077, 0.1274],
                [51.5072, 0.1275],
              ]
            ]
          ]
        },
        'lat': '51.5072',
        'lon': '0.1275',
      };
      expect(() => GeoDataModel.fromJson(json), isNotNull);
    });

    test('GeoDataModel should have correct properties', () {
      final json = {
        'geojson': {
          'type': 'Polygon',
          'coordinates': [
            [
              [37.7749, -122.4194],
              [37.7753, -122.4192],
              [37.7751, -122.4191],
              [37.7749, -122.4194],
            ]
          ]
        },
        'lat': '37.7749',
        'lon': '-122.4194',
      };
      final geoDataModel = GeoDataModel.fromJson(json);
      expect(geoDataModel.geoDataType, GeoDataType.polygon);
      expect(geoDataModel.center, const LatLng(37.7749, -122.4194));
      expect(geoDataModel.coordinates, [
        [
          [37.7749, -122.4194],
          [37.7753, -122.4192],
          [37.7751, -122.4191],
          [37.7749, -122.4194],
        ]
      ]);
    });
  });
}
