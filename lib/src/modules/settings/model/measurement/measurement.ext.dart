part of 'measurement.dart';

extension MeasurementTrxExt on Measurement {
  
  void saveSync() => db.write((_) => db.measurements.put(this));

  Future<void> save() async =>
      await db.writeAsync((_) => db.measurements.put(this));

  bool deleteSync() => db.write((_) => db.measurements.delete(this.id));

  Future<bool> delete() async =>
      await db.writeAsync((_) => db.measurements.delete(this.id));
}

extension ListMeasurementTrxExt on List<Measurement> {

  void saveAllSync() => db.write((_) => db.measurements.putAll(this));

  Future<void> saveAll() async =>
      await db.writeAsync((db) => db.measurements.putAll(this));

  void deleteAllSync() => db
      .write((_) => db.measurements.deleteAll(map((e) => e.id).toList()));

  Future<void> deleteAll() async => await db.writeAsync(
      (_) => db.measurements.deleteAll(map((e) => e.id).toList()));
}

extension MeasurementStringExt on String {
  Measurement? get getMeasurement {
    return appMeasurements.any((e) => e.name == this)
        ? appMeasurements.firstWhere((e) => e.name == this)
        : null;
  }
}
