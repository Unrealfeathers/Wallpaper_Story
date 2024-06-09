import 'package:flutter/material.dart';
import 'package:wallpaper_story/common/screen_info.dart';
import 'package:wallpaper_story/routes/edit_page.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});
  @override
  Widget build(BuildContext context) {
    ScreenInfo screenInfo = ScreenInfo(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: screenInfo.blockHeight * 10,
            width: screenInfo.screenWidth,
            padding: const EdgeInsets.all(6),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  // todo: 改成从网络获取资源
                  radius: 28,
                  backgroundImage: AssetImage('assets/images/avatar.jpg'),
                ),
                SizedBox(
                  width: screenInfo.blockWidth * 3,
                ),
                SizedBox(
                  height: screenInfo.blockHeight * 4,
                  child: Expanded(
                    child: Text(
                      "奇迹于你",
                      style: TextStyle(
                        fontSize: screenInfo.textFrontSize(24),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () {
                    // todo: 更多操作
                  },
                ),
                const Spacer(),
                MaterialButton(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "空间",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  onPressed: () {
                    // todo: 更多操作
                  },
                )
              ],
            ),
          ),
          Container(
            height: screenInfo.blockHeight * 10,
            width: screenInfo.screenWidth,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditPage(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "156",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: screenInfo.textFrontSize(20),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        "动态",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenInfo.textFrontSize(16),
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenInfo.blockHeight * 5,
                  child: const VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditPage(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "279",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: screenInfo.textFrontSize(20),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        "关注",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenInfo.textFrontSize(16),
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenInfo.blockHeight * 5,
                  child: const VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditPage(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "134",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: screenInfo.textFrontSize(20),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        "粉丝",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenInfo.textFrontSize(16),
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: screenInfo.blockHeight * 8,
            width: screenInfo.screenWidth,
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        // todo: 更多操作
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_download_outlined,
                            color: Colors.blue,
                            size: screenInfo.textFrontSize(30),
                          ),
                          Text(
                            "下载记录",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: screenInfo.textFrontSize(12),
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        // todo: 更多操作
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.query_builder_outlined,
                            color: Colors.blue,
                            size: screenInfo.textFrontSize(30),
                          ),
                          Text(
                            "历史记录",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: screenInfo.textFrontSize(12),
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        // todo: 更多操作
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star_border_outlined,
                            color: Colors.blue,
                            size: screenInfo.textFrontSize(30),
                          ),
                          Text(
                            "我的收藏",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: screenInfo.textFrontSize(12),
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        // todo: 更多操作
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.emoji_objects_outlined,
                            color: Colors.blue,
                            size: screenInfo.textFrontSize(30),
                          ),
                          Text(
                            "创作中心",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: screenInfo.textFrontSize(12),
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
