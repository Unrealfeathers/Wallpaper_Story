import 'package:flutter/material.dart';

class SDBar extends StatelessWidget implements PreferredSizeWidget {
  const SDBar({super.key});
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        title: const Center(
          child: Text(
            'AI绘图',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(60);
}
