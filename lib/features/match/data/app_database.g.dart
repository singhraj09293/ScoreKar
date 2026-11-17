// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MatchesTable extends Matches with TableInfo<$MatchesTable, MatchRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatchesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _teamAMeta = const VerificationMeta('teamA');
  @override
  late final GeneratedColumn<String> teamA = GeneratedColumn<String>(
    'team_a',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamBMeta = const VerificationMeta('teamB');
  @override
  late final GeneratedColumn<String> teamB = GeneratedColumn<String>(
    'team_b',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamAScoreMeta = const VerificationMeta(
    'teamAScore',
  );
  @override
  late final GeneratedColumn<int> teamAScore = GeneratedColumn<int>(
    'team_a_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamAWicketMeta = const VerificationMeta(
    'teamAWicket',
  );
  @override
  late final GeneratedColumn<int> teamAWicket = GeneratedColumn<int>(
    'team_a_wicket',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamBWicketMeta = const VerificationMeta(
    'teamBWicket',
  );
  @override
  late final GeneratedColumn<int> teamBWicket = GeneratedColumn<int>(
    'team_b_wicket',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamBScoreMeta = const VerificationMeta(
    'teamBScore',
  );
  @override
  late final GeneratedColumn<int> teamBScore = GeneratedColumn<int>(
    'team_b_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _winnerMeta = const VerificationMeta('winner');
  @override
  late final GeneratedColumn<String> winner = GeneratedColumn<String>(
    'winner',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _playedAtMeta = const VerificationMeta(
    'playedAt',
  );
  @override
  late final GeneratedColumn<DateTime> playedAt = GeneratedColumn<DateTime>(
    'played_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    teamA,
    teamB,
    teamAScore,
    teamAWicket,
    teamBWicket,
    teamBScore,
    winner,
    playedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'matches';
  @override
  VerificationContext validateIntegrity(
    Insertable<MatchRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('team_a')) {
      context.handle(
        _teamAMeta,
        teamA.isAcceptableOrUnknown(data['team_a']!, _teamAMeta),
      );
    } else if (isInserting) {
      context.missing(_teamAMeta);
    }
    if (data.containsKey('team_b')) {
      context.handle(
        _teamBMeta,
        teamB.isAcceptableOrUnknown(data['team_b']!, _teamBMeta),
      );
    } else if (isInserting) {
      context.missing(_teamBMeta);
    }
    if (data.containsKey('team_a_score')) {
      context.handle(
        _teamAScoreMeta,
        teamAScore.isAcceptableOrUnknown(
          data['team_a_score']!,
          _teamAScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_teamAScoreMeta);
    }
    if (data.containsKey('team_a_wicket')) {
      context.handle(
        _teamAWicketMeta,
        teamAWicket.isAcceptableOrUnknown(
          data['team_a_wicket']!,
          _teamAWicketMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_teamAWicketMeta);
    }
    if (data.containsKey('team_b_wicket')) {
      context.handle(
        _teamBWicketMeta,
        teamBWicket.isAcceptableOrUnknown(
          data['team_b_wicket']!,
          _teamBWicketMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_teamBWicketMeta);
    }
    if (data.containsKey('team_b_score')) {
      context.handle(
        _teamBScoreMeta,
        teamBScore.isAcceptableOrUnknown(
          data['team_b_score']!,
          _teamBScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_teamBScoreMeta);
    }
    if (data.containsKey('winner')) {
      context.handle(
        _winnerMeta,
        winner.isAcceptableOrUnknown(data['winner']!, _winnerMeta),
      );
    } else if (isInserting) {
      context.missing(_winnerMeta);
    }
    if (data.containsKey('played_at')) {
      context.handle(
        _playedAtMeta,
        playedAt.isAcceptableOrUnknown(data['played_at']!, _playedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_playedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MatchRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MatchRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      teamA: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_a'],
      )!,
      teamB: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_b'],
      )!,
      teamAScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_a_score'],
      )!,
      teamAWicket: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_a_wicket'],
      )!,
      teamBWicket: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_b_wicket'],
      )!,
      teamBScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_b_score'],
      )!,
      winner: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}winner'],
      )!,
      playedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}played_at'],
      )!,
    );
  }

  @override
  $MatchesTable createAlias(String alias) {
    return $MatchesTable(attachedDatabase, alias);
  }
}

class MatchRow extends DataClass implements Insertable<MatchRow> {
  final int id;
  final String teamA;
  final String teamB;
  final int teamAScore;
  final int teamAWicket;
  final int teamBWicket;
  final int teamBScore;
  final String winner;
  final DateTime playedAt;
  const MatchRow({
    required this.id,
    required this.teamA,
    required this.teamB,
    required this.teamAScore,
    required this.teamAWicket,
    required this.teamBWicket,
    required this.teamBScore,
    required this.winner,
    required this.playedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['team_a'] = Variable<String>(teamA);
    map['team_b'] = Variable<String>(teamB);
    map['team_a_score'] = Variable<int>(teamAScore);
    map['team_a_wicket'] = Variable<int>(teamAWicket);
    map['team_b_wicket'] = Variable<int>(teamBWicket);
    map['team_b_score'] = Variable<int>(teamBScore);
    map['winner'] = Variable<String>(winner);
    map['played_at'] = Variable<DateTime>(playedAt);
    return map;
  }

  MatchesCompanion toCompanion(bool nullToAbsent) {
    return MatchesCompanion(
      id: Value(id),
      teamA: Value(teamA),
      teamB: Value(teamB),
      teamAScore: Value(teamAScore),
      teamAWicket: Value(teamAWicket),
      teamBWicket: Value(teamBWicket),
      teamBScore: Value(teamBScore),
      winner: Value(winner),
      playedAt: Value(playedAt),
    );
  }

  factory MatchRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MatchRow(
      id: serializer.fromJson<int>(json['id']),
      teamA: serializer.fromJson<String>(json['teamA']),
      teamB: serializer.fromJson<String>(json['teamB']),
      teamAScore: serializer.fromJson<int>(json['teamAScore']),
      teamAWicket: serializer.fromJson<int>(json['teamAWicket']),
      teamBWicket: serializer.fromJson<int>(json['teamBWicket']),
      teamBScore: serializer.fromJson<int>(json['teamBScore']),
      winner: serializer.fromJson<String>(json['winner']),
      playedAt: serializer.fromJson<DateTime>(json['playedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'teamA': serializer.toJson<String>(teamA),
      'teamB': serializer.toJson<String>(teamB),
      'teamAScore': serializer.toJson<int>(teamAScore),
      'teamAWicket': serializer.toJson<int>(teamAWicket),
      'teamBWicket': serializer.toJson<int>(teamBWicket),
      'teamBScore': serializer.toJson<int>(teamBScore),
      'winner': serializer.toJson<String>(winner),
      'playedAt': serializer.toJson<DateTime>(playedAt),
    };
  }

  MatchRow copyWith({
    int? id,
    String? teamA,
    String? teamB,
    int? teamAScore,
    int? teamAWicket,
    int? teamBWicket,
    int? teamBScore,
    String? winner,
    DateTime? playedAt,
  }) => MatchRow(
    id: id ?? this.id,
    teamA: teamA ?? this.teamA,
    teamB: teamB ?? this.teamB,
    teamAScore: teamAScore ?? this.teamAScore,
    teamAWicket: teamAWicket ?? this.teamAWicket,
    teamBWicket: teamBWicket ?? this.teamBWicket,
    teamBScore: teamBScore ?? this.teamBScore,
    winner: winner ?? this.winner,
    playedAt: playedAt ?? this.playedAt,
  );
  MatchRow copyWithCompanion(MatchesCompanion data) {
    return MatchRow(
      id: data.id.present ? data.id.value : this.id,
      teamA: data.teamA.present ? data.teamA.value : this.teamA,
      teamB: data.teamB.present ? data.teamB.value : this.teamB,
      teamAScore: data.teamAScore.present
          ? data.teamAScore.value
          : this.teamAScore,
      teamAWicket: data.teamAWicket.present
          ? data.teamAWicket.value
          : this.teamAWicket,
      teamBWicket: data.teamBWicket.present
          ? data.teamBWicket.value
          : this.teamBWicket,
      teamBScore: data.teamBScore.present
          ? data.teamBScore.value
          : this.teamBScore,
      winner: data.winner.present ? data.winner.value : this.winner,
      playedAt: data.playedAt.present ? data.playedAt.value : this.playedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MatchRow(')
          ..write('id: $id, ')
          ..write('teamA: $teamA, ')
          ..write('teamB: $teamB, ')
          ..write('teamAScore: $teamAScore, ')
          ..write('teamAWicket: $teamAWicket, ')
          ..write('teamBWicket: $teamBWicket, ')
          ..write('teamBScore: $teamBScore, ')
          ..write('winner: $winner, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    teamA,
    teamB,
    teamAScore,
    teamAWicket,
    teamBWicket,
    teamBScore,
    winner,
    playedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchRow &&
          other.id == this.id &&
          other.teamA == this.teamA &&
          other.teamB == this.teamB &&
          other.teamAScore == this.teamAScore &&
          other.teamAWicket == this.teamAWicket &&
          other.teamBWicket == this.teamBWicket &&
          other.teamBScore == this.teamBScore &&
          other.winner == this.winner &&
          other.playedAt == this.playedAt);
}

class MatchesCompanion extends UpdateCompanion<MatchRow> {
  final Value<int> id;
  final Value<String> teamA;
  final Value<String> teamB;
  final Value<int> teamAScore;
  final Value<int> teamAWicket;
  final Value<int> teamBWicket;
  final Value<int> teamBScore;
  final Value<String> winner;
  final Value<DateTime> playedAt;
  const MatchesCompanion({
    this.id = const Value.absent(),
    this.teamA = const Value.absent(),
    this.teamB = const Value.absent(),
    this.teamAScore = const Value.absent(),
    this.teamAWicket = const Value.absent(),
    this.teamBWicket = const Value.absent(),
    this.teamBScore = const Value.absent(),
    this.winner = const Value.absent(),
    this.playedAt = const Value.absent(),
  });
  MatchesCompanion.insert({
    this.id = const Value.absent(),
    required String teamA,
    required String teamB,
    required int teamAScore,
    required int teamAWicket,
    required int teamBWicket,
    required int teamBScore,
    required String winner,
    required DateTime playedAt,
  }) : teamA = Value(teamA),
       teamB = Value(teamB),
       teamAScore = Value(teamAScore),
       teamAWicket = Value(teamAWicket),
       teamBWicket = Value(teamBWicket),
       teamBScore = Value(teamBScore),
       winner = Value(winner),
       playedAt = Value(playedAt);
  static Insertable<MatchRow> custom({
    Expression<int>? id,
    Expression<String>? teamA,
    Expression<String>? teamB,
    Expression<int>? teamAScore,
    Expression<int>? teamAWicket,
    Expression<int>? teamBWicket,
    Expression<int>? teamBScore,
    Expression<String>? winner,
    Expression<DateTime>? playedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (teamA != null) 'team_a': teamA,
      if (teamB != null) 'team_b': teamB,
      if (teamAScore != null) 'team_a_score': teamAScore,
      if (teamAWicket != null) 'team_a_wicket': teamAWicket,
      if (teamBWicket != null) 'team_b_wicket': teamBWicket,
      if (teamBScore != null) 'team_b_score': teamBScore,
      if (winner != null) 'winner': winner,
      if (playedAt != null) 'played_at': playedAt,
    });
  }

  MatchesCompanion copyWith({
    Value<int>? id,
    Value<String>? teamA,
    Value<String>? teamB,
    Value<int>? teamAScore,
    Value<int>? teamAWicket,
    Value<int>? teamBWicket,
    Value<int>? teamBScore,
    Value<String>? winner,
    Value<DateTime>? playedAt,
  }) {
    return MatchesCompanion(
      id: id ?? this.id,
      teamA: teamA ?? this.teamA,
      teamB: teamB ?? this.teamB,
      teamAScore: teamAScore ?? this.teamAScore,
      teamAWicket: teamAWicket ?? this.teamAWicket,
      teamBWicket: teamBWicket ?? this.teamBWicket,
      teamBScore: teamBScore ?? this.teamBScore,
      winner: winner ?? this.winner,
      playedAt: playedAt ?? this.playedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (teamA.present) {
      map['team_a'] = Variable<String>(teamA.value);
    }
    if (teamB.present) {
      map['team_b'] = Variable<String>(teamB.value);
    }
    if (teamAScore.present) {
      map['team_a_score'] = Variable<int>(teamAScore.value);
    }
    if (teamAWicket.present) {
      map['team_a_wicket'] = Variable<int>(teamAWicket.value);
    }
    if (teamBWicket.present) {
      map['team_b_wicket'] = Variable<int>(teamBWicket.value);
    }
    if (teamBScore.present) {
      map['team_b_score'] = Variable<int>(teamBScore.value);
    }
    if (winner.present) {
      map['winner'] = Variable<String>(winner.value);
    }
    if (playedAt.present) {
      map['played_at'] = Variable<DateTime>(playedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatchesCompanion(')
          ..write('id: $id, ')
          ..write('teamA: $teamA, ')
          ..write('teamB: $teamB, ')
          ..write('teamAScore: $teamAScore, ')
          ..write('teamAWicket: $teamAWicket, ')
          ..write('teamBWicket: $teamBWicket, ')
          ..write('teamBScore: $teamBScore, ')
          ..write('winner: $winner, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MatchesTable matches = $MatchesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [matches];
}

typedef $$MatchesTableCreateCompanionBuilder =
    MatchesCompanion Function({
      Value<int> id,
      required String teamA,
      required String teamB,
      required int teamAScore,
      required int teamAWicket,
      required int teamBWicket,
      required int teamBScore,
      required String winner,
      required DateTime playedAt,
    });
typedef $$MatchesTableUpdateCompanionBuilder =
    MatchesCompanion Function({
      Value<int> id,
      Value<String> teamA,
      Value<String> teamB,
      Value<int> teamAScore,
      Value<int> teamAWicket,
      Value<int> teamBWicket,
      Value<int> teamBScore,
      Value<String> winner,
      Value<DateTime> playedAt,
    });

class $$MatchesTableFilterComposer
    extends Composer<_$AppDatabase, $MatchesTable> {
  $$MatchesTableFilterComposer({
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

  ColumnFilters<String> get teamA => $composableBuilder(
    column: $table.teamA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamB => $composableBuilder(
    column: $table.teamB,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get teamAScore => $composableBuilder(
    column: $table.teamAScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get teamAWicket => $composableBuilder(
    column: $table.teamAWicket,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get teamBWicket => $composableBuilder(
    column: $table.teamBWicket,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get teamBScore => $composableBuilder(
    column: $table.teamBScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get winner => $composableBuilder(
    column: $table.winner,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MatchesTableOrderingComposer
    extends Composer<_$AppDatabase, $MatchesTable> {
  $$MatchesTableOrderingComposer({
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

  ColumnOrderings<String> get teamA => $composableBuilder(
    column: $table.teamA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamB => $composableBuilder(
    column: $table.teamB,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get teamAScore => $composableBuilder(
    column: $table.teamAScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get teamAWicket => $composableBuilder(
    column: $table.teamAWicket,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get teamBWicket => $composableBuilder(
    column: $table.teamBWicket,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get teamBScore => $composableBuilder(
    column: $table.teamBScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get winner => $composableBuilder(
    column: $table.winner,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MatchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MatchesTable> {
  $$MatchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get teamA =>
      $composableBuilder(column: $table.teamA, builder: (column) => column);

  GeneratedColumn<String> get teamB =>
      $composableBuilder(column: $table.teamB, builder: (column) => column);

  GeneratedColumn<int> get teamAScore => $composableBuilder(
    column: $table.teamAScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get teamAWicket => $composableBuilder(
    column: $table.teamAWicket,
    builder: (column) => column,
  );

  GeneratedColumn<int> get teamBWicket => $composableBuilder(
    column: $table.teamBWicket,
    builder: (column) => column,
  );

  GeneratedColumn<int> get teamBScore => $composableBuilder(
    column: $table.teamBScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get winner =>
      $composableBuilder(column: $table.winner, builder: (column) => column);

  GeneratedColumn<DateTime> get playedAt =>
      $composableBuilder(column: $table.playedAt, builder: (column) => column);
}

class $$MatchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MatchesTable,
          MatchRow,
          $$MatchesTableFilterComposer,
          $$MatchesTableOrderingComposer,
          $$MatchesTableAnnotationComposer,
          $$MatchesTableCreateCompanionBuilder,
          $$MatchesTableUpdateCompanionBuilder,
          (MatchRow, BaseReferences<_$AppDatabase, $MatchesTable, MatchRow>),
          MatchRow,
          PrefetchHooks Function()
        > {
  $$MatchesTableTableManager(_$AppDatabase db, $MatchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MatchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MatchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MatchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> teamA = const Value.absent(),
                Value<String> teamB = const Value.absent(),
                Value<int> teamAScore = const Value.absent(),
                Value<int> teamAWicket = const Value.absent(),
                Value<int> teamBWicket = const Value.absent(),
                Value<int> teamBScore = const Value.absent(),
                Value<String> winner = const Value.absent(),
                Value<DateTime> playedAt = const Value.absent(),
              }) => MatchesCompanion(
                id: id,
                teamA: teamA,
                teamB: teamB,
                teamAScore: teamAScore,
                teamAWicket: teamAWicket,
                teamBWicket: teamBWicket,
                teamBScore: teamBScore,
                winner: winner,
                playedAt: playedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String teamA,
                required String teamB,
                required int teamAScore,
                required int teamAWicket,
                required int teamBWicket,
                required int teamBScore,
                required String winner,
                required DateTime playedAt,
              }) => MatchesCompanion.insert(
                id: id,
                teamA: teamA,
                teamB: teamB,
                teamAScore: teamAScore,
                teamAWicket: teamAWicket,
                teamBWicket: teamBWicket,
                teamBScore: teamBScore,
                winner: winner,
                playedAt: playedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MatchesTable, MatchRow>(table),
                  BaseReferences<_$AppDatabase, $MatchesTable, MatchRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MatchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MatchesTable,
      MatchRow,
      $$MatchesTableFilterComposer,
      $$MatchesTableOrderingComposer,
      $$MatchesTableAnnotationComposer,
      $$MatchesTableCreateCompanionBuilder,
      $$MatchesTableUpdateCompanionBuilder,
      (MatchRow, BaseReferences<_$AppDatabase, $MatchesTable, MatchRow>),
      MatchRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MatchesTableTableManager get matches =>
      $$MatchesTableTableManager(_db, _db.matches);
}
