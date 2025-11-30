import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = AsyncNotifierProvider<AuthController, void>(
  AuthController.new,
);

class AuthController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> register({
    required String email,
    required String password,
    required String confirm,
  }) async {
    if (email.isEmpty || password.isEmpty || confirm.isEmpty) {
      throw ArgumentError('未入力の項目があります');
    }
    if (password != confirm) {
      throw ArgumentError('パスワードが一致しません');
    }

    state = const AsyncLoading();
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
