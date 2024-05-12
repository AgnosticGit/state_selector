import 'package:either_dart/either.dart';
import 'package:state_selector/core/api/failure.dart';
import 'package:state_selector/core/api/v1/api_headers_v1.dart';
import 'package:state_selector/core/api/v1/api_urls_v1.dart';
import 'package:state_selector/core/l10n/failures.dart';
import 'package:state_selector/features/domain/models/country_model.dart';
import 'package:dio/dio.dart';

class CountriesRepository {
  Future<Either<Failure, List<CountryModel>>> getCountries() async {
    try {
      final response = await Dio(
        BaseOptions(headers: ApiHeadersV1.accessHeader),
      ).get(APIUrlsV1.countries);

      final mapList = response.data as List;
      final countries = mapList.map((e) => CountryModel.fromJson(e)).toList();

      return Right(countries);
    } catch (e) {
      return const Left(Failures.networkError);
    }
  }
}
