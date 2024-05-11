import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:state_selector/features/data/maps_repository.dart';
import 'package:state_selector/features/domain/models/country_model.dart';
import 'package:state_selector/features/domain/models/state_model.dart';
import 'package:state_selector/features/domain/redux/app/app_state.dart';
import 'package:state_selector/features/domain/redux/maps/maps_actions.dart';

class MapsThunkLoadGeoData extends CallableThunkAction<AppState> {
  MapsThunkLoadGeoData({
    required this.country,
    this.state,
  });

  final CountryModel country;
  final StateModel? state;

  @override
  Future<void> call(Store<AppState> store) async {
    store.dispatch(const MapsActionLoadGeoDataStarted());

    if (state != null) {
      final lor = await MapsRepository.getStateGeoData(
        country: country.name,
        state: state!.name,
      );

      if (lor.isRight) {
        store.dispatch(MapsActionLoadStateGeoDataFinished(lor.right));
      } else {
        store.dispatch(MapsActionLoadGeoDataFailured(lor.left));
      }
    } else {
      final lor = await MapsRepository.getCountryGeoData(country.name);

      if (lor.isRight) {
        store.dispatch(MapsActionLoadCountryGeoDataFinished(lor.right));
      } else {
        store.dispatch(MapsActionLoadGeoDataFailured(lor.left));
      }
    }
  }
}
