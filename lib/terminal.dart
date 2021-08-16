import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'layout.dart';
import 'controller.dart';
import 'utils.dart';

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
        Utils.slashless(Utils.toFullPath(this._currentDir));
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
      Utils.launchURL(
          "https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Facannie.github.io%2Facannie%2F");
    } else if (commandArgs[1] == "-tw") {
      Utils.launchURL(
          "https://twitter.com/intent/tweet?url=https://acannie.github.io/acannie/&text=%23Acannie%0D%0A%23%E3%82%A8%E3%83%B3%E3%82%B8%E3%83%8B%E3%82%A2%0D%0A%23%E8%87%AA%E5%B7%B1%E7%B4%B9%E4%BB%8B%0D%0A%2322%E5%8D%92%0D%0A%23VSCode%0D%0A+Acannie%E3%81%AEVSCode%E9%A2%A8%E8%87%AA%E5%B7%B1%E7%B4%B9%E4%BB%8B%E3%83%9A%E3%83%BC%E3%82%B8%E3%81%A0%E3%82%88%EF%BC%81%E3%81%BF%E3%82%93%E3%81%AA%E3%82%88%E3%82%8D%E3%81%97%E3%81%8F%E3%81%AD%EF%BC%81%0D%0A");
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
      currentDir: Utils.slashless(Utils.toShortPath(this._currentDir)),
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
}

class Terminal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              child: SizedBox(
                height: 15,
                child: TextFormField(
                  cursorColor: Layout.terminalStdInput,
                  cursorWidth: 7,
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
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
