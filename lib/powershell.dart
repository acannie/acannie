import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'layout.dart';
import 'powershell_controller.dart';

class PowerShell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PowerShellController _powerShellController =
        Provider.of<PowerShellController>(context);
    final TextEditingController _textController = TextEditingController();
    FocusNode _myFocusNode = FocusNode();

    // Terminal のフォント共通スタイル
    const TextStyle _powerShellTextStyle = TextStyle(
      color: Layout.terminalStdInput,
      fontFamily: "RobotoMono",
      fontSize: 15,
    );

    const TextStyle _powerShellStdinTextStyle = TextStyle(
      color: Color.fromARGB(255, 245, 245, 67),
      fontFamily: "RobotoMono",
      fontSize: 15,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 過去の入力
        for (CommandLine commandline in _powerShellController.commandLines)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        style: _powerShellTextStyle,
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
                style: _powerShellTextStyle,
              ),
            ],
          ),
        // 現在の入力
        Row(
          children: [
            Flexible(
              child: RichText(
                text: TextSpan(
                  style: _powerShellTextStyle,
                  children: [
                    TextSpan(
                      text: "acannie@homepage",
                      style: TextStyle(color: Layout.terminalMachineName),
                    ),
                    TextSpan(
                      text: ":",
                    ),
                    TextSpan(
                      text: _powerShellController.currentCommandLine.currentDir,
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
                  style: _powerShellStdinTextStyle,
                  enabled: true,
                  maxLines: 1,
                  inputFormatters: [],
                  controller: _textController,
                  focusNode: _myFocusNode,
                  onFieldSubmitted: (command) {
                    _powerShellController.confirmStdIn(command);
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
