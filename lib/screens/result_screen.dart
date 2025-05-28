import 'package:flutter/material.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const ResultScreen({Key? key, required this.score, required this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          // ✅ Fond avec dégradé personnalisé (avec tes couleurs)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF6dd5ed),
                  Color(0xFF2193b0),
                ],
              ),
            ),
          ),

          // ✅ Carte centrale semi-transparente
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, 6),
                  ),
                ],
                border: Border.all(color: Colors.white.withOpacity(0.7)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 🎉 Icône animée ou stylisée
                  Icon(
                    Icons.workspace_premium_rounded,
                    size: 80,
                    color: Color(0xFF2193b0),
                  ),
                  const SizedBox(height: 15),

                  // ✅ Titre principal
                  Text(
                    "Félicitations !",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2193b0),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // ✅ Message secondaire
                  Text(
                    "Tu as réussi $score sur $total questions.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // ✅ Score final en grand avec effet léger
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF6dd5ed).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "$score / $total",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2193b0),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // ✅ Bouton avec la même palette
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2193b0),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      animationDuration: const Duration(milliseconds: 200),
                      shadowColor: Color(0xFF6dd5ed).withOpacity(0.5),
                    ),
                    child: const Text("Rejouer"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}