import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:state_selector/app_initialization.dart';
import 'package:state_selector/core/navigation/navigation.dart';
import 'package:state_selector/features/domain/redux/app/app_state.dart';

void main() async {
  final store = await AppInitialization.initRedux();
  AppInitialization.initSystem();

  runApp(Application(store: store));
}

class Application extends StatelessWidget {
  static final globalContextKey = GlobalKey();

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
        builder: (_, page) {
          return Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (_) {
                  return SizedBox(
                    key: globalContextKey,
                    child: page,
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
