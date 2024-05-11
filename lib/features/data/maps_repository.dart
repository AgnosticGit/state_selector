import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:latlong2/latlong.dart';
import 'package:state_selector/core/api/failure.dart';
import 'package:state_selector/core/constants/links.dart';
import 'package:state_selector/features/domain/models/geo_data_model.dart';

class MapsRepository {
  static Future<Either<Failure, GeoDataModel>> getCountryGeoData(String country) async {
    try {
      final url = Links.countryGeoDataUrl(country);
      final response = await Dio().get<List>(url);
      final geoJson = response.data!.first['geojson'];

      return Right(GeoDataModel.fromJson(geoJson));
    } catch (e) {
      return Left(Failure(1, ''));
    }
  }

  static Future<Either<Failure, GeoDataModel>> getStateGeoData({
    required String country,
    required String state,
  }) async {
    try {
      final url = Links.stateGeoDataUrl(country, state);
      final response = await Dio().get<List>(url);
      final geoJson = response.data!.first['geojson'];

      return Right(GeoDataModel.fromJson(geoJson));
    } catch (e) {
      return Left(Failure(1, ''));
    }
  }
}
