// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MoodEntriesTable extends MoodEntries
    with TableInfo<$MoodEntriesTable, MoodEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MoodEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _moodLevelMeta =
      const VerificationMeta('moodLevel');
  @override
  late final GeneratedColumn<int> moodLevel = GeneratedColumn<int>(
      'mood_level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns => [id, date, moodLevel, note, tags];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mood_entries';
  @override
  VerificationContext validateIntegrity(Insertable<MoodEntryRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('mood_level')) {
      context.handle(_moodLevelMeta,
          moodLevel.isAcceptableOrUnknown(data['mood_level']!, _moodLevelMeta));
    } else if (isInserting) {
      context.missing(_moodLevelMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MoodEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MoodEntryRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      moodLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mood_level'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])!,
    );
  }

  @override
  $MoodEntriesTable createAlias(String alias) {
    return $MoodEntriesTable(attachedDatabase, alias);
  }
}

class MoodEntryRow extends DataClass implements Insertable<MoodEntryRow> {
  /// Уникальный идентификатор (строковый, генерируем сами через uuid).
  final String id;

  /// Дата записи (без времени — только год, месяц, день).
  final DateTime date;

  /// Уровень настроения от 1 (плохо) до 5 (отлично).
  final int moodLevel;

  /// Опциональная заметка.
  final String? note;

  /// Теги/факторы, хранятся как CSV-строка.
  final String tags;
  const MoodEntryRow(
      {required this.id,
      required this.date,
      required this.moodLevel,
      this.note,
      required this.tags});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['mood_level'] = Variable<int>(moodLevel);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['tags'] = Variable<String>(tags);
    return map;
  }

  MoodEntriesCompanion toCompanion(bool nullToAbsent) {
    return MoodEntriesCompanion(
      id: Value(id),
      date: Value(date),
      moodLevel: Value(moodLevel),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      tags: Value(tags),
    );
  }

  factory MoodEntryRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MoodEntryRow(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      moodLevel: serializer.fromJson<int>(json['moodLevel']),
      note: serializer.fromJson<String?>(json['note']),
      tags: serializer.fromJson<String>(json['tags']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'moodLevel': serializer.toJson<int>(moodLevel),
      'note': serializer.toJson<String?>(note),
      'tags': serializer.toJson<String>(tags),
    };
  }

  MoodEntryRow copyWith(
          {String? id,
          DateTime? date,
          int? moodLevel,
          Value<String?> note = const Value.absent(),
          String? tags}) =>
      MoodEntryRow(
        id: id ?? this.id,
        date: date ?? this.date,
        moodLevel: moodLevel ?? this.moodLevel,
        note: note.present ? note.value : this.note,
        tags: tags ?? this.tags,
      );
  MoodEntryRow copyWithCompanion(MoodEntriesCompanion data) {
    return MoodEntryRow(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      moodLevel: data.moodLevel.present ? data.moodLevel.value : this.moodLevel,
      note: data.note.present ? data.note.value : this.note,
      tags: data.tags.present ? data.tags.value : this.tags,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MoodEntryRow(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('moodLevel: $moodLevel, ')
          ..write('note: $note, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, moodLevel, note, tags);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MoodEntryRow &&
          other.id == this.id &&
          other.date == this.date &&
          other.moodLevel == this.moodLevel &&
          other.note == this.note &&
          other.tags == this.tags);
}

class MoodEntriesCompanion extends UpdateCompanion<MoodEntryRow> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<int> moodLevel;
  final Value<String?> note;
  final Value<String> tags;
  final Value<int> rowid;
  const MoodEntriesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.moodLevel = const Value.absent(),
    this.note = const Value.absent(),
    this.tags = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MoodEntriesCompanion.insert({
    required String id,
    required DateTime date,
    required int moodLevel,
    this.note = const Value.absent(),
    this.tags = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date),
        moodLevel = Value(moodLevel);
  static Insertable<MoodEntryRow> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<int>? moodLevel,
    Expression<String>? note,
    Expression<String>? tags,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (moodLevel != null) 'mood_level': moodLevel,
      if (note != null) 'note': note,
      if (tags != null) 'tags': tags,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MoodEntriesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? date,
      Value<int>? moodLevel,
      Value<String?>? note,
      Value<String>? tags,
      Value<int>? rowid}) {
    return MoodEntriesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      moodLevel: moodLevel ?? this.moodLevel,
      note: note ?? this.note,
      tags: tags ?? this.tags,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (moodLevel.present) {
      map['mood_level'] = Variable<int>(moodLevel.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MoodEntriesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('moodLevel: $moodLevel, ')
          ..write('note: $note, ')
          ..write('tags: $tags, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MoodEntriesTable moodEntries = $MoodEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [moodEntries];
}

typedef $$MoodEntriesTableCreateCompanionBuilder = MoodEntriesCompanion
    Function({
  required String id,
  required DateTime date,
  required int moodLevel,
  Value<String?> note,
  Value<String> tags,
  Value<int> rowid,
});
typedef $$MoodEntriesTableUpdateCompanionBuilder = MoodEntriesCompanion
    Function({
  Value<String> id,
  Value<DateTime> date,
  Value<int> moodLevel,
  Value<String?> note,
  Value<String> tags,
  Value<int> rowid,
});

class $$MoodEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $MoodEntriesTable> {
  $$MoodEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get moodLevel => $composableBuilder(
      column: $table.moodLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));
}

class $$MoodEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $MoodEntriesTable> {
  $$MoodEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get moodLevel => $composableBuilder(
      column: $table.moodLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));
}

class $$MoodEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MoodEntriesTable> {
  $$MoodEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get moodLevel =>
      $composableBuilder(column: $table.moodLevel, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);
}

class $$MoodEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MoodEntriesTable,
    MoodEntryRow,
    $$MoodEntriesTableFilterComposer,
    $$MoodEntriesTableOrderingComposer,
    $$MoodEntriesTableAnnotationComposer,
    $$MoodEntriesTableCreateCompanionBuilder,
    $$MoodEntriesTableUpdateCompanionBuilder,
    (
      MoodEntryRow,
      BaseReferences<_$AppDatabase, $MoodEntriesTable, MoodEntryRow>
    ),
    MoodEntryRow,
    PrefetchHooks Function()> {
  $$MoodEntriesTableTableManager(_$AppDatabase db, $MoodEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MoodEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MoodEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MoodEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> moodLevel = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MoodEntriesCompanion(
            id: id,
            date: date,
            moodLevel: moodLevel,
            note: note,
            tags: tags,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required DateTime date,
            required int moodLevel,
            Value<String?> note = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MoodEntriesCompanion.insert(
            id: id,
            date: date,
            moodLevel: moodLevel,
            note: note,
            tags: tags,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$MoodEntriesTable, MoodEntryRow>(table),
                    BaseReferences<_$AppDatabase, $MoodEntriesTable,
                        MoodEntryRow>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MoodEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MoodEntriesTable,
    MoodEntryRow,
    $$MoodEntriesTableFilterComposer,
    $$MoodEntriesTableOrderingComposer,
    $$MoodEntriesTableAnnotationComposer,
    $$MoodEntriesTableCreateCompanionBuilder,
    $$MoodEntriesTableUpdateCompanionBuilder,
    (
      MoodEntryRow,
      BaseReferences<_$AppDatabase, $MoodEntriesTable, MoodEntryRow>
    ),
    MoodEntryRow,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MoodEntriesTableTableManager get moodEntries =>
      $$MoodEntriesTableTableManager(_db, _db.moodEntries);
}
