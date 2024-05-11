import 'package:state_selector/core/api/async_process.dart';
import 'package:state_selector/features/domain/models/geo_data_model.dart';

class MapsState {
  GeoDataModel? countryGeoData;
  GeoDataModel? stateGeoData;

  AsyncProcess loadingGeoDataProccess = AsyncProcess();

  Map<String, dynamic> toJson() {
    return {
      'countryGeoData': countryGeoData,
      'stateGeoData': stateGeoData,
      'loadingGeoDataProccess': loadingGeoDataProccess,
    };
  }
}
