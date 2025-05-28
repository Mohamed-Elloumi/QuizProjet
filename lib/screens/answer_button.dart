import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final bool isCorrect;
  final bool isAnswered;
  final VoidCallback onTap;

  const AnswerButton({
    Key? key,
    required this.answer,
    required this.isSelected,
    required this.isCorrect,
    required this.isAnswered,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.blue; // Changer la bordure en bleu
    Color? bgColor;
    IconData? icon;
    bgColor = Colors.blue[50];
    if (isAnswered) {

      if (isSelected && isCorrect) {
        bgColor = Colors.blue[100]; // Fond bleu clair pour la bonne réponse
        icon = Icons.check_circle;
        borderColor = Colors.blue; // Bordure bleue pour la bonne réponse
      } else if (isSelected && !isCorrect) {
        bgColor = Colors.red[50];
        icon = Icons.cancel;
        borderColor = Colors.red;
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: OutlinedButton(
        onPressed: isAnswered ? null : onTap,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
          backgroundColor: bgColor ?? Colors.white,
          side: BorderSide(color: borderColor, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 6, // Légère ombre pour plus de profondeur
          shadowColor: Colors.black.withOpacity(0.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.blue, // Texte bleu
                ),
              ),
            ),
            if (icon != null)
              Icon(
                icon,
                color: icon == Icons.check_circle ? Colors.blue : Colors.red, // Icône bleue pour la bonne réponse
              )
          ],
        ),
      ),
    );
  }
}
