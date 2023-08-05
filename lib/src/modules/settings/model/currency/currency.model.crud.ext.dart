part of 'currency.model.dart';

const bdtNumberFormat = '৳#,##,##0.00#';
const usdNumberFormat = '\$#,##0.00';

extension CurrencyTrxExt on CurrencyProfile {
  String? get numberPattern => shortForm == 'BDT' ? bdtNumberFormat : null;

  void saveSync() => db.write((_) => db.currencyProfiles.put(this));

  Future<void> save() async =>
      await db.writeAsync((_) => db.currencyProfiles.put(this));

  bool deleteSync() => db.write((_) => db.currencyProfiles.delete(this.id));

  Future<bool> delete() async =>
      await db.writeAsync((_) => db.currencyProfiles.delete(this.id));
}

extension ListCurrencyTrxExt on List<CurrencyProfile> {
  void saveAllSync() => db.write((_) => db.currencyProfiles.putAll(this));

  Future<void> saveAll() async =>
      await db.writeAsync((_) => db.currencyProfiles.putAll(this));

  void deleteAllSync() =>
      db.write((_) => db.currencyProfiles.deleteAll(map((e) => e.id).toList()));

  Future<void> deleteAll() async => await db.writeAsync(
      (_) => db.currencyProfiles.deleteAll(map((e) => e.id).toList()));
}
