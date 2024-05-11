import 'package:latlong2/latlong.dart';
import 'package:state_selector/core/constants/enums.dart';

class GeoDataModel {
  const GeoDataModel({
    required this.geoDataType,
    required this.coordinates,
  });

  final GeoDataType geoDataType;
  final List coordinates;

  factory GeoDataModel.fromJson(Map<String, dynamic> json) {
    return GeoDataModel(
      geoDataType: json['type'] == 'MultiPolygon' ? GeoDataType.multiPolygon : GeoDataType.polygon,
      coordinates: json['coordinates'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'geoDataType': geoDataType.toString(),
      'coordinates': coordinates,
    };
  }
}
