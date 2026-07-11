// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TokensTable extends Tokens with TableInfo<$TokensTable, Token> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TokensTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _issuerMeta = const VerificationMeta('issuer');
  @override
  late final GeneratedColumn<String> issuer = GeneratedColumn<String>(
    'issuer',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _secretMeta = const VerificationMeta('secret');
  @override
  late final GeneratedColumn<String> secret = GeneratedColumn<String>(
    'secret',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intervalMeta = const VerificationMeta(
    'interval',
  );
  @override
  late final GeneratedColumn<int> interval = GeneratedColumn<int>(
    'interval',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _digitsMeta = const VerificationMeta('digits');
  @override
  late final GeneratedColumn<int> digits = GeneratedColumn<int>(
    'digits',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    issuer,
    secret,
    interval,
    digits,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tokens';
  @override
  VerificationContext validateIntegrity(
    Insertable<Token> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('issuer')) {
      context.handle(
        _issuerMeta,
        issuer.isAcceptableOrUnknown(data['issuer']!, _issuerMeta),
      );
    }
    if (data.containsKey('secret')) {
      context.handle(
        _secretMeta,
        secret.isAcceptableOrUnknown(data['secret']!, _secretMeta),
      );
    } else if (isInserting) {
      context.missing(_secretMeta);
    }
    if (data.containsKey('interval')) {
      context.handle(
        _intervalMeta,
        interval.isAcceptableOrUnknown(data['interval']!, _intervalMeta),
      );
    } else if (isInserting) {
      context.missing(_intervalMeta);
    }
    if (data.containsKey('digits')) {
      context.handle(
        _digitsMeta,
        digits.isAcceptableOrUnknown(data['digits']!, _digitsMeta),
      );
    } else if (isInserting) {
      context.missing(_digitsMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Token map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Token(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      issuer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}issuer'],
      ),
      secret: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}secret'],
      )!,
      interval: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval'],
      )!,
      digits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}digits'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $TokensTable createAlias(String alias) {
    return $TokensTable(attachedDatabase, alias);
  }
}

