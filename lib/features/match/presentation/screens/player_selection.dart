import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorekar/features/match/presentation/provider/match_controller.dart';
import 'package:scorekar/features/match/presentation/screens/score_page.dart';
import 'package:scorekar/theme/app_colors.dart';

class PlayerSelection extends ConsumerStatefulWidget {
  const PlayerSelection({super.key});

  @override
  ConsumerState<PlayerSelection> createState() => _PlayerSelectionState();
}

class _PlayerSelectionState extends ConsumerState<PlayerSelection> {
  List<String> teamAPlayers = [];
  List<String> teamBPlayers = [];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final teamA = ref.read(matchinfoProvider).teamA;
    final teamB = ref.read(matchinfoProvider).teamB;
    final ready = teamAPlayers.length >= 2 && teamBPlayers.length >= 2;

    return Scaffold(
      appBar: AppBar(title: Text('Players')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: selectedIndex == 0
                            ? AppColors.accent
                            : AppColors.card,
                      ),
                      child: Text(teamA, style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: selectedIndex == 1
                            ? AppColors.accent
                            : AppColors.card,
                      ),
                      child: Text(teamB, style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Batting Order (Drag to reorder)',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SquadEditor(
                key: ValueKey(selectedIndex),
                players: selectedIndex == 0 ? teamAPlayers : teamBPlayers,
                onChanged: () => setState(() {}),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ready ? AppColors.accent : Colors.grey,
                minimumSize: Size(450, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
              ),
              onPressed: () {
                if (ready) {
                  ref
                      .read(matchinfoProvider.notifier)
                      .setPlayer(teamAPlayers, teamBPlayers);
                  ref.read(matchProvider.notifier).startMatch();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ScorePage(a: teamA, b: teamB),
                    ),
                  );
                }
              },
              child: Text(
                'Continue',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SquadEditor extends StatefulWidget {
  final List<String> players;
  final VoidCallback onChanged;

  const SquadEditor({
    super.key,
    required this.players,
    required this.onChanged,
  });

  @override
  State<SquadEditor> createState() => _SquadEditorState();
}

class _SquadEditorState extends State<SquadEditor> {
  final controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _addPlayer() {
    final name = controller.text.trim();
    if (name.isEmpty) return;

    // Block duplicates inside this team (ignore capital letters)
    final exists = widget.players.any(
      (p) => p.toLowerCase() == name.toLowerCase(),
    );
    if (exists) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$name is already added')));
      return;
    }

    setState(() => widget.players.add(name));
    widget.onChanged();
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(15),
            ),
            child: widget.players.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        'Add your first player',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                : ReorderableListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    // Flutter gives newIndex BEFORE the dragged item is removed,
                    // so when dragging down we subtract 1.
                    onReorderItem: (oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) newIndex -= 1;
                        final name = widget.players.removeAt(oldIndex);
                        widget.players.insert(newIndex, name);
                      });
                      widget.onChanged();
                    },
                    children: [
                      for (int i = 0; i < widget.players.length; i++)
                        Dismissible(
                          key: ValueKey(widget.players[i]),
                          direction: DismissDirection.startToEnd,
                          background: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 16),
                            color: Colors.red,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (_) {
                            setState(() => widget.players.removeAt(i));
                            widget.onChanged();
                          },
                          child: ListTile(
                            leading: Text(
                              '${i + 1}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            title: Text(widget.players[i]),
                          ),
                        ),
                    ],
                  ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            onSubmitted: (_) => _addPlayer(),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.card,
              hintText: 'Add player',
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.all(20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                onPressed: _addPlayer,
                icon: const CircleAvatar(
                  child: Icon(Icons.add, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
