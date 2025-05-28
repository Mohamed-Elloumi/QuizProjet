import 'package:flutter/material.dart';
import 'package:my_library/models/categorie.dart';
import 'package:my_library/screens/quiz_cong.dart';

class QuizzScreen extends StatefulWidget {
  final Categorie categories;

  const QuizzScreen({Key? key, required this.categories}) : super(key: key);

  @override
  State<QuizzScreen> createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {
  String selectedDifficulty = "easy";
  bool hasTimer = true;
  bool soundEffects = true;
  bool backgroundMusic = true;

  final List<Map<String, String>> difficultyLevels = [
    {"value": "easy", "label": "Facile"},
    {"value": "medium", "label": "Moyen"},
    {"value": "hard", "label": "Difficile"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Quiz Settings"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Paramètres",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2193b0)),
                  ),
                  const SizedBox(height: 25),

                  // 🧠 Niveaux de difficulté modernes (ChoiceChips)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Difficulté", style: TextStyle(fontSize: 18, color: Colors.grey[800])),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: difficultyLevels.map((level) {
                      return ChoiceChip(
                        label: Text(level["label"]!),
                        selected: selectedDifficulty == level["value"],
                        onSelected: (bool selected) {
                          setState(() {
                            selectedDifficulty = level["value"]!;
                          });
                        },
                        selectedColor: const Color(0xFF2193b0),
                        backgroundColor: Colors.grey[200],
                        labelStyle: TextStyle(
                          color: selectedDifficulty == level["value"] ? Colors.white : Colors.black,
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  buildSwitchRow(
                    icon: Icons.hourglass_bottom,
                    label: "Minuterie",
                    value: hasTimer,
                    onChanged: (value) => setState(() => hasTimer = value),
                  ),
                  buildSwitchRow(
                    icon: Icons.graphic_eq,
                    label: "Effets sonores",
                    value: soundEffects,
                    onChanged: (value) => setState(() => soundEffects = value),
                  ),
                  buildSwitchRow(
                    icon: Icons.library_music,
                    label: "Musique de fond",
                    value: backgroundMusic,
                    onChanged: (value) => setState(() => backgroundMusic = value),
                  ),

                  const SizedBox(height: 30),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2193b0),
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 6,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizConf(
                            hasTimer: hasTimer,
                            difficulty: selectedDifficulty,
                            backgroundMusic: backgroundMusic,
                            soundEffects: soundEffects,
                          ),
                        ),
                      );
                    },
                    child: const Text("Commencer", style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSwitchRow({
    required IconData icon,
    required String label,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, size: 28, color: const Color(0xFF2193b0)),
          const SizedBox(width: 15),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 18))),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF2193b0),
            inactiveTrackColor: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
