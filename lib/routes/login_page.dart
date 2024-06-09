import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallpaper_story/common/dio_utils.dart';
import 'package:wallpaper_story/common/screen_info.dart';
import 'package:wallpaper_story/routes/signup_page.dart';
import 'package:wallpaper_story/routes/user_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  late TextEditingController usernameController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DioUtils dioUtils = DioUtils();
    ScreenInfo screenInfo = ScreenInfo(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 242, 243, 247),
      appBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: const Text(
          "账号登录",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenInfo.blockHeight,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Colors.white,
              ),
              child: TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: "账号",
                  hintText: "您的账号",
                  prefixIcon: Icon(Icons.person),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: screenInfo.blockHeight,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Colors.white,
              ),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  prefixIcon: Icon(Icons.lock),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: screenInfo.blockHeight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  height: screenInfo.blockHeight * 6,
                  minWidth: screenInfo.blockWidth * 30,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "登录",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenInfo.textFrontSize(20),
                    ),
                  ),
                  onPressed: () async {
                    String username = usernameController.text;
                    String password = passwordController.text;
                    Map<String, dynamic> params = {
                      'username': username,
                      'password': password,
                    };
                    dioUtils
                        .post(
                      "/user/login",
                      ResponseType.json,
                      params: params,
                    )
                        .then(
                      (value) {
                        if (value["code"] == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserPage(),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("登录失败"),
                                content: const Text("很抱歉，登录失败，请确认账号和密码后重试"),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: const Text('确认'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                ),
                MaterialButton(
                  height: screenInfo.blockHeight * 6,
                  minWidth: screenInfo.blockWidth * 30,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "注册",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenInfo.textFrontSize(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                // todo: 更多操作
              },
              child: Text(
                "登陆有问题？请点这里",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenInfo.textFrontSize(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
