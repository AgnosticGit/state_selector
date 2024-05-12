import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:state_selector/core/api/failure.dart';
import 'package:state_selector/core/constants/links.dart';
import 'package:state_selector/core/l10n/failures.dart';
import 'package:state_selector/features/domain/models/geo_data_model.dart';

class MapsRepository {
  static Future<Either<Failure, GeoDataModel>> getCountryGeoData(String country) async {
    try {
      final url = Links.countryGeoDataUrl(country);
      final response = await Dio().get<List>(url);

      if (response.data != null && response.data!.isEmpty) {
        return const Left(Failures.countryNotFound);
      }

      final geoData = response.data!.first;

      return Right(GeoDataModel.fromJson(geoData));
    } catch (e) {
      return const Left(Failures.networkError);
    }
  }

  static Future<Either<Failure, GeoDataModel>> getStateGeoData({
    required String country,
    required String state,
  }) async {
    try {
      final url = Links.stateGeoDataUrl(country, state);
      final response = await Dio().get<List>(url);

      if (response.data != null && response.data!.isEmpty) {
        return const Left(Failures.stateNotFound);
      }

      final geoData = response.data!.first;

      return Right(GeoDataModel.fromJson(geoData));
    } catch (e) {
      return const Left(Failures.networkError);
    }
  }
}
