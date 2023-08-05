import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_isar_riverpod_playground/src/supabase/init.dart';

import '../provider/authentication.provider.dart';

Future<void> pktbsSignup(BuildContext context, AuthProvider notifier,
    [bool autoSignin = true]) async {
  EasyLoading.show(status: 'Creating account...');
  try {
    await sbc.auth
        .signUp(
      email: notifier.emailCntrlr.text,
      password: notifier.pwdCntrlr.text,
    )
        .then((value) {
      EasyLoading.showSuccess('Account created successfully!');
      notifier.clear();
    });
  } catch (e) {
    EasyLoading.dismiss();
    EasyLoading.showError(e.toString());
  }
}
