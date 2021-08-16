import 'package:url_launcher/url_launcher.dart';

// 現在の年齢を計算
class Utils {
  // SNS シェア用 URL
  static String fbShareUrl =
      "https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Facannie.github.io%2Facannie%2F";
  static String twShareUrl =
      "https://twitter.com/intent/tweet?url=https://acannie.github.io/acannie/&text=%23Acannie%0D%0A%23%E3%82%A8%E3%83%B3%E3%82%B8%E3%83%8B%E3%82%A2%0D%0A%23%E8%87%AA%E5%B7%B1%E7%B4%B9%E4%BB%8B%0D%0A%2322%E5%8D%92%0D%0A%23VSCode%0D%0A+Acannie%E3%81%AEVSCode%E9%A2%A8%E8%87%AA%E5%B7%B1%E7%B4%B9%E4%BB%8B%E3%83%9A%E3%83%BC%E3%82%B8%E3%81%A0%E3%82%88%EF%BC%81%E3%81%BF%E3%82%93%E3%81%AA%E3%82%88%E3%82%8D%E3%81%97%E3%81%8F%E3%81%AD%EF%BC%81%0D%0A";

  // 年齢計算
  int oldness() {
    DateTime now = DateTime.now();
    DateTime birthday = DateTime(1997, 5, 30);
    int oldness = now.year - birthday.year - 1;
    if (now.month > birthday.month) {
      oldness += 1;
    } else if ((now.month == birthday.month) && (now.day >= birthday.day)) {
      oldness += 1;
    }
    return oldness;
  }

  // 新しいタブで URL のページを開く
  static void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static String _ubShortHomeDirPath = "~/";
  static String _ubAbsoluteHomeDirPath = "/home/acannie/";
  static String _psAbsoluteHomeDirPath = "C:\\Users\\acannie\\";

  // 【Ubuntu】短縮パスをフルパスに変換
  static String toUbAbsolutePath(String shortPath) {
    if (shortPath.length < _ubShortHomeDirPath.length) {
      return shortPath;
    }
    if (shortPath.substring(0, _ubShortHomeDirPath.length) !=
        _ubShortHomeDirPath) {
      return shortPath;
    }
    return _ubAbsoluteHomeDirPath +
        shortPath.substring(_ubShortHomeDirPath.length);
  }

  // 【Ubuntu】フルパスを短縮パスに変換
  static String toUbShortPath(String fullPath) {
    if (fullPath.length < _ubAbsoluteHomeDirPath.length) {
      return fullPath;
    }
    if (fullPath.substring(0, _ubAbsoluteHomeDirPath.length) !=
        _ubAbsoluteHomeDirPath) {
      return fullPath;
    }
    return _ubShortHomeDirPath +
        fullPath.substring(_ubAbsoluteHomeDirPath.length);
  }

  // 【Ubuntu】パスの末尾のスラッシュを除去
  static String deleteUbSlash(String path) {
    if (path.isEmpty || path.length == 1) {
      return path;
    }
    if (!path.endsWith("/")) {
      return path;
    }
    return path.substring(0, path.length - 1);
  }

  // 【Ubuntu】パスの末尾にスラッシュを追加
  static String addUbSlash(String path) {
    if (path.endsWith("/")) {
      return path;
    }
    return path + "/";
  }

  // 【PowerShell】パスの末尾のスラッシュを除去
  static String deletePsSlash(String path) {
    if (path.isEmpty || path.length == 1) {
      return path;
    }
    if (!path.endsWith("\\")) {
      return path;
    }
    return path.substring(0, path.length - 1);
  }

  // 【PowerShell】パスの末尾にスラッシュを追加
  static String addPsSlash(String path) {
    if (path.endsWith("/")) {
      return path;
    }
    return path + "/";
  }

  // 末尾の \n を除去
  static String deleteNewLine(String s) {
    if (!s.endsWith("\n")) {
      return s;
    }
    return s.substring(0, s.length - 1);
  }
}
