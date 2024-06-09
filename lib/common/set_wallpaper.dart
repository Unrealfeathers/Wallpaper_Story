import 'package:wallpaper/wallpaper.dart';

class SetWallpaper {
  void setWallpaper(String path, double width, double height) async {
    Stream<String> progressString = Wallpaper.imageDownloadProgress(path);
    progressString.listen(
      (data) {
        // todo: 进度展示
        print(data);
      },
      onDone: () async {
        await Wallpaper.homeScreen(
          width: width,
          height: height,
          options: RequestSizeOptions.RESIZE_EXACT,
        );
      },
    );
  }
}
