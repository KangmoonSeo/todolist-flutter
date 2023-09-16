import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rotating_icon_button/rotating_icon_button.dart';
import 'package:todolist/services/todo_serivce.dart';

class SettingWidget extends StatefulWidget {
  final Function buildScreen;
  const SettingWidget({super.key, required this.buildScreen});

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  void copyBackup() {
    final String str = TodoService.getBackupData();

    Clipboard.setData(ClipboardData(text: str));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Code copied to your Clipboard."),
        duration: Duration(seconds: 5),
      ),
    );
  }

  final TextEditingController _textController = TextEditingController();

  void restoreData() {
    if (TodoService.setDataByBackupCode(_textController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Restore Completed"),
          duration: Duration(seconds: 5),
        ),
      );
      widget.buildScreen();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Warning! Please check your backup code."),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  void onBackupTap() {
    _textController.text = "";
    showDialog(
        context: context,
        builder: ((context) => Scaffold(
              backgroundColor: Colors.transparent,
              body: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(context).pop(),
                child: GestureDetector(
                  child: AlertDialog(
                    title: Text(
                      "Backup and Restore",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    backgroundColor:
                        Theme.of(context).appBarTheme.backgroundColor,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          children: [
                            Text(
                              "A One-Time Backup code is created and saved to the clipboard.",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: copyBackup,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.green.withOpacity(0.8), // 초록색 버튼
                              ),
                              child: const Text(
                                "Copy Backup Code",
                                style: TextStyle(
                                    backgroundColor: Colors.transparent),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Column(
                          children: [
                            Text(
                              "Enter the Backup code and click Restore button.",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _textController,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 1,
                                    ),
                                  ),
                                  hintText: "Paste Code Here!",
                                  hintStyle: TextStyle(
                                      color: Theme.of(context).primaryColor)),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: restoreData,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.green.withOpacity(0.8), // 초록색 버튼
                              ),
                              child: const Text(
                                "Restore",
                                style: TextStyle(
                                    backgroundColor: Colors.transparent),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }

  void onResetTap() {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: const Text("Confirmation"),
              content: const Text("Really want to reset your data?"),
              actions: [
                TextButton(
                  onPressed: () {
                    TodoService.clearData();
                    widget.buildScreen();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(backgroundColor: Colors.transparent),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "No",
                    style: TextStyle(backgroundColor: Colors.transparent),
                  ),
                ),
              ],
            )));
  }

  void onSettingTap() {
    showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: Text(
              "Setting",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            content: SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Backup & Restore",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      ElevatedButton(
                        onPressed: onBackupTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.green.withOpacity(0.8), // 초록색 버튼
                        ),
                        child: const Text(
                          "Backup and Restore",
                          style: TextStyle(backgroundColor: Colors.transparent),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Delete All Data",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      ElevatedButton(
                        onPressed: onResetTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.red.withOpacity(0.8), // 빨간색 버튼
                        ),
                        child: const Text(
                          "Reset App",
                          style: TextStyle(backgroundColor: Colors.transparent),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RotatingIconButton(
      onTap: onSettingTap,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      background: Colors.transparent,
      elevation: 10,
      child: const Icon(
        Icons.settings,
        size: 30,
      ),
    );
  }
}