class Token extends DataClass implements Insertable<Token> {
  final int id;
  final String name;
  final String? issuer;
  final String secret;
  final int interval;
  final int digits;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const Token({
    required this.id,
    required this.name,
    this.issuer,
    required this.secret,
    required this.interval,
    required this.digits,
    this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || issuer != null) {
      map['issuer'] = Variable<String>(issuer);
    }
    map['secret'] = Variable<String>(secret);
    map['interval'] = Variable<int>(interval);
    map['digits'] = Variable<int>(digits);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  TokensCompanion toCompanion(bool nullToAbsent) {
    return TokensCompanion(
      id: Value(id),
      name: Value(name),
      issuer: issuer == null && nullToAbsent
          ? const Value.absent()
          : Value(issuer),
      secret: Value(secret),
      interval: Value(interval),
      digits: Value(digits),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Token.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Token(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      issuer: serializer.fromJson<String?>(json['issuer']),
      secret: serializer.fromJson<String>(json['secret']),
      interval: serializer.fromJson<int>(json['interval']),
      digits: serializer.fromJson<int>(json['digits']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'issuer': serializer.toJson<String?>(issuer),
      'secret': serializer.toJson<String>(secret),
      'interval': serializer.toJson<int>(interval),
      'digits': serializer.toJson<int>(digits),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Token copyWith({
    int? id,
    String? name,
    Value<String?> issuer = const Value.absent(),
    String? secret,
    int? interval,
    int? digits,
    Value<DateTime?> createdAt = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Token(
    id: id ?? this.id,
    name: name ?? this.name,
    issuer: issuer.present ? issuer.value : this.issuer,
    secret: secret ?? this.secret,
    interval: interval ?? this.interval,
    digits: digits ?? this.digits,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Token copyWithCompanion(TokensCompanion data) {
    return Token(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      issuer: data.issuer.present ? data.issuer.value : this.issuer,
      secret: data.secret.present ? data.secret.value : this.secret,
      interval: data.interval.present ? data.interval.value : this.interval,
      digits: data.digits.present ? data.digits.value : this.digits,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Token(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('issuer: $issuer, ')
          ..write('secret: $secret, ')
          ..write('interval: $interval, ')
          ..write('digits: $digits, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    issuer,
    secret,
    interval,
    digits,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Token &&
          other.id == this.id &&
          other.name == this.name &&
          other.issuer == this.issuer &&
          other.secret == this.secret &&
          other.interval == this.interval &&
          other.digits == this.digits &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TokensCompanion extends UpdateCompanion<Token> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> issuer;
  final Value<String> secret;
  final Value<int> interval;
  final Value<int> digits;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  const TokensCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.issuer = const Value.absent(),
    this.secret = const Value.absent(),
    this.interval = const Value.absent(),
    this.digits = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TokensCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.issuer = const Value.absent(),
    required String secret,
    required int interval,
    required int digits,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       secret = Value(secret),
       interval = Value(interval),
       digits = Value(digits);
  static Insertable<Token> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? issuer,
    Expression<String>? secret,
    Expression<int>? interval,
    Expression<int>? digits,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (issuer != null) 'issuer': issuer,
      if (secret != null) 'secret': secret,
      if (interval != null) 'interval': interval,
      if (digits != null) 'digits': digits,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TokensCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? issuer,
    Value<String>? secret,
    Value<int>? interval,
    Value<int>? digits,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return TokensCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      issuer: issuer ?? this.issuer,
      secret: secret ?? this.secret,
      interval: interval ?? this.interval,
      digits: digits ?? this.digits,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (issuer.present) {
      map['issuer'] = Variable<String>(issuer.value);
    }
    if (secret.present) {
      map['secret'] = Variable<String>(secret.value);
    }
    if (interval.present) {
      map['interval'] = Variable<int>(interval.value);
    }
    if (digits.present) {
      map['digits'] = Variable<int>(digits.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TokensCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('issuer: $issuer, ')
          ..write('secret: $secret, ')
          ..write('interval: $interval, ')
          ..write('digits: $digits, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TokensTable tokens = $TokensTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tokens];
}

typedef $$TokensTableCreateCompanionBuilder =
    TokensCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> issuer,
      required String secret,
      required int interval,
      required int digits,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$TokensTableUpdateCompanionBuilder =
    TokensCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> issuer,
      Value<String> secret,
      Value<int> interval,
      Value<int> digits,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
    });

class $$TokensTableFilterComposer
    extends Composer<_$AppDatabase, $TokensTable> {
  $$TokensTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get issuer => $composableBuilder(
    column: $table.issuer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get secret => $composableBuilder(
    column: $table.secret,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get interval => $composableBuilder(
    column: $table.interval,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get digits => $composableBuilder(
    column: $table.digits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TokensTableOrderingComposer
    extends Composer<_$AppDatabase, $TokensTable> {
  $$TokensTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get issuer => $composableBuilder(
    column: $table.issuer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get secret => $composableBuilder(
    column: $table.secret,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get interval => $composableBuilder(
    column: $table.interval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get digits => $composableBuilder(
    column: $table.digits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TokensTableAnnotationComposer
    extends Composer<_$AppDatabase, $TokensTable> {
  $$TokensTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get issuer =>
      $composableBuilder(column: $table.issuer, builder: (column) => column);

  GeneratedColumn<String> get secret =>
      $composableBuilder(column: $table.secret, builder: (column) => column);

  GeneratedColumn<int> get interval =>
      $composableBuilder(column: $table.interval, builder: (column) => column);

  GeneratedColumn<int> get digits =>
      $composableBuilder(column: $table.digits, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TokensTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TokensTable,
          Token,
          $$TokensTableFilterComposer,
          $$TokensTableOrderingComposer,
          $$TokensTableAnnotationComposer,
          $$TokensTableCreateCompanionBuilder,
          $$TokensTableUpdateCompanionBuilder,
          (Token, BaseReferences<_$AppDatabase, $TokensTable, Token>),
          Token,
          PrefetchHooks Function()
        > {
  $$TokensTableTableManager(_$AppDatabase db, $TokensTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TokensTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TokensTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TokensTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> issuer = const Value.absent(),
                Value<String> secret = const Value.absent(),
                Value<int> interval = const Value.absent(),
                Value<int> digits = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => TokensCompanion(
                id: id,
                name: name,
                issuer: issuer,
                secret: secret,
                interval: interval,
                digits: digits,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> issuer = const Value.absent(),
                required String secret,
                required int interval,
                required int digits,
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => TokensCompanion.insert(
                id: id,
                name: name,
                issuer: issuer,
                secret: secret,
                interval: interval,
                digits: digits,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TokensTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TokensTable,
      Token,
      $$TokensTableFilterComposer,
      $$TokensTableOrderingComposer,
      $$TokensTableAnnotationComposer,
      $$TokensTableCreateCompanionBuilder,
      $$TokensTableUpdateCompanionBuilder,
      (Token, BaseReferences<_$AppDatabase, $TokensTable, Token>),
      Token,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TokensTableTableManager get tokens =>
      $$TokensTableTableManager(_db, _db.tokens);
}
