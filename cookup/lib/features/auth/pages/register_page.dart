import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import '../widgets/button.dart';
import '../controllers/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(authControllerProvider);
    final loading = async.isLoading;

    return Scaffold(
      backgroundColor: const Color(0xFFFF9538),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF9538),
        leading: IconButton(
          icon: const Text(
            '<',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Text(
                'アカウント登録',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              _field(label: 'メールアドレス', controller: email),
              _field(label: 'パスワード', controller: password, obscure: true),
              _field(label: 'パスワード確認', controller: confirm, obscure: true),
              const Spacer(),
              AuthButton(
                label: '登録',
                loading: loading,
                onPressed: () async {
                  final ctx = context;
                  try {
                    await ref
                        .read(authControllerProvider.notifier)
                        .register(
                          email: email.text.trim(),
                          password: password.text,
                          confirm: confirm.text,
                        );
                    if (!ctx.mounted) return;
                    context.go('/login');
                  } on ArgumentError catch (e) {
                    if (!ctx.mounted) return;
                    ScaffoldMessenger.of(ctx).showSnackBar(
                      SnackBar(content: Text(e.message.toString())),
                    );
                  } catch (_) {
                    if (!ctx.mounted) return;
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('登録に失敗しました')));
                  }
                },
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _field({
  required String label,
  required TextEditingController controller,
  bool obscure = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: AuthTextField(
      controller: controller,
      label: label,
      obscure: obscure,
    ),
  );
}
