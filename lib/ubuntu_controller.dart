import 'package:flutter/material.dart';

import 'utils.dart';

// Terminal の 1 コマンド
class CommandLine {
  String currentDir;
  String stdin;
  String stdout;

  CommandLine(
      {required this.currentDir, required this.stdin, required this.stdout});
}

// Ubuntu の Controller
class UbuntuController with ChangeNotifier {
  // *********************************
  // * コンストラクタ                 *
  // *********************************
  UbuntuController() {}

  // *********************************
  // * 変数                          *
  // *********************************

  // 過去のコマンド
  List<CommandLine> get commandLines => _commandLines;
  List<CommandLine> _commandLines = [];

  // 現在のコマンド
  CommandLine get currentCommandLine => _currentCommandLine;
  CommandLine _currentCommandLine =
      CommandLine(currentDir: "~", stdin: "", stdout: "");

  // 現在のパス
  String get currentDir => _currentDir;
  String _currentDir = "/home/acannie/";

  // *********************************
  // * Private 関数                   *
  // *********************************

  // コマンドを解釈
  void _interpretCommand() {
    List<String> commandArgs =
        this._currentCommandLine.stdin.trim().split(RegExp(r"\s+"));
    final Map<String, Function> commandFunctions = {
      // "ls": this._runLs,
      "pwd": this._runPwd,
      "help": this._runHelp,
      "date": this._runDate,
      "history": this._runHistory,
      "share": this._runShare,
    };

    // 入力なしまたはスペースのみの場合
    if (commandArgs.isEmpty ||
        (commandArgs.length == 1 && commandArgs[0].isEmpty)) {
      return;
    }
    // コマンドが存在しないとき
    if (!commandFunctions.containsKey(commandArgs[0])) {
      this._runCommandNotFound(commandArgs[0]);
      return;
    }

    commandFunctions[commandArgs[0]]!(commandArgs);
  }

  void _runLs(List<String> commandArgs) {}

  // カレントディレクトリのパスを標準出力
  void _runPwd(List<String> commandArgs) {
    this._currentCommandLine.stdout =
        Utils.deleteUbSlash(Utils.toUbAbsolutePath(this._currentDir));
  }

  // 操作ガイドを表示
  void _runHelp(List<String> commandArgs) {
    final Map<String, String> commandDescriptions = {
      // "cat [file]": "open txt or md files.",
      // "cd [dir]": "change directory.",
      "date": "show date.",
      "history": "command history.",
      // "imgcat [img_file]": "open png files.",
      // "ls [-a]": "list segments.",
      // "open [link_file]": "open links.",
      "share [ -fb | -tw ]": "share this page on SNS.",
    };
    this._currentCommandLine.stdout = "";
    this._currentCommandLine.stdout += "Welcome to CUI for Acannie HomePage!\n";
    this._currentCommandLine.stdout += "Basic commands\n";
    this._currentCommandLine.stdout += "\n";

    // 各コマンドの説明を追加
    commandDescriptions.forEach((command, description) {
      this._currentCommandLine.stdout += "\t";
      this._currentCommandLine.stdout += command.padRight(21, " ");
      this._currentCommandLine.stdout += ":";
      this._currentCommandLine.stdout += description;
      this._currentCommandLine.stdout += "\n";
    });
  }

  // 現在のタイムスタンプを表示
  void _runDate(List<String> commandArgs) {
    final DateTime now = DateTime.now();
    this._currentCommandLine.stdout = now.toString();
  }

  // コマンドの履歴を標準出力
  void _runHistory(List<String> commandArgs) {
    this._currentCommandLine.stdout = "";
    int count = 0;
    for (CommandLine commandLine in this._commandLines) {
      // コマンドの中身が空またはスペースのみの場合は履歴に含めない
      if (commandLine.stdin.isEmpty ||
          !RegExp(r"\S+").hasMatch(commandLine.stdin)) {
        continue;
      }
      this._currentCommandLine.stdout += "\t";
      this._currentCommandLine.stdout += count.toString().padLeft(5, ' ');
      this._currentCommandLine.stdout += " ";
      this._currentCommandLine.stdout += commandLine.stdin;
      this._currentCommandLine.stdout += "\n";
      count++;
    }

    if (this._currentCommandLine.stdin.isEmpty ||
        !RegExp(r"\S+").hasMatch(this._currentCommandLine.stdin)) {
      return;
    }
    // 入力したばかりの help コマンドも標準出力
    this._currentCommandLine.stdout += "\t";
    this._currentCommandLine.stdout += count.toString().padLeft(5, ' ');
    this._currentCommandLine.stdout += " ";
    this._currentCommandLine.stdout += this._currentCommandLine.stdin;
    this._currentCommandLine.stdout += "\n";
  }

  // ページを SNS でシェア
  void _runShare(List<String> commandArgs) {
    if ((commandArgs.length != 2) ||
        (commandArgs[1] != "-fb" && commandArgs[1] != "-tw")) {
      this._currentCommandLine.stdout = "usage: share -fb | -tw\n";
      return;
    }
    if (commandArgs[1] == "-fb") {
      Utils.launchURL(Utils.fbShareUrl);
    } else if (commandArgs[1] == "-tw") {
      Utils.launchURL(Utils.twShareUrl);
    }
  }

  // 想定外のコマンドが入力されたときの処理
  void _runCommandNotFound(String mainCommand) {
    this._currentCommandLine.stdout = "";
    this._currentCommandLine.stdout += mainCommand;
    this._currentCommandLine.stdout +=
        ": Command not found.  Use 'help' to see the command list.\n";
  }

  // コマンドを終了し、新たなコマンドラインを追加
  void _addCommandLine() {
    this._currentCommandLine.stdout =
        Utils.deleteNewLine(this._currentCommandLine.stdout);
    this._commandLines.add(this._currentCommandLine);
    this._currentCommandLine = CommandLine(
      currentDir: Utils.deleteUbSlash(Utils.toUbShortPath(this._currentDir)),
      stdin: "",
      stdout: "",
    );
  }

  // *********************************
  // * Public 関数                   *
  // *********************************

  // 入力を確定したときの処理
  void confirmStdIn(String command) {
    this._currentCommandLine.stdin = command;
    this._interpretCommand();
    this._addCommandLine();
    notifyListeners();
  }

  // コマンドラインを削除
  void deleteCommandLines() {
    _commandLines.clear();
    notifyListeners();
  }
}
