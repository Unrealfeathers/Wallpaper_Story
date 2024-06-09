import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_story/common/dio_utils.dart';
import 'package:wallpaper_story/common/screen_info.dart';
import 'package:wallpaper_story/models/index.dart';
import 'package:wallpaper_story/routes/show_page.dart';
import 'package:wallpaper_story/widgets/carousel.dart';
import 'package:wallpaper_story/widgets/horizontal_list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  DioUtils dioUtils = DioUtils();
  late ScrollController controller;
  late Future wallpaperList;
  List<WallpaperElement> wallpaperElementList = [];

  @override
  void initState() {
    wallpaperList =
        dioUtils.get("/wallpaper/list", ResponseType.json, params: {"num": 20});
    wallpaperList.then(
      (value) {
        setState(
          () {
            value["data"].forEach(
              (item) {
                wallpaperElementList.add(WallpaperElement.fromJson(item));
              },
            );
          },
        );
      },
    );
    controller = ScrollController();
    controller.addListener(
      () {
        if (controller.position.pixels >=
            controller.position.maxScrollExtent / 2) {
          _loadMore();
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future _loadMore() async {
    setState(
      () {
        wallpaperList = dioUtils
            .get("/wallpaper/list", ResponseType.json, params: {"num": 20});
        wallpaperList.then(
          (value) {
            setState(
              () {
                value["data"].forEach(
                  (item) {
                    wallpaperElementList.add(WallpaperElement.fromJson(item));
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenInfo = ScreenInfo(context);
    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(height: screenInfo.blockHeight),
              const Carousel(),
              SizedBox(height: screenInfo.blockHeight),
              const HorizontalListView(),
              SizedBox(height: screenInfo.blockHeight),
              Container(
                height: screenInfo.blockHeight * 5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "热门推荐",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              )
            ],
          ),
        ),
        SliverFixedExtentList(
          // item高度
          itemExtent: screenInfo.blockHeight * 24,
          delegate: SliverChildBuilderDelegate(
            childCount: wallpaperElementList.length,
            (BuildContext context, int index) {
              index *= 2;
              return Padding(
                padding: EdgeInsets.all(screenInfo.blockHeight * 0.5),
                child: Row(
                  children: [
                    // 单个卡片
                    Container(
                      height: screenInfo.blockHeight * 24,
                      width: screenInfo.blockWidth * 48,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // 跳转展示页
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ShowPage(wallpaperElementList[index]),
                                ),
                              );
                            },
                            child: SizedBox(
                              height: screenInfo.blockHeight * 20,
                              width: screenInfo.blockWidth * 48,
                              child: FutureBuilder(
                                future: dioUtils.get(
                                  "/image",
                                  ResponseType.bytes,
                                  params: {
                                    "wid": wallpaperElementList[index].wid
                                  },
                                ),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // 请求未完成，显示一个加载指示器
                                    return const Center(
                                      child: SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    // 请求失败，显示错误信息
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    // 请求成功，显示壁纸
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.memory(
                                        Uint8List.fromList(snapshot.data),
                                        fit: BoxFit.fitHeight,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Text(
                              wallpaperElementList[index].title,
                              style: TextStyle(
                                fontSize: screenInfo.textFrontSize(12),
                                height: screenInfo.blockHeight * 0.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: screenInfo.blockHeight * 24,
                      width: screenInfo.blockWidth * 48,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // 跳转展示页
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ShowPage(wallpaperElementList[index]),
                                ),
                              );
                            },
                            child: SizedBox(
                              height: screenInfo.blockHeight * 20,
                              width: screenInfo.blockWidth * 48,
                              child: FutureBuilder(
                                future: dioUtils.get(
                                  "/image",
                                  ResponseType.bytes,
                                  params: {
                                    "wid": wallpaperElementList[index + 1].wid
                                  },
                                ),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // 请求未完成，显示一个加载指示器
                                    return const Center(
                                      child: SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    // 请求失败，显示错误信息
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    // 请求成功，显示壁纸
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.memory(
                                        Uint8List.fromList(snapshot.data),
                                        fit: BoxFit.fitHeight,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Text(
                              wallpaperElementList[index + 1].title,
                              style: TextStyle(
                                fontSize: screenInfo.textFrontSize(12),
                                height: screenInfo.blockHeight * 0.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
