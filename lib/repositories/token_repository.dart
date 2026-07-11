import 'package:arculus/utils/app_database.dart';
import 'package:drift/drift.dart';

class TokenRepository {
  final AppDatabase _db;

  TokenRepository(this._db);

  Future<List<Token>> getAllTokens() {
    return _db.select(_db.tokens).get();
  }

  Stream<List<Token>> watchAllTokens() {
    return _db.select(_db.tokens).watch();
  }

  Future<int> getTokenCount() async {
    final countExpression = countAll();
    final query = _db.selectOnly(_db.tokens)..addColumns([countExpression]);
    final row = await query.getSingle();

    return row.read(countExpression) ?? 0;
  }

  Future<int> insertToken(TokensCompanion token) {
    return _db.into(_db.tokens).insert(token);
  }

  Future<bool> deleteToken(int id) async {
    final count = await (_db.delete(
      _db.tokens,
    )..where((t) => t.id.equals(id))).go();

    return count > 0;
  }
}
