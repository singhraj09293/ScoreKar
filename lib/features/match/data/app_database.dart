import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
part 'app_database.g.dart';

@DataClassName('MatchRow')
class Matches extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get teamA => text()();
  TextColumn get teamB => text()();
  IntColumn get teamAScore => integer()();
  IntColumn get teamAWicket => integer()();
  IntColumn get teamBWicket => integer()();
  IntColumn get teamBScore => integer()();
  TextColumn get winner => text()();
  DateTimeColumn get playedAt => dateTime()();
}

@DriftDatabase(tables: [Matches])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'scorekar'));
  @override
  int get schemaVersion => 1;

  Future<void> insertMatch({
    required String teamA,
    required String teamB,
    required int teamAScore,
    required int teamBScore,
    required int teamAWicket,
    required String winner,
    required int teamBWicket,
  }) async {
    await into(matches).insert(
      MatchesCompanion.insert(
        teamA: teamA,
        teamB: teamB,
        teamAScore: teamAScore,
        teamAWicket: teamAWicket,
        teamBWicket: teamBWicket,
        teamBScore: teamBScore,
        winner: winner,
        playedAt: DateTime.now(),
      ),
    );
  }

  Future<List<MatchRow>> getAllMatches() async {
    return await select(matches).get();
  }
}
