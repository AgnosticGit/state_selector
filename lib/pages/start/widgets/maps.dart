import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:latlong2/latlong.dart';
import 'package:state_selector/core/constants/enums.dart';
import 'package:state_selector/core/constants/links.dart';
import 'package:state_selector/features/domain/redux/app/app_state.dart';

class Maps extends StatelessWidget {
  const Maps({
    required this.mapController,
    super.key,
  });

  final MapController mapController;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (_, store) {
        final mapsState = store.state.mapsState;

        return FlutterMap(
          mapController: mapController,
          options: const MapOptions(
            initialZoom: 2,
            backgroundColor: Colors.white,
          ),
          children: [
            TileLayer(
              urlTemplate: Links.mapsTemplateUrl,
              userAgentPackageName: 'com.example.app',
            ),
            Builder(
              builder: (context) {
                final geoData = mapsState.countryGeoData;

                if (geoData == null) return const SizedBox();

                if (geoData.geoDataType == GeoDataType.polygon) {
                  final first = geoData.coordinates.first as List;
                  final points =
                      first.map((e) => LatLng(e[1].toDouble(), e[0].toDouble())).toList();

                  return PolygonLayer(
                    polygons: [
                      Polygon(
                        color: Colors.blue,
                        borderColor: Colors.blue,
                        borderStrokeWidth: 2,
                        points: points,
                      ),
                    ],
                  );
                }

                final multiPolygons = geoData.coordinates.map((e) {
                  final list = e as List;
                  final first = list.first as List;
                  final points = first.map((a) => LatLng(a[1].toDouble(), a[0].toDouble()));

                  return Polygon(
                    color: Colors.blue,
                    borderColor: Colors.blue,
                    borderStrokeWidth: 2,
                    points: points.toList(),
                  );
                });

                return PolygonLayer(polygons: multiPolygons.toList());
              },
            ),
            Builder(
              builder: (context) {
                final geoData = mapsState.stateGeoData;

                if (geoData == null) return const SizedBox();

                if (geoData.geoDataType == GeoDataType.polygon) {
                  final first = geoData.coordinates.first as List;
                  final points =
                      first.map((e) => LatLng(e[1].toDouble(), e[0].toDouble())).toList();

                  return PolygonLayer(
                    polygons: [
                      Polygon(
                        color: Colors.green,
                        borderColor: Colors.green,
                        borderStrokeWidth: 2,
                        points: points,
                      ),
                    ],
                  );
                }

                final multiPolygons = geoData.coordinates.map((e) {
                  final list = e as List;
                  final first = list.first as List;
                  final points = first.map((a) => LatLng(a[1].toDouble(), a[0].toDouble()));

                  return Polygon(
                    color: Colors.green,
                    borderColor: Colors.green,
                    borderStrokeWidth: 2,
                    points: points.toList(),
                  );
                });

                return PolygonLayer(polygons: multiPolygons.toList());
              },
            ),
          ],
        );
      },
    );
  }
}
