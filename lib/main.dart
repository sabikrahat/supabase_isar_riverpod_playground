import 'package:beamer/beamer.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_isar_riverpod_playground/src/supabase/init.dart';

import 'src/app.dart' show App;
import 'src/config/get.platform.dart';
import 'src/db/isar.dart';
import 'src/utils/themes/themes.dart';

void main() async {
  await _init();
  runApp(const ProviderScope(child: App()));
  SystemChrome.setSystemUIOverlayStyle(uiConfig);
}

Future<void> _init() async {
  Beamer.setPathUrlStrategy();
  pt = PlatformInfo.getCurrentPlatformType();
  await openDB();
  configLoading();
  await initAppDatum();
  await initSupabase();
}

void configLoading() {
  EasyLoading.instance
    ..dismissOnTap = false
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle;
}


