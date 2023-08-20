import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_isar_riverpod_playground/src/shared/show_toast/awesome_snackbar.dart';
import 'package:supabase_isar_riverpod_playground/src/supabase/init.dart';
import 'package:supabase_isar_riverpod_playground/src/utils/extensions/extensions.dart';
import 'package:supabase_isar_riverpod_playground/src/utils/logger/logger_helper.dart';

import '../../../shared/show_toast/show_toast.dart';
import '../provider/authentication.provider.dart';

Future<void> spbsSignup(BuildContext context, AuthProvider notifier,
    [bool autoSignin = true]) async {
  EasyLoading.show(status: 'Creating account...');
  try {
    await sbc.auth.signUp(
      email: notifier.emailCntrlr.text,
      password: notifier.pwdCntrlr.text,
      data: {
        'name': notifier.nameCntrlr.text,
        'username': notifier.usernameCntrlr.text,
        'email': notifier.emailCntrlr.text,
      },
    ).then((r) {
      log.i('Supabase auth signup: ${r.user?.toJson()}');
      log.i('Supabase auth signup: ${r.session?.toJson()}');
      if (!context.mounted) return;
      showAwesomeSnackbar(context, 'Success!', 'Account created successfully.',
          MessageType.success);
      notifier.clear();
      return;
    });
  } on SocketException catch (e) {
    log.e('No Internet Connection. $e');
    if (!context.mounted) return;
    context.beamUpdate();
    showAwesomeSnackbar(
        context, 'Failed!', 'No Internet Connection. $e', MessageType.failure);
    return;
  } catch (e) {
    if (!context.mounted) return;
    showAwesomeSnackbar(context, 'Failed!', '$e', MessageType.failure);
    return;
  }
}

Future<void> spbsSignin(BuildContext context, AuthProvider notifier) async {
  EasyLoading.show(status: 'Signing in...');
  try {
    await sbc.auth
        .signInWithPassword(
      email: notifier.emailCntrlr.text,
      password: notifier.pwdCntrlr.text,
    )
        .then((r) {
      log.i('Supabase auth signin: $r');
      if (!context.mounted) return;
      context.beamUpdate();
      showAwesomeSnackbar(
          context, 'Success!', 'Signed in successfully.', MessageType.success);
      notifier.clear();
      return;
    });
  } on SocketException catch (e) {
    log.e('No Internet Connection. $e');
    if (!context.mounted) return;
    showAwesomeSnackbar(
        context, 'Failed!', 'No Internet Connection. $e', MessageType.failure);
    return;
  } catch (e) {
    if (!context.mounted) return;
    showAwesomeSnackbar(context, 'Failed!', '$e', MessageType.failure);
    return;
  }
}

Future<void> spbsSignout(BuildContext context) async {
  EasyLoading.show(status: 'Signing out...');
  try {
    await sbc.auth.signOut().then((_) async {
      log.i('User signout.');
      if (!context.mounted) return;
      context.pop();
      context.beamUpdate();
      showAwesomeSnackbar(
          context, 'Success!', 'Signed out successfully.', MessageType.success);
      return;
    });
  } on SocketException catch (e) {
    log.e('No Internet Connection. $e');
    if (!context.mounted) return;
    showAwesomeSnackbar(
        context, 'Failed!', 'No Internet Connection. $e', MessageType.failure);
    return;
  } catch (e) {
    log.e('User signout error: $e');
    if (!context.mounted) return;
    showAwesomeSnackbar(context, 'Failed!', '$e', MessageType.failure);
    return;
  }
}
