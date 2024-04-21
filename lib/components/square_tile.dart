// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  SquareTile({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  final String imagePath;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Image.asset(
          imagePath,
          height: 50,
        ),
      ),
    );
  }
}
