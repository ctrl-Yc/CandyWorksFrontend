import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() {
      loading = true;
    });

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    await Future.delayed(const Duration(seconds: 1));

    setState(() => loading = false);
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF9538),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              // ロゴ画像
              Center(
                child: Image.asset(
                  'assets/cookup_logo.png',
                  width: 160,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 80),

              // メールアドレス
              Align(alignment: Alignment.centerLeft),
              const SizedBox(height: 4),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.white, width: 1),
                  ),
                ),
                child: TextField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // パスワード
              Align(alignment: Alignment.centerLeft),
              const SizedBox(height: 4),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.white, width: 1),
                  ),
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
              ),

              const SizedBox(height: 70),

              // ログインボタン
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: loading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9538),
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: const Text('Login'),
                ),
              ),

              TextButton(
                onPressed: () {
                  context.push('/register');
                },
                child: const Text('アカウント登録'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


