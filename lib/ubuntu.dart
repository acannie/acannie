import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'layout.dart';
import 'ubuntu_controller.dart';

class Ubuntu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UbuntuController _terminalController =
        Provider.of<UbuntuController>(context);
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
