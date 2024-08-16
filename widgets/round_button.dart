import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const RoundButton({super.key, required this.title, required this.onTap, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: loading ? const CircularProgressIndicator(
          color: Colors.white,strokeWidth: 3,) : Text(
          title, style: const TextStyle(color: Colors.white),),),),
    );
  }
}


