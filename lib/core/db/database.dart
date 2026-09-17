import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:journey/core/db/daos/trips_dao.dart';
import 'package:journey/core/db/tables.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'package:journey/core/db/tables.dart' show MatchStatus, TripStatus;

part 'database.g.dart';

@DriftDatabase(tables: [Trips, TripPoints], daos: [TripsDao])
class AppDatabase extends _$AppDatabase {
  new(super.e);

  /// Opens the on-device database in a background isolate.
  new open() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      return NativeDatabase.createInBackground(
        File(p.join(dir.path, 'journey.sqlite')),
      );
    });
  }
}

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase.open();
  ref.onDispose(db.close);
  return db;
}
