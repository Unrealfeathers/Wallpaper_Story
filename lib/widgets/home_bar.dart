import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallpaper_story/common/screen_info.dart';
import 'package:wallpaper_story/routes/search_page.dart';

class HomeBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeBar({super.key});
  @override
  Widget build(BuildContext context) {
    final screenInfo = ScreenInfo(context);
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        leading: CircleAvatar(
          // todo: 改成从网络获取
          foregroundImage: const AssetImage('assets/images/01.png'),
          backgroundImage: const AssetImage('assets/images/Default_Avatar.png'),
          backgroundColor: Colors.grey.shade200,
        ),
        actions: [
          Container(
            width: screenInfo.blockWidth * 50,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.grey.shade200,
            ),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '搜索',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Icon(
                    Icons.search,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
