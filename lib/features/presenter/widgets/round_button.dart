import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String label;
  final Function onTap;

  const RoundButton({Key? key, 
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      onTap: onTap as Function(),
    );
  }
}