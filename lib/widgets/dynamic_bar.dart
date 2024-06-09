import 'package:flutter/material.dart';

class DynamicBar extends StatelessWidget implements PreferredSizeWidget {
  const DynamicBar({super.key});
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        title: const Center(
          child: Text(
            '关注动态',
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
