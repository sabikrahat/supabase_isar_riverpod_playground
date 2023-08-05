part of 'settings.model.dart';

extension AppSettingsDBExt on AppSettings {
  void saveSync() => db.write((_) => db.appSettings.put(this));

  Future<void> save() async =>
      await db.writeAsync((_) => db.appSettings.put(this));

  bool deleteSync() => db.write((_) => db.appSettings.delete(this.id));

  Future<bool> delete() async =>
      await db.writeAsync((_) => db.appSettings.delete(this.id));
}
