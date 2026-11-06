import 'package:flutter/material.dart';
import 'package:scorekar/features/match/presentation/score_page.dart';
import 'package:scorekar/features/match/presentation/toss_page.dart';
import 'package:scorekar/theme/app_colors.dart';

class NewMatch extends StatefulWidget {
  const NewMatch({super.key});

  @override
  State<NewMatch> createState() => _NewMatchState();
}

class _NewMatchState extends State<NewMatch> {
  int selectedOvers = 5;
  final teamA = TextEditingController();
  final teamB = TextEditingController();
  Future<void> pickCustomOvers() async {
    final controller = TextEditingController();
    final result = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Custom Over'),
        content: TextField(
          decoration: InputDecoration(hintText: 'e.g 7'),
          controller: controller,
          keyboardType: TextInputType.number,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, int.tryParse(controller.text)),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    if (!mounted) return;
    if (result != null && result > 0 && result < 50) {
      return setState(() {
        selectedOvers = result;
      });
    }
  }

  @override
  void dispose() {
    teamA.dispose();
    teamB.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCustom = ![5, 10, 20].contains(selectedOvers);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Match',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'HOME TEAM',
              style: TextStyle(color: Color(0xff918A80), fontSize: 13),
            ),
            SizedBox(height: 5),
            TextField(
              controller: teamA,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.card,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Team A',
                hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'AWAY TEAM',
              style: TextStyle(color: Color(0xff918A80), fontSize: 13),
            ),
            SizedBox(height: 5),
            TextField(
              controller: teamB,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.card,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Team B',
                hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'OVERS',
              style: TextStyle(color: Color(0xff918A80), fontSize: 13),
            ),
            SizedBox(height: 5),
            Row(
              spacing: 8,
              children: [
                ...[5, 10, 20].map(
                  (n) => _chip('$n', selectedOvers == n, () {
                    setState(() {
                      selectedOvers = n;
                    });
                  }),
                ),
                _chip(
                  isCustom ? '$selectedOvers' : 'Custom',
                  isCustom,
                  pickCustomOvers,
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  minimumSize: Size(450, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => TossPage()),
                  );
                },
                child: Text(
                  'Start Match',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _chip(String label, bool selected, VoidCallback onTap) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : AppColors.card,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(label),
      ),
    ),
  );
}
