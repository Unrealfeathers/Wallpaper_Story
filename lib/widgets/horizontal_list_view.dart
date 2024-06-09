import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_story/common/dio_utils.dart';
import 'package:wallpaper_story/common/screen_info.dart';
import 'package:wallpaper_story/models/wallpaper_element.dart';
import 'package:wallpaper_story/routes/show_page.dart';

class HorizontalListView extends StatefulWidget {
  const HorizontalListView({super.key});
  @override
  HorizontalListViewState createState() => HorizontalListViewState();
}

class HorizontalListViewState extends State<HorizontalListView> {
  DioUtils dioUtils = DioUtils();
  late ScrollController controller;
  late Future wallpaperList;
  List<WallpaperElement> wallpaperElementList = [];
  @override
  void initState() {
    wallpaperList =
        dioUtils.get("/wallpaper/list", ResponseType.json, params: {"num": 10});
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

  Future _loadMore() async {
    setState(
      () {
        if (wallpaperElementList.length < 30) {
          wallpaperList = dioUtils
              .get("/wallpaper/list", ResponseType.json, params: {"num": 10});
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
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenInfo = ScreenInfo(context);
    return Column(
      children: [
        Container(
          height: screenInfo.blockHeight * 6,
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '最近更新',
                style: TextStyle(
                  fontSize: screenInfo.textFrontSize(20),
                  fontWeight: FontWeight.normal,
                  color: Colors.blue,
                ),
              ),
              const Spacer(),
              Text(
                '查看更多',
                style: TextStyle(
                  fontSize: screenInfo.textFrontSize(18),
                  fontWeight: FontWeight.normal,
                  color: Colors.blue,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.blue,
                  size: screenInfo.textFrontSize(18),
                ),
              )
            ],
          ),
        ),
        Container(
          // 限制高度
          height: screenInfo.blockHeight * 24,
          padding: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: CustomScrollView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            slivers: <Widget>[
              SliverFixedExtentList(
                // item高度
                itemExtent: screenInfo.blockWidth * 64,
                delegate: SliverChildBuilderDelegate(
                  // todo: to change
                  childCount: wallpaperElementList.length,
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ShowPage(wallpaperElementList[index]),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: FutureBuilder(
                            future: dioUtils.get(
                              "/image",
                              ResponseType.bytes,
                              params: {"wid": wallpaperElementList[index].wid},
                            ),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
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
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
