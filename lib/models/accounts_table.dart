import 'package:drift/drift.dart';

class Accounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(max: 50)();
  TextColumn get issuer => text().withLength(max: 50).nullable()();
  TextColumn get secret => text().withLength(max: 200)();
  TextColumn get tokenType => text()();
  TextColumn get algorithm => text()();
  IntColumn get interval => integer()();
  IntColumn get digits => integer()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}
