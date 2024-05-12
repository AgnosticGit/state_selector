import 'package:latlong2/latlong.dart';
import 'package:state_selector/core/constants/enums.dart';

class GeoDataModel {
  const GeoDataModel({
    required this.geoDataType,
    required this.center,
    required this.coordinates,
  });

  final GeoDataType geoDataType;
  final LatLng center;
  final List coordinates;

  factory GeoDataModel.fromJson(Map<String, dynamic> json) {
    final geoJson = json['geojson'];
    final lat = double.parse(json['lat']);
    final lon = double.parse(json['lon']);
    final center = LatLng(lat, lon);

    return GeoDataModel(
      center: center,
      geoDataType:
          geoJson['type'] == 'MultiPolygon' ? GeoDataType.multiPolygon : GeoDataType.polygon,
      coordinates: geoJson['coordinates'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'geoDataType': geoDataType.toString(),
      'coordinates': coordinates,
    };
  }
}
