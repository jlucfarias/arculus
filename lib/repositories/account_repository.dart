import 'package:arculus/utils/app_database.dart';
import 'package:drift/drift.dart';

class AccountRepository {
  final AppDatabase _db;

  AccountRepository(this._db);

  Future<List<Account>> getAllAccounts() {
    return _db.select(_db.accounts).get();
  }

  Stream<List<Account>> watchAllAccounts() {
    return _db.select(_db.accounts).watch();
  }

  Future<Account?> getAccountById(int id) async {
    return await (_db.select(_db.accounts)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> getAccountCount() async {
    final countExpression = countAll();
    final query = _db.selectOnly(_db.accounts)..addColumns([countExpression]);
    final row = await query.getSingle();

    return row.read(countExpression) ?? 0;
  }

  Future<int> insertAccount(AccountsCompanion account) {
    return _db.into(_db.accounts).insert(account);
  }

  Future<bool> updateAccount(AccountsCompanion account) async {
    return await (_db.update(_db.accounts).replace(account));
  }

  Future<bool> deleteAccount(int id) async {
    final count = await (_db.delete(
      _db.accounts,
    )..where((t) => t.id.equals(id))).go();

    return count > 0;
  }
}
