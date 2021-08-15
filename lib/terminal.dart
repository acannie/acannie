import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final Map<String, Function> commandFunctions = {
      // "ls": this._runLs,
      "pwd": this._runPwd,
      "help": this._runHelp,
      "date": this._runHelp,
      "history": this._runHistory,
      "share": this._runShare,
    };

    // 入力なしまたはスペースのみの場合
    if (commandArgs.length == 0) {
      return;
    }
    // コマンドが存在しないとき
    if (!commandFunctions.containsKey(commandArgs[0])) {
      this._runCommandNotFound();
      return;
    }

    commandFunctions[commandArgs[0]]!(commandArgs);
  }

  void _runLs(List<String> commandArgs) {}

  // カレントディレクトリのパスを標準出力
  void _runPwd(List<String> commandArgs) {
    this._currentCommandLine.stdout =
        this._slashless(this._toFullPath(this._currentDir));
  }

  // 操作ガイドを表示
  void _runHelp(List<String> commandArgs) {
    this._currentCommandLine.stdout = "";
    this._currentCommandLine.stdout += "Welcome to CUI for Acannie HomePage!\n";
    this._currentCommandLine.stdout += "Basic commands\n";
    this._currentCommandLine.stdout += "\n";
    // this._currentCommandLine.stdout += "\tcat [file]".padRight(21, " ") + ":open txt or md files.\n";
    // this._currentCommandLine.stdout += "\tcd [dir]".padRight(21, " ") + ":change directory.\n";
    this._currentCommandLine.stdout +=
        "\tdate".padRight(21, " ") + ":show date.\n";
    this._currentCommandLine.stdout +=
        "\thistory".padRight(21, " ") + ":command history.\n";
    // this._currentCommandLine.stdout += "\timgcat [img_file]".padRight(21, " ") + ":open png files.\n";
    // this._currentCommandLine.stdout += "\tls [-a]".padRight(21, " ") + ":list segments.\n";
    // this._currentCommandLine.stdout += "\topen [link_file]".padRight(21, " ") + ":open links.\n";
    this._currentCommandLine.stdout +=
        "\tshare [ -fb | -tw ]".padRight(21, " ") +
            ":share this page on SNS.\n";
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
      this._currentCommandLine.stdout += "\t";
      this._currentCommandLine.stdout += count.toString().padLeft(5, ' ');
      this._currentCommandLine.stdout += " ";
      this._currentCommandLine.stdout += commandLine.stdin;
      this._currentCommandLine.stdout += "\n";
      count++;
    }
  }

  // 新しいタブで URL のページを開く
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // ページを SNS でシェア
  void _runShare(List<String> commandArgs) {
    if ((commandArgs.length != 2) ||
        (commandArgs[1] != "-fb" && commandArgs[1] != "-tw")) {
      this._currentCommandLine.stdout = "usage: share -fb | -tw\n";
      return;
    }
    if (commandArgs[1] == "-fb") {
      this._launchURL(
          "https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Facannie.github.io%2Facannie%2F");
    } else if (commandArgs[1] == "-tw") {
      this._launchURL(
          "https://twitter.com/intent/tweet?url=https://acannie.github.io/acannie/&text=%23Acannie%0D%0A%23%E3%82%A8%E3%83%B3%E3%82%B8%E3%83%8B%E3%82%A2%0D%0A%23%E8%87%AA%E5%B7%B1%E7%B4%B9%E4%BB%8B%0D%0A%2322%E5%8D%92%0D%0A%23VSCode%0D%0A+Acannie%E3%81%AEVSCode%E9%A2%A8%E8%87%AA%E5%B7%B1%E7%B4%B9%E4%BB%8B%E3%83%9A%E3%83%BC%E3%82%B8%E3%81%A0%E3%82%88%EF%BC%81%E3%81%BF%E3%82%93%E3%81%AA%E3%82%88%E3%82%8D%E3%81%97%E3%81%8F%E3%81%AD%EF%BC%81%0D%0A");
    }
  }

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
    FocusNode _myFocusNode = FocusNode();

    // Terminal のフォント共通スタイル
    const TextStyle _terminalTextStyle = TextStyle(
      color: Layout.terminalStdInput,
      fontFamily: "RobotoMono",
      fontSize: 15,
    );

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
                        style: _terminalTextStyle,
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
                style: _terminalTextStyle,
              ),
            ],
          ),
        // 現在の入力
        Row(
          children: [
            Flexible(
              child: RichText(
                text: TextSpan(
                  style: _terminalTextStyle,
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
                style: _terminalTextStyle,
                enabled: true,
                maxLines: 1,
                inputFormatters: [],
                controller: _textController,
                focusNode: _myFocusNode,
                onFieldSubmitted: (command) {
                  _terminalController.confirmStdIn(command);
                  _textController.clear();
                  _myFocusNode.requestFocus();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
