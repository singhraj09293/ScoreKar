import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorekar/features/match/data/app_database.dart';
import 'package:scorekar/features/match/domain/cricket_match.dart';

final dbProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final historyProvider = FutureProvider.autoDispose<List<MatchRow>>((ref) {
  return ref.read(dbProvider).getAllMatches();
});
final detailProvider = FutureProvider.autoDispose.family<MatchRow, int>((
  ref,
  id,
) {
  return ref.read(dbProvider).getMatch(id);
});
final matchDetailProvider = FutureProvider.autoDispose
    .family<CricketMatch, int>((ref, id) {
      return ref.read(dbProvider).loadMatch(id);
    });
