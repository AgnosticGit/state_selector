import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:state_selector/app_initialization.dart';
import 'package:state_selector/core/navigation/navigation.dart';
import 'package:state_selector/features/domain/redux/app/app_state.dart';
import 'package:state_selector/pages/start/start_page.dart';

void main() async {
  final store = await AppInitialization.initRedux();
  AppInitialization.initSystem();

  runApp(Application(store: store));
}

class Application extends StatelessWidget {
  const Application({
    required this.store,
    super.key,
  });

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: Navigation.routerConfig,
      ),
    );
  }
}
