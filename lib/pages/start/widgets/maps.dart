import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:latlong2/latlong.dart';
import 'package:state_selector/core/constants/enums.dart';
import 'package:state_selector/core/constants/links.dart';
import 'package:state_selector/features/domain/models/geo_data_model.dart';
import 'package:state_selector/features/domain/redux/app/app_state.dart';

class Maps extends StatelessWidget {
  const Maps({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (_, store) {
        final mapsState = store.state.mapsState;

        return SizedBox(
          height: 500,
          child: FlutterMap(
            options: const MapOptions(
              initialZoom: 2,
            ),
            children: [
              TileLayer(
                urlTemplate: Links.mapsTemplateUrl,
                userAgentPackageName: 'com.example.app',
              ),
              Builder(
                builder: (context) {
                  final geoData = mapsState.stateGeoData ?? mapsState.countryGeoData;

                  if (geoData == null) return const SizedBox();

                  if (geoData.geoDataType == GeoDataType.polygon) {
                    final first = geoData.coordinates.first as List;
                    final points =
                        first.map((e) => LatLng(e[1].toDouble(), e[0].toDouble())).toList();

                    return PolygonLayer(
                      polygons: [
                        Polygon(
                          color: Colors.red,
                          borderColor: Colors.red,
                          borderStrokeWidth: 3,
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
                      color: Colors.red,
                      borderColor: Colors.red,
                      borderStrokeWidth: 3,
                      points: points.toList(),
                    );
                  });

                  return PolygonLayer(polygons: multiPolygons.toList());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
