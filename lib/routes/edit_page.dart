import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallpaper_story/common/screen_info.dart';
import 'package:wallpaper_story/routes/login_page.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenInfo screenInfo = ScreenInfo(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 243, 247),
      appBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenInfo.blockHeight,
            ),
            DecoratedBox(
              decoration: const BoxDecoration(color: Colors.white),
              child: MaterialButton(
                onPressed: () {
                  // todo: 更多操作
                },
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    children: [
                      Text(
                        "头像",
                        style: TextStyle(
                          fontSize: screenInfo.textFrontSize(20),
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        // todo: 改成从网络获取资源
                        radius: screenInfo.textFrontSize(20),
                        backgroundImage:
                            const AssetImage('assets/images/avatar.jpg'),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: screenInfo.textFrontSize(20),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0,
              width: screenInfo.blockWidth * 90,
              child: Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
            ),
            DecoratedBox(
              decoration: const BoxDecoration(color: Colors.white),
              child: MaterialButton(
                onPressed: () {
                  // todo: 更多操作
                },
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    children: [
                      Text(
                        "昵称",
                        style: TextStyle(
                          fontSize: screenInfo.textFrontSize(20),
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "奇迹于你",
                        style: TextStyle(
                          fontSize: screenInfo.textFrontSize(20),
                          color: Colors.grey,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: screenInfo.textFrontSize(20),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0,
              width: screenInfo.blockWidth * 90,
              child: Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
            ),
            DecoratedBox(
              decoration: const BoxDecoration(color: Colors.white),
              child: MaterialButton(
                onPressed: () {
                  // todo: 更多操作
                },
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    children: [
                      Text(
                        "性别",
                        style: TextStyle(
                          fontSize: screenInfo.textFrontSize(20),
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "男",
                        style: TextStyle(
                          fontSize: screenInfo.textFrontSize(20),
                          color: Colors.grey,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: screenInfo.textFrontSize(20),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0,
              width: screenInfo.blockWidth * 90,
              child: Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
            ),
            DecoratedBox(
              decoration: const BoxDecoration(color: Colors.white),
              child: MaterialButton(
                onPressed: () {
                  // todo: 更多操作
                },
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    children: [
                      Text(
                        "出生年月",
                        style: TextStyle(
                          fontSize: screenInfo.textFrontSize(20),
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "2003-01-30",
                        style: TextStyle(
                          fontSize: screenInfo.textFrontSize(20),
                          color: Colors.grey,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: screenInfo.textFrontSize(20),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0,
              width: screenInfo.blockWidth * 90,
              child: Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
            ),
            DecoratedBox(
              decoration: const BoxDecoration(color: Colors.white),
              child: MaterialButton(
                onPressed: () {
                  // todo: 更多操作
                },
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    children: [
                      Text(
                        "邮箱",
                        style: TextStyle(
                          fontSize: screenInfo.textFrontSize(20),
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "123456789@123.com",
                        style: TextStyle(
                          fontSize: screenInfo.textFrontSize(20),
                          color: Colors.grey,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: screenInfo.textFrontSize(20),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0,
              width: screenInfo.blockWidth * 90,
              child: Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
            ),
            DecoratedBox(
              decoration: const BoxDecoration(color: Colors.white),
              child: MaterialButton(
                onPressed: () {
                  // todo: 更多操作
                },
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    children: [
                      Text(
                        "修改密码",
                        style: TextStyle(
                          fontSize: screenInfo.textFrontSize(20),
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.chevron_right,
                        size: screenInfo.textFrontSize(20),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0,
              width: screenInfo.blockWidth * 90,
              child: Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
            ),
            DecoratedBox(
              decoration: const BoxDecoration(color: Colors.white),
              child: MaterialButton(
                onPressed: () {
                  // todo: 更多操作
                },
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    children: [
                      Text(
                        "账号ID",
                        style: TextStyle(
                          fontSize: screenInfo.textFrontSize(20),
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "000001",
                        style: TextStyle(
                          fontSize: screenInfo.textFrontSize(20),
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0,
              width: screenInfo.blockWidth * 90,
              child: Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
            ),
            Container(
              width: screenInfo.screenWidth,
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(color: Colors.white),
              child: MaterialButton(
                onPressed: () {
                  // todo: 更多操作
                },
                child: Text(
                  "切换账号",
                  style: TextStyle(
                    fontSize: screenInfo.textFrontSize(20),
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0,
              width: screenInfo.blockWidth * 90,
              child: Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
            ),
            Container(
              width: screenInfo.screenWidth,
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(color: Colors.white),
              child: MaterialButton(
                onPressed: () {
                  // todo: 更多操作
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: Text(
                  "退出登录",
                  style: TextStyle(
                    fontSize: screenInfo.textFrontSize(20),
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
