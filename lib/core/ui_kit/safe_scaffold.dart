import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SafeScaffold extends StatelessWidget {
  const SafeScaffold({
    this.body,
    this.systemUIOverlayStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 0),
    this.appBar,
    this.scaffoldKey,
    this.drawer,
    this.bottomNavigationBar,
    this.customBottomNavigationBar,
    this.drawerScrimColor,
    this.backgroundColor,
    this.hideKeyboardWhenTap = true,
    this.floatingActionButton,
    this.disabledPop = false,
    this.top = true,
    this.bottom = true,
    this.onWillPop,
    super.key,
  });

  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final bool disabledPop;
  final bool top;
  final bool bottom;
  final BottomNavigationBar? bottomNavigationBar;
  final Widget? customBottomNavigationBar;
  final SystemUiOverlayStyle? systemUIOverlayStyle;

  final Widget? drawer;
  final Color? drawerScrimColor;

  final bool hideKeyboardWhenTap;

  final Widget? floatingActionButton;

  final Future<bool> Function()? onWillPop;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboardWhenTap ? FocusScope.of(context).unfocus : null,
      child: _wrapAnnotatedRegion(
        child: Scaffold(
          key: scaffoldKey,
          floatingActionButton: floatingActionButton,
          appBar: appBar,
          drawer: drawer,
          backgroundColor: backgroundColor,
          bottomNavigationBar: bottomNavigationBar,
          body: SafeArea(
            top: top,
            bottom: bottom,
            child: Padding(
              padding: padding,
              child: Column(
                children: [
                  if (body != null) Expanded(child: body!),
                  if (customBottomNavigationBar != null) customBottomNavigationBar!,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _wrapAnnotatedRegion({
    required Widget child,
  }) {
    if (systemUIOverlayStyle == null) {
      return child;
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUIOverlayStyle!,
      child: child,
    );
  }
}
