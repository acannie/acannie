import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'layout.dart';
import 'controller.dart';

// Terminal の 1 コマンド
class CommandLine {
  String currentDir;
  String stdin;
  String stdout;

  CommandLine(
      {required this.currentDir, required this.stdin, required this.stdout});
}

// Terminal の Controller
class TerminalController with ChangeNotifier {
  // *********************************
  // * コンストラクタ                 *
  // *********************************
  TerminalController() {}

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
    List<String> commandArgs = this._currentCommandLine.stdin.split(" ");
    if (commandArgs.length == 0) {
      return;
    }
    if (commandArgs[0] == "ls") {
      this._runLs(commandArgs);
      return;
    }
    if (commandArgs[0] == "pwd") {
      this._runPwd(commandArgs);
      return;
    }
    if (commandArgs[0] == "help") {
      this._runHelp(commandArgs);
      return;
    }
    this._runCommandNotFound();
  }

  void _runLs(List<String> commandArgs) {}

  // カレントディレクトリのパスを標準出力
  void _runPwd(List<String> commandArgs) {
    this._currentCommandLine.stdout =
        this._slashless(this._toFullPath(this._currentDir));
  }

  void _runHelp(List<String> commandArgs) {}

  // 想定外のコマンドが入力されたときの処理
  void _runCommandNotFound() {
    this._currentCommandLine.stdout = "";
    this._currentCommandLine.stdout += this._currentCommandLine.stdin;
    this._currentCommandLine.stdout +=
        ": Command not found.  Use 'help' to see the command list.\n";
  }

  // コマンドを終了し、新たなコマンドラインを追加
  void _addCommandLine() {
    this._deleteNewLine();
    this._commandLines.add(this._currentCommandLine);
    this._currentCommandLine = CommandLine(
      currentDir: this._slashless(this._toShortPath(this._currentDir)),
      stdin: "",
      stdout: "",
    );
  }

  static String _shortHomeDirPath = "~/";
  static String _fullHomeDirPath = "/home/acannie/";

  // 短縮パスをフルパスに変換
  String _toFullPath(String shortPath) {
    if (shortPath.length < _shortHomeDirPath.length) {
      return shortPath;
    }
    if (shortPath.substring(0, _shortHomeDirPath.length) != _shortHomeDirPath) {
      return shortPath;
    }
    return _fullHomeDirPath + shortPath.substring(_shortHomeDirPath.length);
  }

  // フルパスを短縮パスに変換
  String _toShortPath(String fullPath) {
    if (fullPath.length < _fullHomeDirPath.length) {
      return fullPath;
    }
    if (fullPath.substring(0, _fullHomeDirPath.length) != _fullHomeDirPath) {
      return fullPath;
    }
    return _shortHomeDirPath + fullPath.substring(_fullHomeDirPath.length);
  }

  // パスの末尾のスラッシュを除去
  String _slashless(String path) {
    if (path.isEmpty || path.length == 1) {
      return path;
    }
    if (!path.endsWith("/")) {
      return path;
    }
    return path.substring(0, path.length - 1);
  }

  // パスの末尾にスラッシュを追加
  String _addSlash(String path) {
    if (path.endsWith("/")) {
      return path;
    }
    return path + "/";
  }

  // 標準出力末尾の \n を除去
  void _deleteNewLine() {
    String stdout = this._currentCommandLine.stdout;
    if (!stdout.endsWith("\n")) {
      return;
    }
    this._currentCommandLine.stdout = stdout.substring(0, stdout.length - 1);
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
}

class Terminal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AcannieController _controller =
        Provider.of<AcannieController>(context);
    final TerminalController _terminalController =
        Provider.of<TerminalController>(context);
    final TextEditingController _textController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 過去の入力
        for (CommandLine commandline in _terminalController.commandLines)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Layout.terminalStdInput),
                        children: [
                          TextSpan(
                            text: "acannie@homepage",
                            style: TextStyle(color: Layout.terminalMachineName),
                          ),
                          TextSpan(
                            text: ":",
                          ),
                          TextSpan(
                            text: commandline.currentDir,
                            style: TextStyle(color: Layout.terminalCurrentPath),
                          ),
                          TextSpan(
                            text: "\$ ",
                          ),
                          TextSpan(
                            text: commandline.stdin,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                commandline.stdout,
                style: TextStyle(color: Layout.terminalStdInput),
              ),
            ],
          ),
        // 現在の入力
        Row(
          children: [
            Flexible(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Layout.terminalStdInput),
                  children: [
                    TextSpan(
                      text: "acannie@homepage",
                      style: TextStyle(color: Layout.terminalMachineName),
                    ),
                    TextSpan(
                      text: ":",
                    ),
                    TextSpan(
                      text: _terminalController.currentCommandLine.currentDir,
                      style: TextStyle(color: Layout.terminalCurrentPath),
                    ),
                    TextSpan(
                      text: "\$ ",
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: TextFormField(
                style: TextStyle(color: Layout.terminalStdInput),
                enabled: true,
                maxLength: 100,
                keyboardType: TextInputType.number,
                maxLines: 1,
                inputFormatters: [],
                enableSuggestions: true,
                controller: _textController,
                onFieldSubmitted: (command) {
                  _terminalController.confirmStdIn(command);
                  _textController.clear();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
