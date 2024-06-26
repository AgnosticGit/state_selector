import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:state_selector/core/api/failure.dart';
import 'package:state_selector/core/api/v1/api_headers_v1.dart';
import 'package:state_selector/core/api/v1/api_urls_v1.dart';
import 'package:state_selector/core/l10n/failures.dart';
import 'package:state_selector/features/domain/models/state_model.dart';

class StatesRepository {
  static Future<Either<Failure, List<StateModel>>> getStates(int countryId) async {
    try {
      final response = await Dio(
        BaseOptions(headers: ApiHeadersV1.accessHeader),
      ).get(APIUrlsV1.states(countryId));

      final mapList = response.data as List;
      final states = mapList.map((e) => StateModel.fromJson(e)).toList();

      return Right(states);
    } catch (e) {
      return const Left(Failures.networkError);
    }
  }
}
