import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_isar_riverpod_playground/src/modules/authentication/api/authentication.api.dart';

typedef AuthNotifier
    = AutoDisposeNotifierProviderFamily<AuthProvider, void, bool>;

final authProvider = AuthNotifier(AuthProvider.new);

class AuthProvider extends AutoDisposeFamilyNotifier<void, bool> {
  final TextEditingController pwdConfirmCntrlr = TextEditingController();
  final TextEditingController usernameCntrlr = TextEditingController();
  final TextEditingController emailCntrlr = TextEditingController();
  final TextEditingController nameCntrlr = TextEditingController();
  final TextEditingController pwdCntrlr = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool pwdConfirmObscure = true;
  bool pwdObscure = true;
  dynamic image;

  late bool isSignup;

  @override
  void build(bool arg) => isSignup = arg;

  void toggleIsSignup() {
    isSignup = !isSignup;
    ref.notifyListeners();
  }

  void togglePwdObscure() {
    pwdObscure = !pwdObscure;
    ref.notifyListeners();
  }

  void toggleConfirmPwdObscure() {
    pwdConfirmObscure = !pwdConfirmObscure;
    ref.notifyListeners();
  }

  void setImage(var img) {
    image = img;
    ref.notifyListeners();
  }

  void removeImage() {
    image = null;
    ref.notifyListeners();
  }

  void clear() {
    formKey = GlobalKey<FormState>();
    usernameCntrlr.clear();
    emailCntrlr.clear();
    pwdCntrlr.clear();
    pwdConfirmCntrlr.clear();
    nameCntrlr.clear();
    image = null;
    ref.notifyListeners();
  }

  Future<void> submit(BuildContext context) async =>
      isSignup ? await signup(context) : await signin(context);

  Future<void> signup(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    await spbsSignup(context, this, false);
  }

  Future<void> signin(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    await spbsSignin(context, this);
  }
}
