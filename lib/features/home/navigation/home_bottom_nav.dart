import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeBottomNav {
  static const int challenge = 0;
  static const int history = 1;
  static const int home = 2;
  static const int settings = 3;

  static void goToIndex(BuildContext context, int index) {
    switch (index) {
      case challenge:
        context.go('/challenge');
        break;
      case history:
        context.go('/history');
        break;
      case home:
        context.go('/home');
        break;
      case settings:
        // TODO: 設定ページへの遷移を実装
        break;
    }
  }
}
