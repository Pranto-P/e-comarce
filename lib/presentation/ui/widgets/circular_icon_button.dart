import 'package:flutter/material.dart';

class CircularButtonIcon extends StatelessWidget {
  const CircularButtonIcon({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 15,
        backgroundColor: Colors.grey.shade200,
        child: Icon(icon, color: Colors.grey, size: 20),
      ),
    );
  }
}
