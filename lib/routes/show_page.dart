import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallpaper_story/models/index.dart';
import 'package:wallpaper_story/common/dio_utils.dart';
import 'package:wallpaper_story/common/screen_info.dart';
import 'package:wallpaper_story/common/set_wallpaper.dart';

class ShowPage extends StatefulWidget {
  final WallpaperElement wallpaperElement;
  const ShowPage(this.wallpaperElement, {super.key});
  @override
  ShowPageState createState() => ShowPageState();
}

class ShowPageState extends State<ShowPage> {
  DioUtils dioUtils = DioUtils();
  late Future wallapperFuture;
  late Future imageFuture;

  int index = 0;
  late List pageList;

  @override
  void initState() {
    // 请求壁纸信息
    wallapperFuture = dioUtils.get("/wallpaper/info", ResponseType.json,
        params: {"wid": widget.wallpaperElement.wid});
    // 请求壁纸图片
    imageFuture = dioUtils.get("/image", ResponseType.bytes,
        params: {"wid": widget.wallpaperElement.wid});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenInfo = ScreenInfo(context);
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
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // todo: 更多操作
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 壁纸展示
          SizedBox(
            height: screenInfo.blockHeight * 32,
            width: screenInfo.screenWidth,
            child: FutureBuilder<dynamic>(
              future: imageFuture,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // 显示一个加载指示器
                  return const Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  // 显示错误信息
                  return Text('Error: ${snapshot.error}');
                } else {
                  // 请求成功，显示壁纸
                  return Image.memory(
                    Uint8List.fromList(snapshot.data),
                    fit: BoxFit.fitHeight,
                  );
                }
              },
            ),
          ),
          // 操作栏
          Container(
            height: screenInfo.blockHeight * 14,
            width: screenInfo.screenWidth,
            padding: const EdgeInsets.all(3),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                // 设置壁纸按键
                TextButton(
                  onPressed: () {
                    SetWallpaper setWallpaper = SetWallpaper();
                    setWallpaper.setWallpaper(
                      dioUtils.getFullUrl(
                          "/image?wid=${widget.wallpaperElement.wid}"),
                      screenInfo.screenWidth,
                      screenInfo.screenHeight,
                    );
                  },
                  child: Text(
                    "设置壁纸",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenInfo.textFrontSize(24),
                      color: const Color.fromARGB(255, 102, 153, 204),
                    ),
                  ),
                ),
                // 分割线
                SizedBox(
                  width: screenInfo.screenWidth,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 204, 255, 255),
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      // 信息页按键
                      child: TextButton(
                        onPressed: () {
                          setState(
                            () {
                              index = 0;
                            },
                          );
                        },
                        child: Text(
                          "作品信息",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenInfo.textFrontSize(24),
                            color: const Color.fromARGB(255, 153, 204, 255),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      // 评论页按键
                      child: TextButton(
                        onPressed: () {
                          setState(
                            () {
                              index = 1;
                            },
                          );
                        },
                        child: Text(
                          "评论",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenInfo.textFrontSize(24),
                            color: const Color.fromARGB(255, 153, 204, 255),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 信息页
          FutureBuilder(
            future: wallapperFuture,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // 显示一个加载指示器
                return const Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                // 显示错误信息
                return Text('Error: ${snapshot.error}');
              } else {
                // 请求成功
                WallpaperInfo wallpaperInfo =
                    WallpaperInfo.fromJson(snapshot.data["data"]);
                pageList = [
                  InfoPage(wallpaperInfo),
                  const CommentPage(),
                ];
                return pageList[index];
              }
            },
          )
        ],
      ),
    );
  }
}

// 作品信息页
class InfoPage extends StatefulWidget {
  final WallpaperInfo wallpaperInfo;
  const InfoPage(this.wallpaperInfo, {super.key});
  @override
  InfoPageState createState() => InfoPageState();
}

class InfoPageState extends State<InfoPage> {
  DioUtils dioUtils = DioUtils();
  late Future userFuture;
  late Future avatarFuture;

  @override
  void initState() {
    userFuture = dioUtils.get("/user/info", ResponseType.json,
        params: {"uid": widget.wallpaperInfo.uid});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenInfo screenInfo = ScreenInfo(context);
    return Expanded(
      child: Container(
        width: screenInfo.screenWidth,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: FutureBuilder(
          future: userFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 请求未完成，显示一个加载指示器
              return const Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              // 请求失败，显示错误信息
              return Text('Error: ${snapshot.error}');
            } else {
              // 请求成功，显示用户信息
              UserInfo userInfo = UserInfo.fromJson(snapshot.data["data"]);
              // 获取用户头像
              avatarFuture = dioUtils.get(userInfo.avatar, ResponseType.bytes);
              return Column(
                children: [
                  // 操作行
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          // todo: 点赞
                        },
                        icon: const Icon(Icons.favorite_border),
                      ),
                      Text(widget.wallpaperInfo.likeAccount),
                      IconButton(
                        onPressed: () {
                          // todo: 收藏
                        },
                        icon: const Icon(Icons.collections_bookmark_outlined),
                      ),
                      Text(widget.wallpaperInfo.collectAccount),
                      IconButton(
                        onPressed: () {
                          // todo: 下载
                        },
                        icon: const Icon(Icons.get_app_outlined),
                      ),
                      const Text("下载"),
                    ],
                  ),
                  // 用户信息行
                  Row(
                    children: [
                      FutureBuilder(
                        future: avatarFuture,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // 请求未完成，显示一个加载指示器
                            return const Center(
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            // 请求失败，显示错误信息
                            return Text('Error: ${snapshot.error}');
                          } else {
                            // 请求成功，显示用户头像
                            return CircleAvatar(
                              backgroundImage: Image.memory(
                                      Uint8List.fromList(snapshot.data))
                                  .image,
                            );
                          }
                        },
                      ),
                      const SizedBox(width: 6),
                      Text(
                        userInfo.username,
                        style: TextStyle(
                          fontSize: screenInfo.textFrontSize(20),
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "关注",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blue),
                        ),
                      )
                    ],
                  ),
                  // 标题行
                  Row(
                    children: [
                      Container(
                        width: 64,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 0.5),
                        ),
                        child: const Text(
                          "标题：",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        widget.wallpaperInfo.title,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: screenInfo.textFrontSize(18),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  // Tag行
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 50,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 0.5),
                      ),
                      child: const Text(
                        "Tags:",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: widget.wallpaperInfo.tags
                        .map(
                          (tag) => Container(
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 0.5),
                            ),
                            child: Text(
                              tag,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

// 评论页
class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  CommentPageState createState() => CommentPageState();
}

class CommentPageState extends State<CommentPage> {
  DioUtils dioUtils = DioUtils();
  @override
  Widget build(BuildContext context) {
    ScreenInfo screenInfo = ScreenInfo(context);
    return Expanded(
      child: Container(
        width: screenInfo.screenWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: FutureBuilder(
          future: dioUtils.get("/wallpaper", ResponseType.json),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 请求未完成，显示一个加载指示器
              return const Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              // 请求失败，显示错误信息
              return Text('Error: ${snapshot.error}');
            } else {
              // 请求成功，显示壁纸信息
              // WallpaperInfo wallpaperInfo =
              //     WallpaperInfo.fromJson(snapshot.data);
              // print(wallpaperInfo.message);
              return const Column(
                children: [
                  // Text(wallpaperInfo.message),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
