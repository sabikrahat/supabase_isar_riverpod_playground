import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/constants.dart';
import '../../../utils/extensions/extensions.dart';
import '../../settings/view/advance/url.config.tile.dart';
import '../provider/authentication.provider.dart';
import 'components/app.bar.dart';
import 'components/button.dart';
import 'components/form.dart';
import 'components/image.select.dart';
import 'components/signup.text.dart';

class AuthenticationView extends ConsumerWidget {
  const AuthenticationView({this.isSignup = false, super.key});

  static const name = '/authentication';
  static const label = 'Authentication - $appName';

  final bool isSignup;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authProvider(isSignup));
    final notifier = ref.read(authProvider(isSignup).notifier);
    return Scaffold(
      appBar: AuthAppBar(notifier),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: min(400, context.width),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5.0,
                  child: AnimatedContainer(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 10.0),
                    duration: const Duration(milliseconds: 200),
                    child: Column(
                      mainAxisSize: mainMin,
                      children: [
                        AuthImageSelect(notifier),
                        AuthForm(notifier),
                        AuthSignupText(notifier),
                        AuthButton(notifier),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: isSignup
          ? null
          : IconButton(
              icon: const Icon(Icons.settings, size: 20.0),
              onPressed: () async => await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const URLConfigPopup(),
              ),
            ),
    );
  }
}
