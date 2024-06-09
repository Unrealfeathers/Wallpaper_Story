import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:wallpaper_story/common/dio_utils.dart';
import 'package:wallpaper_story/common/screen_info.dart';
import 'package:permission_handler/permission_handler.dart';

var body = {
  // 去噪强度，0为不去噪，1为去噪
  "denoising_strength": 0,
  // 正面提示词
  "prompt": "",
  // 负面提示词
  "negative_prompt": "",
  // 种子
  "seed": -1,
  // 生成图片数量
  "batch_size": 1,
  // 生成批次
  "n_iter": 1,
  // 生成步数
  "steps": 20,
  // 关键词相关性
  "cfg_scale": 7,
  // 生成图片尺寸
  "width": null,
  "height": null,
  // 脸部修复
  "restore_faces": false,
  // 可平铺
  "tiling": false,
  // 使用模型
  "override_settings": {"sd_model_checkpoint": ""},
  // 一般用于lora模型或其他插件参数
  "script_args": [],
  // 采样方法
  "sampler_index": "Euler"
};

class SDPage extends StatefulWidget {
  const SDPage({super.key});
  @override
  SDPageState createState() => SDPageState();
}

class SDPageState extends State<SDPage> {
  final List<String> data = ["anything-v5-PrtRE.safetensors [7f96a1a9ca]"];
  DioUtils dioUtils = DioUtils();
  Uint8List? imageBytes;
  @override
  Widget build(BuildContext context) {
    ScreenInfo screenInfo = ScreenInfo(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 243, 247),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 图片展示框
            SizedBox(height: screenInfo.blockHeight * 1),
            Container(
                height: screenInfo.blockHeight * 32,
                width: screenInfo.screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: imageBytes == null
                    ? const Icon(
                        Icons.crop_original,
                        size: 81,
                        color: Colors.grey,
                      )
                    : Image.memory(imageBytes!)),
            // 模型表单
            SizedBox(height: screenInfo.blockHeight * 1),
            Container(
              height: screenInfo.blockHeight * 8,
              width: screenInfo.screenWidth,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: DropdownMenu(
                width: screenInfo.screenWidth,
                label: const Text("模型："),
                requestFocusOnTap: true,
                menuStyle: MenuStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.white),
                ),
                inputDecorationTheme: const InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                ),
                dropdownMenuEntries: buildMenuList(data),
                onSelected: (value) {
                  (body["override_settings"] as Map)["sd_model_checkpoint"] =
                      value;
                },
              ),
            ),
            // 尺寸表单
            SizedBox(height: screenInfo.blockHeight * 1),
            Row(
              children: [
                Container(
                  height: screenInfo.blockHeight * 8,
                  width: screenInfo.blockWidth * 49,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      body["width"] = int.parse(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: const Text("宽度："),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      labelStyle: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(width: screenInfo.blockWidth * 2),
                Container(
                  height: screenInfo.blockHeight * 8,
                  width: screenInfo.blockWidth * 49,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      body["height"] = int.parse(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: const Text("高度："),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      labelStyle: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            // 提示词表单
            SizedBox(height: screenInfo.blockHeight * 1),
            Container(
              height: screenInfo.blockHeight * 8,
              width: screenInfo.screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                onChanged: (value) {
                  body["prompt"] = value;
                },
                decoration: InputDecoration(
                  label: const Text("提示词："),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  labelStyle: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            // 负面提示词表单
            SizedBox(height: screenInfo.blockHeight * 1),
            Container(
              height: screenInfo.blockHeight * 8,
              width: screenInfo.screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                onChanged: (value) {
                  body["negative_prompt"] = value;
                },
                decoration: InputDecoration(
                  label: const Text("负面提示词："),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  labelStyle: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            // 生成图片按钮
            SizedBox(height: screenInfo.blockHeight * 1),
            Row(
              children: [
                Container(
                  height: screenInfo.blockHeight * 8,
                  width: screenInfo.blockWidth * 49,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Future<dynamic> sdFuture = dioUtils.post(
                          "http://192.168.31.54:7860/sdapi/v1/txt2img",
                          ResponseType.json,
                          params: body);
                      sdFuture.then((value) {
                        setState(() {
                          imageBytes = base64Decode(value["images"][0]);
                        });
                      });
                    },
                    child: const Text(
                      "生成",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: screenInfo.blockWidth * 2),
                Container(
                  height: screenInfo.blockHeight * 8,
                  width: screenInfo.blockWidth * 49,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      PermissionStatus storageStatus =
                          await Permission.storage.request();
                      if (storageStatus != PermissionStatus.granted) {
                        storageStatus = await Permission.storage.request();
                        if (storageStatus != PermissionStatus.granted) {
                          throw '无法存储图片，请先授权！';
                        }
                      }
                      imageBytes == null
                          ? print("No image to download")
                          : ImageGallerySaver.saveImage(imageBytes!);
                    },
                    child: const Text(
                      "下载",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuEntry<String>> buildMenuList(List<String> data) {
    return data.map((String value) {
      return DropdownMenuEntry<String>(value: value, label: value);
    }).toList();
  }
}
