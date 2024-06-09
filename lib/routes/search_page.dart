import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallpaper_story/common/screen_info.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenInfo screenInfo = ScreenInfo(context);
    return Scaffold(
      // 背景色
      backgroundColor: const Color.fromARGB(255, 242, 243, 247),
      // 顶部导航栏
      appBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        // 返回按钮
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // 搜索栏
        title: Container(
          height: screenInfo.blockHeight * 6,
          width: screenInfo.blockWidth * 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.grey.shade200,
          ),
          child: const Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration.collapsed(
                    hintText: '搜索内容',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 搜索按钮
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 36,
            ),
            onPressed: () {
              // todo: 搜索功能
            },
          ),
        ],
      ),
    );
  }
}
