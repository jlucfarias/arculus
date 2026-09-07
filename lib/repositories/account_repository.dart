import 'package:drift/drift.dart';

import 'package:arculus/repositories/base_repository.dart';
import 'package:arculus/utils/app_database.dart';

class AccountRepository
    extends BaseRepository<$AccountsTable, Account, int, AccountsCompanion> {
  AccountRepository(AppDatabase db)
    : super(db, db.accounts, (table) => table.id);

  Stream<List<(Account, List<int>)>> watchAllWithFolderIds() {
    final query = db.select(db.accounts).join([
      leftOuterJoin(
        db.accountFolder,
        db.accountFolder.accountId.equalsExp(db.accounts.id),
      ),
    ]);

    return query.watch().map((rows) {
      final Map<int, (Account, List<int>)> grouped = {};

      for (final row in rows) {
        final account = row.readTable(db.accounts);
        final folderEntry = row.readTableOrNull(db.accountFolder);

        if (!grouped.containsKey(account.id)) {
          grouped[account.id] = (account, <int>[]);
        }

        if (folderEntry != null) {
          grouped[account.id]!.$2.add(folderEntry.folderId);
        }
      }

      return grouped.values.toList();
    });
  }

  Future<bool> saveAccountInFolders({
    required int accountId,
    required Set<int> folders,
  }) async {
    try {
      await db.transaction(() async {
        final currentEntries = await (db.select(
          db.accountFolder,
        )..where((t) => t.accountId.equals(accountId))).get();
        final currentFoldersIds = currentEntries.map((e) => e.folderId).toSet();

        final toDelete = currentFoldersIds.difference(folders);
        final toInsert = folders.difference(currentFoldersIds);

        if (toDelete.isNotEmpty) {
          await (db.delete(db.accountFolder)..where(
                (t) =>
                    t.accountId.equals(accountId) & t.folderId.isIn(toDelete),
              ))
              .go();
        }

        if (toInsert.isNotEmpty) {
          await db.batch((batch) {
            batch.insertAll(
              db.accountFolder,
              toInsert.map(
                (folderId) => AccountFolderCompanion.insert(
                  accountId: accountId,
                  folderId: folderId,
                ),
              ),
            );
          });
        }
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteFromAllFolders(int accountId) async {
    try {
      await db.transaction(() async {
        final currentEntries = await (db.select(
          db.accountFolder,
        )..where((t) => t.accountId.equals(accountId))).get();
        final currentFoldersIds = currentEntries.map((e) => e.folderId).toSet();

        if (currentFoldersIds.isNotEmpty) {
          await (db.delete(db.accountFolder)..where(
                (t) =>
                    t.accountId.equals(accountId) &
                    t.folderId.isIn(currentFoldersIds),
              ))
              .go();
        }
      });

      return true;
    } catch (e) {
      return false;
    }
  }
}
