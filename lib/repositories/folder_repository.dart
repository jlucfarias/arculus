import 'package:drift/drift.dart';

import 'package:arculus/repositories/base_repository.dart';
import 'package:arculus/utils/app_database.dart';

class FolderRepository
    extends BaseRepository<$FoldersTable, Folder, int, FoldersCompanion> {
  FolderRepository(AppDatabase db) : super(db, db.folders, (table) => table.id);

  Stream<List<(Folder, int)>> watchAllWithAccountsCount() {
    final countExpression = db.accountFolder.accountId.count();

    final query =
        db.select(db.folders).join([
            leftOuterJoin(
              db.accountFolder,
              db.accountFolder.folderId.equalsExp(db.folders.id),
            ),
          ])
          ..addColumns([countExpression])
          ..groupBy([db.folders.id]);

    return query.watch().map((rows) {
      return rows.map((row) {
        final folder = row.readTable(db.folders);
        final count = row.read(countExpression) ?? 0;

        return (folder, count);
      }).toList();
    });
  }
}
