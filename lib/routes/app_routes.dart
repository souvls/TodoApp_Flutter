import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist_app/routes/routes.dart';
import 'package:todolist_app/screens/screens.dart';

final navigationKey = GlobalKey<NavigatorState>();
final appRoutes = [
  GoRoute(
      path: RouteLocation.home,
      parentNavigatorKey: navigationKey,
      builder: HomeScreen.builder),
  GoRoute(
      path: RouteLocation.createTask,
      parentNavigatorKey: navigationKey,
      builder: CreateTaskScreen.builder)
];
