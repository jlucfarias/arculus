import 'package:drift/drift.dart';
import 'package:flutter/material.dart' hide Table;

import 'package:arculus/utils/app_database.dart';

class BaseRepository<
  T extends Table,
  D,
  ID extends Object,
  C extends Insertable<D>
> {
  @protected
  final AppDatabase db;
  final TableInfo<T, D> table;
  final Expression Function(T) primaryKeyColumn;

  BaseRepository(this.db, this.table, this.primaryKeyColumn);

  Future<List<D>> getAll() {
    return db.select(table).get();
  }

  Stream<List<D>> watchAll() {
    return db.select(table).watch();
  }

  Future<D?> getById(ID id) async {
    return await (db.select(
      table,
    )..where((t) => primaryKeyColumn(t).equals(id))).getSingleOrNull();
  }

  Future<int> getCount() async {
    final countExpression = countAll();
    final query = db.selectOnly(table)..addColumns([countExpression]);
    final row = await query.getSingle();

    return row.read(countExpression) ?? 0;
  }

  Stream<int> watchCount() {
    final countExpression = countAll();
    final query = db.selectOnly(table)..addColumns([countExpression]);

    return query.watchSingle().map((row) => row.read(countExpression) ?? 0);
  }

  Future<int> insert(C item) {
    return db.into(table).insert(item);
  }

  Future<bool> update(C item) async {
    return await (db.update(table).replace(item));
  }

  Future<bool> delete(ID id) async {
    final count = await (db.delete(
      table,
    )..where((t) => primaryKeyColumn(t).equals(id))).go();

    return count > 0;
  }
}
