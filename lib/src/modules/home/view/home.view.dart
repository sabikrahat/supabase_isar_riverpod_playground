import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:supabase_isar_riverpod_playground/app.routes.dart';
import 'package:supabase_isar_riverpod_playground/src/supabase/init.dart';

import '../../../config/constants.dart';
import '../../authentication/view/authentication.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const name = '/home';
  static const label = appName;

  @override
  Widget build(BuildContext context) {
    // if (!isServerRunning) return const KServerNotRunning();
    if (sbc.auth.currentUser == null) return const AuthenticationView();
    // if (isUnderMinSize(context.mq.size)) return const ScreenEnlargeWarning();
    return Scaffold(
      appBar: AppBar(title: const Text('Supabase Isar Riverpod')),
      body: const Center(child: Text('Hello World!')),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => context.beamToNamed(AppRoutes.settingsRoute),
        child: const Icon(Icons.settings),
      ),
    );
  }
}
