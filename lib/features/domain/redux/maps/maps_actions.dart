import 'package:state_selector/core/api/failure.dart';
import 'package:state_selector/features/domain/models/geo_data_model.dart';

class MapsActionLoadGeoDataStarted {
  const MapsActionLoadGeoDataStarted();
}

class MapsActionLoadCountryGeoDataFinished {
  const MapsActionLoadCountryGeoDataFinished(this.countryGeoData);

  final GeoDataModel countryGeoData;

  Map<String, dynamic> toJson() {
    return {
      'countryGeoData': countryGeoData,
    };
  }
}

class MapsActionLoadStateGeoDataFinished {
  const MapsActionLoadStateGeoDataFinished(this.stateGeoData);

  final GeoDataModel stateGeoData;

  Map<String, dynamic> toJson() {
    return {
      'stateGeoData': stateGeoData,
    };
  }
}

class MapsActionLoadGeoDataFailured {
  const MapsActionLoadGeoDataFailured(this.failure);

  final Failure failure;

  Map<String, dynamic> toJson() {
    return {
      'failure': failure,
    };
  }
}
