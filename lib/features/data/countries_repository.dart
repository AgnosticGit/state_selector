import 'package:either_dart/either.dart';
import 'package:state_selector/core/api/failure.dart';
import 'package:state_selector/core/api/v1/api_urls_v1.dart';
import 'package:state_selector/features/domain/models/country_model.dart';
import 'package:dio/dio.dart';

class CountriesRepository {
  static Future<Either<Failure, List<CountryModel>>> getCountries() async {
    try {
      final response = await Dio(
        BaseOptions(headers: {
          'X-API-Key': 'sA,{tzUD=]dHvYNBJ4xVZ3c=&zS%.UqVc{But?kc',
          'User-Agent': 'com.stagingcupid.api/10.16.6 (Release) Android/31',
        }),
      ).get(APIUrlsV1.countries);

      final mapList = response.data as List;
      final countries = mapList.map((e) => CountryModel.fromJson(e)).toList();

      return Right(countries);
    } catch (e) {
      return Left(Failure(1, ''));
    }
  }
}
