import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_story/routes/dynamic_page.dart';
import 'package:wallpaper_story/routes/sd_page.dart';
import 'package:wallpaper_story/routes/user_page.dart';
import 'package:wallpaper_story/widgets/dynamic_bar.dart';
import 'package:wallpaper_story/widgets/home_bar.dart';
import 'package:wallpaper_story/routes/home_page.dart';
import 'package:wallpaper_story/widgets/sd_bar.dart';
import 'package:wallpaper_story/widgets/user_bar.dart';

void main() {
  // 运行应用
  runApp(const MyApp());
  // 设置状态栏样式
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
}

// 主界面
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // 底部导航栏选中索引
  int selectedIndex = 0;
  // 顶部导航栏列表
  final topBarList = [
    const HomeBar(),
    const DynamicBar(),
    null,
    const SDBar(),
    const UserBar(),
  ];
  // 页面列表
  final pageList = [
    const HomePage(),
    const DynamicPage(),
    null,
    const SDPage(),
    const UserPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 去除DEBUG标志
      debugShowCheckedModeBanner: false,
      // 标题
      title: '壁纸物语',
      // 主题
      theme: ThemeData(
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(scrolledUnderElevation: 0.0),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      // 主页
      home: SafeArea(
        child: Scaffold(
          // 背景色
          backgroundColor: const Color.fromARGB(255, 242, 243, 247),
          // 顶部导航栏
          appBar: topBarList[selectedIndex] as PreferredSizeWidget?,
          // 主体
          body: pageList[selectedIndex],
          // 底部导航栏
          bottomNavigationBar: BottomNavigationBar(
            // 布局类型
            type: BottomNavigationBarType.fixed,
            // 选中颜色
            selectedItemColor: Colors.blue,
            // 导航索引
            currentIndex: selectedIndex,
            // 点击事件
            onTap: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
            // 导航按键
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '首页',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star_border),
                label: '动态',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.blue,
                  size: 40,
                ),
                label: '上传',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.crop_original),
                label: '绘画',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '我的',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
