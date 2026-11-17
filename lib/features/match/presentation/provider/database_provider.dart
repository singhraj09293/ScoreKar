import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorekar/features/match/data/app_database.dart';

final dbProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final historyProvider = FutureProvider.autoDispose<List<MatchRow>>((ref) {
  return ref.read(dbProvider).getAllMatches();
});
