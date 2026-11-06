import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorekar/features/match/presentation/match_controller.dart';
import 'package:scorekar/theme/app_colors.dart';

class PlayerSelection extends ConsumerStatefulWidget {
  const PlayerSelection({super.key});

  @override
  ConsumerState<PlayerSelection> createState() => _PlayerSelectionState();
}

class _PlayerSelectionState extends ConsumerState<PlayerSelection> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
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
                      child: Text(
                        ref.read(matchinfoProvider).teamA,
                        style: TextStyle(fontSize: 18),
                      ),
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
                      child: Text(
                        ref.read(matchinfoProvider).teamB,
                        style: TextStyle(fontSize: 18),
                      ),
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
            Expanded(child: selectedIndex == 0 ? TeamA() : TeamB()),
          ],
        ),
      ),
    );
  }
}

class TeamA extends StatefulWidget {
  const TeamA({super.key});

  @override
  State<TeamA> createState() => _TeamAState();
}

class _TeamAState extends State<TeamA> {
  List<String> players = [];
  final name = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ReorderableListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            onReorderItem: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex -= 1;
                final name = players.removeAt(oldIndex);
                players.insert(newIndex, name);
              });
            },
            children: [
              for (int i = 0; i < players.length; i++)
                Dismissible(
                  key: Key(players[i]),
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(right: 16),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) => players.removeAt(i),
                  child: ListTile(
                    key: ValueKey(players[i]),
                    title: Text(players[i]),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: name,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.card,
            hintText: 'Add player',
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.all(20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                if (name.text.trim().isEmpty) return;
                setState(() {
                  players.add(name.text.trim());
                });
                name.clear();
              },
              icon: CircleAvatar(child: Icon(Icons.add, color: Colors.black)),
            ),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(height: 5),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: players.length > 4
                ? AppColors.accent
                : Colors.grey,
            minimumSize: Size(450, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12),
            ),
          ),
          onPressed: () {},
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
    );
  }
}

class TeamB extends StatefulWidget {
  const TeamB({super.key});

  @override
  State<TeamB> createState() => _TeamBState();
}

class _TeamBState extends State<TeamB> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
