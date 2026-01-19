import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../navigation/home_bottom_nav.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/challenge_tab.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF9538),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF9538),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: const ChallengeTab(),
        ),
      ),
      bottomNavigationBar: HomeBottomNavigationBar(
        selectedIndex: HomeBottomNav.home,
        onDestinationSelected: (index) {
          if (index == HomeBottomNav.home) {
            return;
          }
          HomeBottomNav.goToIndex(context, index);
        },
      ),
    );
  }
}
