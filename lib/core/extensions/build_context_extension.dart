import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:state_selector/features/domain/redux/app/app_state.dart';

extension BuildContextExtension on BuildContext {
  bool get isKeyboardShown => MediaQuery.of(this).viewInsets.bottom != 0;

  Store<AppState> get store => StoreProvider.of<AppState>(this);

  dynamic dispatch(action) => store.dispatch(action);

  AppState get state => store.state;
}
