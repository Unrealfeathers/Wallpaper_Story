import 'package:flutter/material.dart';
import 'package:wallpaper_story/common/dio_utils.dart';
import 'package:wallpaper_story/common/screen_info.dart';
import 'package:wallpaper_story/models/index.dart';

class DynamicPage extends StatefulWidget {
  const DynamicPage({super.key});
  @override
  DynamicPageState createState() => DynamicPageState();
}

class DynamicPageState extends State<DynamicPage> {
  DioUtils dioUtils = DioUtils();
  late ScrollController controller;
  late Future wallpaperInfoFuture;
  List<WallpaperInfo> wallpaperInfoList = [];
  List<int> items = List<int>.generate(20, (i) => i);

  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent / 2) {
        _loadMore();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // todo: 加载内容
  Future _loadMore() async {
    setState(() {
      items.addAll(List<int>.generate(20, (i) => items.length + i));
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenInfo = ScreenInfo(context);
    return ListView.builder(
      padding: const EdgeInsets.all(3),
      controller: controller,
      itemCount: items.length,
      itemExtent: screenInfo.blockHeight * 36,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(3),
          // 动态卡片
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              children: [
                // 图片
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      // todo: 改成从网络获取资源
                      'assets/images/01.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                // 信息行
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        // todo: 改成从网络获取资源
                        backgroundImage: AssetImage('assets/images/avatar.jpg'),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "作者-$index",
                        style: TextStyle(
                          fontSize: screenInfo.textFrontSize(20),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "标题-$index",
                          style:
                              TextStyle(fontSize: screenInfo.textFrontSize(18)),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
