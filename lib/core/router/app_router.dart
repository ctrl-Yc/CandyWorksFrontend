import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cookup/features/auth/pages/login_page.dart';
import 'package:cookup/features/auth/pages/register_page.dart';
import 'package:cookup/features/history/pages/cooked_history_page.dart';
import 'package:cookup/features/history/pages/favorite_history_page.dart';
import 'package:cookup/features/history/pages/history_page.dart';
import 'package:cookup/features/challenge/pages/challenge_page.dart';
import 'package:cookup/features/home/pages/home_page.dart';
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
      GoRoute(
        path: '/challenge',
        builder: (context, state) => const ChallengePage(),
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => const HistoryPage(),
      ),
      GoRoute(
        path: '/history/cooked',
        builder: (context, state) => const CookedHistoryPage(),
      ),
      GoRoute(
        path: '/history/favorite',
        builder: (context, state) => const FavoriteHistoryPage(),
      ),
    ],
  );
});
