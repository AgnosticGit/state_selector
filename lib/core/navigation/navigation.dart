import 'package:state_selector/core/navigation/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:state_selector/pages/start/start_page.dart';

class Navigation {
  Navigation._();

  static final routerConfig = GoRouter(
    initialLocation: Routes.start,
    routes: [
      GoRoute(
        path: Routes.start,
        builder: (context, state) => const StartPage(),
      ),
    ],
  );
}
