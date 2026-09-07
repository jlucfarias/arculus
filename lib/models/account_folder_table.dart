import 'package:drift/drift.dart';

import 'package:arculus/models/accounts_table.dart';
import 'package:arculus/models/folders_table.dart';

class AccountFolder extends Table {
  IntColumn get accountId => integer().references(Accounts, #id)();
  IntColumn get folderId => integer().references(Folders, #id)();

  @override
  Set<Column> get primaryKey => {accountId, folderId};
}
