import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:state_selector/features/domain/redux/app/app_reducer.dart';
import 'package:state_selector/features/domain/redux/app/app_state.dart';

class AppInitialization {
  static Future<Store<AppState>> initRedux() async {
    // remotedev --port 8000
    RemoteDevToolsMiddleware? remoteDevTools;

    if (kDebugMode) {
      remoteDevTools = RemoteDevToolsMiddleware('10.0.2.2:8000');
      await remoteDevTools.connect();
    }

    final store = Store<AppState>(
      appReducer,
      initialState: AppState.initial(),
      middleware: [
        thunkMiddleware,
        if (remoteDevTools != null) remoteDevTools,
      ],
    );

    if (remoteDevTools != null) {
      remoteDevTools.store = store;
    }

    return store;
  }

  static void initSystem() {
    const uiOverlay = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(uiOverlay);
  }
}
