import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallpaper_story/routes/edit_page.dart';

class UserBar extends StatelessWidget implements PreferredSizeWidget {
  const UserBar({super.key});
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_2_outlined),
            onPressed: () {
              // todo: 更多操作
            },
          ),
          IconButton(
            icon: const Icon(Icons.palette_outlined),
            onPressed: () {
              // todo: 更多操作
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // todo: 更多操作
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(60);
}
