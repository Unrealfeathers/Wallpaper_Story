import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:wallpaper_story/common/dio_utils.dart';
import 'package:wallpaper_story/common/screen_info.dart';
import 'package:wallpaper_story/models/index.dart';
import 'package:wallpaper_story/models/wallpaper_element.dart';
import 'package:wallpaper_story/routes/show_page.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});
  @override
  CarouselState createState() => CarouselState();
}

class CarouselState extends State<Carousel> {
  DioUtils dioUtils = DioUtils();
  late Future displayFuture;
  List<WallpaperElement> wallpaperElementList = [];

  @override
  void initState() {
    displayFuture =
        dioUtils.get("/wallpaper/list", ResponseType.json, params: {"num": 4});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenInfo = ScreenInfo(context);
    return Container(
      height: screenInfo.blockHeight * 24,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: FutureBuilder(
        future: displayFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 请求未完成，显示一个加载指示器
            return const Center(
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            // 请求失败，显示一个加载指示器
            return const Center(
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasData) {
            // 请求成功，显示壁纸
            snapshot.data["data"].forEach(
              (item) {
                wallpaperElementList.add(WallpaperElement.fromJson(item));
              },
            );
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Swiper(
                itemCount: wallpaperElementList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ShowPage(wallpaperElementList[index]),
                        ),
                      );
                    },
                    child: FutureBuilder(
                      future: dioUtils.get("/image", ResponseType.bytes,
                          params: {"wid": wallpaperElementList[index].wid}),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                          // 请求失败，显示一个加载指示器
                          return const Center(
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          // 请求成功，显示壁纸
                          return Image.memory(
                            Uint8List.fromList(snapshot.data),
                            fit: BoxFit.fitWidth,
                          );
                        }
                      },
                    ),
                  );
                },
                loop: true,
                autoplay: true,
                control: const SwiperControl(),
                pagination: const SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.white,
                    activeColor: Colors.blue,
                    size: 6,
                    activeSize: 8,
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
