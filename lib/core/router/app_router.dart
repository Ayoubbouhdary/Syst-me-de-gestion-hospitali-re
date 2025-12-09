import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/auth_providers.dart';
import '../../features/auth/presentation/auth_providers.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/items/presentation/items_list_screen.dart';
import '../../features/items/presentation/item_detail_screen.dart';
import '../../features/patients/presentation/patients_list_screen.dart';
import '../../features/patients/presentation/patient_detail_screen.dart';
import '../../features/patients/presentation/patient_form_screen.dart';
import '../../features/services/presentation/services_list_screen.dart';
import '../../features/soins/presentation/soins_list_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'items',
            builder: (context, state) => const ItemsListScreen(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return ItemDetailScreen(id: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'patients',
            builder: (context, state) => const PatientsListScreen(),
            routes: [
              GoRoute(
                path: 'new',
                builder: (context, state) => const PatientFormScreen(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return PatientDetailScreen(id: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'services',
            builder: (context, state) => const ServicesListScreen(),
          ),
          GoRoute(
            path: 'soins',
            builder: (context, state) => const SoinsListScreen(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final authState = ref.watch(authStateProvider);
      return authState.when(
        data: (user) {
          final isLoggedIn = user != null;
          final isLoginRoute = state.uri.path == '/login';

          if (isLoggedIn && isLoginRoute) {
            return '/';
          }
          if (!isLoggedIn && !isLoginRoute) {
            return '/login';
          }
          return null;
        },
        error: (_, __) => '/login',
        loading: () => null, // Or a splash screen
      );
    },
  );
}
