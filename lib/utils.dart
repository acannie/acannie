import 'package:url_launcher/url_launcher.dart';

// 現在の年齢を計算
class Utils {
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
