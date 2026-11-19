import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:scorekar/features/match/data/match_mapper.dart';
import 'package:scorekar/features/match/domain/ball.dart';
import 'package:scorekar/features/match/domain/cricket_match.dart';
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
  TextColumn get teamAPlayer => text()();
  TextColumn get teamBPlayer => text()();
  IntColumn get overs => integer()();
  IntColumn get tossWinner => integer()();
  TextColumn get tossChoice => text()();
}

@DataClassName('BallRow')
class BallRows extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get matchId => integer()();
  IntColumn get innings => integer()();
  IntColumn get orderNo => integer()();
  IntColumn get runs => integer()();
  TextColumn get type => text()();
}

@DriftDatabase(tables: [Matches, BallRows])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'scorekar'));
  @override
  int get schemaVersion => 1;

  Future<List<MatchRow>> getAllMatches() async {
    return await (select(
      matches,
    )..orderBy([(t) => OrderingTerm.desc(t.playedAt)])).get();
  }

  Future<List<BallRow>> getBalls(int matchId, int inning) async {
    return await (select(ballRows)
          ..where((t) => t.matchId.equals(matchId) & t.innings.equals(inning))
          ..orderBy([(t) => OrderingTerm.desc(t.orderNo)]))
        .get();
  }

  Future<void> saveMatch(CricketMatch match) async {
    final aFirst = match.info.battingFirst == 0;
    final aScore = aFirst
        ? match.innings1.totalRuns
        : match.innings2!.totalRuns;
    final bScore = aFirst
        ? match.innings2!.totalRuns
        : match.innings1.totalRuns;
    final aWicket = aFirst ? match.innings1.wickets : match.innings2!.wickets;
    final bWicket = aFirst ? match.innings2!.wickets : match.innings1.wickets;
    final id = await into(matches).insert(
      MatchesCompanion.insert(
        teamA: match.info.teamA,
        teamB: match.info.teamB,
        teamAScore: aScore,
        teamAWicket: aWicket,
        teamBWicket: bWicket,
        teamBScore: bScore,
        winner: match.winnerName ?? 'Tie',
        playedAt: DateTime.now(),
        teamAPlayer: match.info.teamAPlayers.join(','),
        teamBPlayer: match.info.teamBPlayers.join(','),
        overs: match.info.overs,
        tossWinner: match.info.tossWinner,
        tossChoice: match.info.tossChoice.name,
      ),
    );
    await _saveBalls(id, 1, match.innings1.balls);
    await _saveBalls(id, 2, match.innings2!.balls);
  }

  Future<void> _saveBalls(int matchId, int innings, List<Ball> balls) async {
    for (int i = 0; i < balls.length; i++) {
      await into(ballRows).insert(
        BallRowsCompanion.insert(
          matchId: matchId,
          innings: innings,
          orderNo: i,
          runs: balls[i].run,
          type: balls[i].type.name,
        ),
      );
    }
  }

  Future<MatchRow> getMatch(int id) async {
    return await (select(matches)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<CricketMatch> loadMatch(int id) async {
    final row = await getMatch(id);
    final info = infoFromRow(row);
    final row1 = await getBalls(id, 1);
    final row2 = await getBalls(id, 2);
    final first = info.battingFirst == 0
        ? info.teamAPlayers.length
        : info.teamBPlayers.length;
    final second = info.battingFirst == 0
        ? info.teamBPlayers.length
        : info.teamAPlayers.length;
    final state1 = stateFromRows(row1, row.overs, first);
    final state2 = stateFromRows(row2, row.overs, second);
    return CricketMatch(info: info, innings1: state1, innings2: state2);
  }
}
