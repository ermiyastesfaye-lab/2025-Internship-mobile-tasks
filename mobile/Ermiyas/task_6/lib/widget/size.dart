import 'package:flutter/material.dart';

class ShoeSize extends StatelessWidget {
  final VoidCallback onTap;
  final bool isClicked;
  final int num;
  const ShoeSize(
      {super.key,
      required this.onTap,
      required this.isClicked,
      required this.num});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color:
            isClicked ? const Color.fromARGB(255, 63, 81, 243) : Colors.white,
        elevation: isClicked ? 10 : 4,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            num.toString(),
            style: TextStyle(
                color: isClicked ? Colors.white : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
