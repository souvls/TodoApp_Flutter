import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist_app/routes/routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
      initialLocation: RouteLocation.home,
      navigatorKey: navigationKey,
      routes: appRoutes);
});
