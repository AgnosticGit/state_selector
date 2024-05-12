import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:state_selector/features/domain/redux/app/app_reducer.dart';
import 'package:state_selector/features/domain/redux/app/app_state.dart';
import 'package:state_selector/features/domain/redux/app/middlewares/failures_middleware.dart';

class AppInitialization {
  AppInitialization._();

  static Future<Store<AppState>> initRedux() async {
    /// [Disabled for review]

    // remotedev --port 8000
    // RemoteDevToolsMiddleware? remoteDevTools;

    // if (kDebugMode) {
    //   remoteDevTools = RemoteDevToolsMiddleware('10.0.2.2:8000');
    //   await remoteDevTools.connect();
    // }

    final store = Store<AppState>(
      appReducer,
      initialState: AppState.initial(),
      middleware: [
        failureHandlingMiddleware,
        thunkMiddleware,
        // if (remoteDevTools != null) remoteDevTools,
      ],
    );

    // if (remoteDevTools != null) {
    //   remoteDevTools.store = store;
    // }

    return store;
  }

  static void initSystem() {
    const uiOverlay = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(uiOverlay);
  }
}
