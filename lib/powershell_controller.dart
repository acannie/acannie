import 'package:flutter/material.dart';

import 'utils.dart';

// PowerShell の 1 コマンド
class CommandLine {
  String currentDir;
  String stdin;
  String stdout;

  CommandLine(
      {required this.currentDir, required this.stdin, required this.stdout});
}

// PowerShell の Controller
class PowerShellController with ChangeNotifier {
  // *********************************
  // * コンストラクタ                 *
  // *********************************
  PowerShellController() {}

  // *********************************
  // * 変数                          *
  // *********************************

  // 過去のコマンド
  List<CommandLine> get commandLines => _commandLines;
  List<CommandLine> _commandLines = [];

  // 現在のコマンド
  CommandLine get currentCommandLine => _currentCommandLine;
  CommandLine _currentCommandLine =
      CommandLine(currentDir: "C:\\Users\\acannie", stdin: "", stdout: "");

  // 現在のパス
  String get currentDir => _currentDir;
  String _currentDir = "C:\\Users\\acannie\\";

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
      "echo": this._runEcho,
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
    this._currentCommandLine.stdout = "";
    this._currentCommandLine.stdout += "\n";
    this._currentCommandLine.stdout += "Path\n";
    this._currentCommandLine.stdout += "----\n";
    this._currentCommandLine.stdout += Utils.deletePsSlash(this._currentDir);
    this._currentCommandLine.stdout += "\n";
    this._currentCommandLine.stdout += "\n";
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
      "echo [text]": "outputs the strings.",
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
    this._currentCommandLine.stdout = "\n";
    this._currentCommandLine.stdout += now.year.toString() + "年";
    this._currentCommandLine.stdout += now.month.toString() + "月";
    this._currentCommandLine.stdout += now.day.toString() + "日";
    this._currentCommandLine.stdout += " ";
    this._currentCommandLine.stdout += now.hour.toString() + ":";
    this._currentCommandLine.stdout +=
        now.minute.toString().padLeft(2, "0") + ":";
    this._currentCommandLine.stdout +=
        now.second.toString().padLeft(2, "0") + "\n";
    this._currentCommandLine.stdout += "\n";
  }

  // コマンドの履歴を標準出力
  void _runHistory(List<String> commandArgs) {
    this._currentCommandLine.stdout = "\n";
    this._currentCommandLine.stdout += "  Id CommandLine\n";
    this._currentCommandLine.stdout += "  -- -----------\n";

    int count = 0;
    for (CommandLine commandLine in this._commandLines) {
      // コマンドの中身が空またはスペースのみの場合は履歴に含めない
      if (commandLine.stdin.isEmpty ||
          !RegExp(r"\S+").hasMatch(commandLine.stdin)) {
        continue;
      }
      this._currentCommandLine.stdout += (count + 1).toString().padLeft(4, ' ');
      this._currentCommandLine.stdout += " ";
      this._currentCommandLine.stdout += commandLine.stdin;
      this._currentCommandLine.stdout += "\n";
      count++;
    }
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

  // 入力をそのまま返す
  void _runEcho(List<String> commandArgs) {
    this._currentCommandLine.stdout = "";
    for (int i = 1; i < commandArgs.length; i++) {
      this._currentCommandLine.stdout += commandArgs[i] + "\n";
    }
  }

  // 想定外のコマンドが入力されたときの処理
  void _runCommandNotFound(String mainCommand) {
    this._currentCommandLine.stdout = "";
    this._currentCommandLine.stdout += mainCommand;
    this._currentCommandLine.stdout += " : 用語 \'";
    this._currentCommandLine.stdout += mainCommand;
    this._currentCommandLine.stdout +=
        "\' は、コマンドレット、関数、スクリプト ファイル、または操作可能なプログラムの名前として認識されません。名前が正しく記述されていることを確認し、パスが含まれている場合はそのパスが正しいことを確認してから、再試行してください。発生場所 行:1 文字:1\n";
  }

  // コマンドを終了し、新たなコマンドラインを追加
  void _addCommandLine() {
    this._currentCommandLine.stdout = this._currentCommandLine.stdout;
    this._commandLines.add(this._currentCommandLine);
    this._currentCommandLine = CommandLine(
      currentDir: Utils.deletePsSlash(this._currentDir),
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
