import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:state_selector/features/domain/redux/app/app_state.dart';

class MapsLoadingIndicator extends StatelessWidget {
  const MapsLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (_, store) {
      final mapsState = store.state.mapsState;
      final isLoading = mapsState.loadingGeoDataProccess.loading;

      if (!isLoading) return const SizedBox();

      return const Align(
        child: SizedBox(
          width: 150,
          height: 150,
          child: LoadingIndicator(
            indicatorType: Indicator.ballScaleRipple,
            strokeWidth: 3,
            colors: [Colors.blue],
          ),
        ),
      );
    });
  }
}
