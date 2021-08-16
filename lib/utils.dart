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

  static String _shortHomeDirPath = "~/";
  static String _fullHomeDirPath = "/home/acannie/";

  // 短縮パスをフルパスに変換
  static String toFullPath(String shortPath) {
    if (shortPath.length < _shortHomeDirPath.length) {
      return shortPath;
    }
    if (shortPath.substring(0, _shortHomeDirPath.length) != _shortHomeDirPath) {
      return shortPath;
    }
    return _fullHomeDirPath + shortPath.substring(_shortHomeDirPath.length);
  }

  // フルパスを短縮パスに変換
  static String toShortPath(String fullPath) {
    if (fullPath.length < _fullHomeDirPath.length) {
      return fullPath;
    }
    if (fullPath.substring(0, _fullHomeDirPath.length) != _fullHomeDirPath) {
      return fullPath;
    }
    return _shortHomeDirPath + fullPath.substring(_fullHomeDirPath.length);
  }

  // パスの末尾のスラッシュを除去
  static String slashless(String path) {
    if (path.isEmpty || path.length == 1) {
      return path;
    }
    if (!path.endsWith("/")) {
      return path;
    }
    return path.substring(0, path.length - 1);
  }

  // パスの末尾にスラッシュを追加
  static String addSlash(String path) {
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
