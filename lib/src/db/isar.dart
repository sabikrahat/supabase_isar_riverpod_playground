import 'dart:convert';

import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:supabase_isar_riverpod_playground/src/config/constants.dart';
import 'package:supabase_isar_riverpod_playground/src/utils/extensions/extensions.dart';

import '../config/get.platform.dart';
import '../modules/settings/model/currency/currency.model.dart';
import '../modules/settings/model/measurement/measurement.dart';
import '../modules/settings/model/settings.model.dart';
import '../utils/logger/logger_helper.dart';
import 'paths.dart' show AppDir, appDir, initDir;

late final Isar db;
late AppSettings appSettings;
late CurrencyProfile appCurrency;
late List<Measurement> appMeasurements;

const _schemas = [AppSettingsSchema, CurrencyProfileSchema, MeasurementSchema];

Future<void> openDB() async {
  await initDir();
  db = await Isar.openAsync(
    schemas: _schemas,
    inspector: !kReleaseMode,
    name: appName.toCamelWord,
    directory: pt.isWeb ? '' : appDir.db.path,
    engine: pt.isWeb ? IsarEngine.sqlite : IsarEngine.isar,
  );
}

void openDBSync(AppDir dir) => db = Isar.open(
      schemas: _schemas,
      directory: dir.db.path,
      inspector: !kReleaseMode,
      name: appName.toCamelWord,
      engine: pt.isWeb ? IsarEngine.sqlite : IsarEngine.isar,
    );

Future<void> initAppDatum() async {
  if (await db.currencyProfiles.where().countAsync() == 0) await currencyInit();
  if (await db.measurements.where().countAsync() == 0) await measurementInit();
  appSettings = await db.appSettings.getAsync(0) ?? AppSettings();
  appCurrency = (await db.currencyProfiles
      .where()
      .shortFormEqualTo(appSettings.currency)
      .findFirstAsync())!;
  appMeasurements = await db.measurements.where().findAllAsync();
  log.i(
      'App Initiated with currency: ${appCurrency.shortForm} and measurements: ${appMeasurements.length} units');
  listenForAppConfig();
}

Future<void> currencyInit() async {
  List<CurrencyProfile> currencies = [];
  final currenciesJson =
      await rootBundle.loadString('assets/json/currency_data.json');
  final jsonList = jsonDecode(currenciesJson) as List;
  for (final json in jsonList) {
    final curr = CurrencyProfile.fromJson(json);
    currencies.add(curr);
  }
  log.i('First time Currency Initiated with ${currencies.length} currencies');
  await currencies.saveAll();
}

Future<void> measurementInit() async {
  List<Measurement> measurements = [];
  final measurementsJson =
      await rootBundle.loadString('assets/json/measurement_data.json');
  final jsonList = jsonDecode(measurementsJson) as List;
  for (final json in jsonList) {
    final curr = Measurement.fromJson(json);
    measurements.add(curr);
  }
  log.i('First time Measurement Initiated with ${measurements.length} units');
  await measurements.saveAll();
}

void listenForAppConfig() =>
    db.appSettings.watchObjectLazy(0).listen((_) async {
      appSettings = await db.appSettings.getAsync(0) ?? AppSettings();
      appCurrency = (await db.currencyProfiles
          .where()
          .shortFormEqualTo(appSettings.currency)
          .findFirstAsync())!;
    });
