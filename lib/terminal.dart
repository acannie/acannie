import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'layout.dart';
import 'controller.dart';

// Terminal の 1 コマンド
class TerminalIO {
  String currentDir;
  String stdin;
  String stdout;

  TerminalIO(
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
  List<TerminalIO> get terminalIOs => _terminalIOs;
  List<TerminalIO> _terminalIOs = [
    TerminalIO(
      currentDir: "~/acannie/homepage",
      stdin: "ls -la > test.txt",
      stdout: "Introduce\nContact\nWorks\nEngineering\nFavorite\n",
    ),
    TerminalIO(
      currentDir: "~/acannie/homepage",
      stdin: "cd",
      stdout: "\n",
    ),
  ];

  // 現在のコマンド
  TerminalIO get currentTerminalIO => _currentTerminalIO;
  TerminalIO _currentTerminalIO =
      TerminalIO(currentDir: "~/acannie/homepage", stdin: "", stdout: "");

  // *********************************
  // * Private 関数                   *
  // *********************************

  // コマンドを解釈
  void _interpretCommand() {
    List<String> commandArgs = this._currentTerminalIO.stdin.split(" ");
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
  void _runPwd(List<String> commandArgs) {}
  void _runHelp(List<String> commandArgs) {}

  // 想定外のコマンドが入力されたときの処理
  void _runCommandNotFound() {
    this._currentTerminalIO.stdout = "";
    this._currentTerminalIO.stdout += this._currentTerminalIO.stdin;
    this._currentTerminalIO.stdout +=
        ": Command not found.  Use 'help' to see the command list.\n";
  }

  // コマンドを終了し、新たなコマンドラインを追加
  void _addNewTerminalIO() {
    this._terminalIOs.add(this._currentTerminalIO);
    this._currentTerminalIO = TerminalIO(
        currentDir: this._terminalIOs.last.currentDir, stdin: "", stdout: "");
  }

  // *********************************
  // * Public 関数                   *
  // *********************************

  // 入力を確定したときの処理
  void confirmStdIn(String command) {
    this._currentTerminalIO.stdin = command;
    this._interpretCommand();
    this._addNewTerminalIO();
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
        for (TerminalIO terminalIO in _terminalController.terminalIOs)
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
                            text: terminalIO.currentDir,
                            style: TextStyle(color: Layout.terminalCurrentPath),
                          ),
                          TextSpan(
                            text: "\$ ",
                          ),
                          TextSpan(
                            text: terminalIO.stdin,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                terminalIO.stdout,
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
                      text: _terminalController.currentTerminalIO.currentDir,
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
