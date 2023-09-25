import 'package:flutter/material.dart';
import 'package:proj/login/login_widget.dart';
import 'package:proj/style.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class PopEditPassword extends StatefulWidget {
  const PopEditPassword({super.key});

  @override
  State<PopEditPassword> createState() => _PopEditPasswordState();
}

class _PopEditPasswordState extends State<PopEditPassword> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent the dialog from being dismissed with the back button
        return false;
      },
      child: AlertDialog(
        content: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            width: 375,
            decoration: BoxDecoration(
              color: AppStyle.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(
                        child: Text(
                          '修改密碼',
                          style: AppStyle.header(),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        },
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset("assets/icons/X_blue.png"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                AppTextField(
                  key: UniqueKey(),
                  controller: _oldPasswordController,
                  isPassword: true,
                  labelText: '驗證舊密碼',
                  hintText: '請輸入舊密碼',
                  onTap: () {
                    _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
                ),
                AppTextField(
                  key: UniqueKey(),
                  controller: _newPasswordController,
                  isPassword: true,
                  labelText: '設定新密碼',
                  hintText: '請輸入新密碼',
                  onTap: () {
                    _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
                ),
                AppTextField(
                  key: UniqueKey(),
                  controller: _confirmPassController,
                  isPassword: true,
                  labelText: '驗證新密碼',
                  hintText: '請輸入新密碼',
                  onTap: () {
                    _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      // : () async {
                      //     setState(() {
                      //       _isLoading = true;
                      //     });
                      //     await _sentResetEmail(_emailController.text);
                      //     _sentSuccessOrFail();
                      //   },
                      : () {
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        },
                  style: AppStyle.primaryBtn(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppStyle.white,
                              ))
                          : SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset("assets/icons/Save.png"),
                            ),
                      const SizedBox(width: 8),
                      const Text("儲存修改"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PopEditName extends StatefulWidget {
  const PopEditName({super.key});

  @override
  State<PopEditName> createState() => _PopEditNameState();
}

class _PopEditNameState extends State<PopEditName> {
  final _nameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent the dialog from being dismissed with the back button
        return false;
      },
      child: AlertDialog(
        content: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            width: 375,
            decoration: BoxDecoration(
              color: AppStyle.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(
                        child: Text(
                          '修改使用者名稱',
                          style: AppStyle.header(),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        },
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset("assets/icons/X_blue.png"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                AppTextField(
                  key: UniqueKey(),
                  controller: _nameController,
                  isPassword: false,
                  labelText: '使用者名稱',
                  hintText: '請輸入使用者名稱',
                  onTap: () {
                    _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      // : () async {
                      //     setState(() {
                      //       _isLoading = true;
                      //     });
                      //     await _sentResetEmail(_emailController.text);
                      //     _sentSuccessOrFail();
                      //   },
                      : () {
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        },
                  style: AppStyle.primaryBtn(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppStyle.white,
                              ))
                          : SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset("assets/icons/Save.png"),
                            ),
                      const SizedBox(width: 8),
                      const Text("儲存修改"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PopEditIntro extends StatefulWidget {
  const PopEditIntro({super.key});

  @override
  State<PopEditIntro> createState() => _PopEditIntroState();
}

class _PopEditIntroState extends State<PopEditIntro> {
  final _introController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent the dialog from being dismissed with the back button
        return false;
      },
      child: AlertDialog(
        content: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            width: 375,
            decoration: BoxDecoration(
              color: AppStyle.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(
                        child: Text(
                          '修改個性簽名',
                          style: AppStyle.header(),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        },
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset("assets/icons/X_blue.png"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                AppTextField(
                  key: UniqueKey(),
                  controller: _introController,
                  isPassword: false,
                  labelText: '個性簽名',
                  hintText: '請輸入個性簽名',
                  onTap: () {
                    _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      // : () async {
                      //     setState(() {
                      //       _isLoading = true;
                      //     });
                      //     await _sentResetEmail(_emailController.text);
                      //     _sentSuccessOrFail();
                      //   },
                      : () {
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        },
                  style: AppStyle.primaryBtn(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppStyle.white,
                              ))
                          : SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset("assets/icons/Save.png"),
                            ),
                      const SizedBox(width: 8),
                      const Text("儲存修改"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PopEditBD extends StatefulWidget {
  const PopEditBD({super.key});

  @override
  State<PopEditBD> createState() => _PopEditBDState();
}

class _PopEditBDState extends State<PopEditBD> {
  final _bdController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent the dialog from being dismissed with the back button
        return false;
      },
      child: AlertDialog(
        content: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            width: 375,
            decoration: BoxDecoration(
              color: AppStyle.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(
                        child: Text(
                          '修改生日資訊',
                          style: AppStyle.header(),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        },
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset("assets/icons/X_blue.png"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                AppTextField(
                  key: UniqueKey(),
                  controller: _bdController,
                  isPassword: false,
                  labelText: '生日',
                  hintText: '請選擇出生日期',
                  onTap: () async {
                    var result = await showCalendarDatePicker2Dialog(
                      context: context,
                      config: CalendarDatePicker2WithActionButtonsConfig(
                        firstDayOfWeek: 0,
                        firstDate: DateTime(1945),
                        lastDate: DateTime.now(),
                        currentDate: DateTime.now(),
                        weekdayLabelTextStyle: AppStyle.header(),
                        //customModePickerIcon: Text("v"),//向下展開icon
                        controlsTextStyle: AppStyle.header(),
                        dayTextStyle: AppStyle.header(),
                        selectedDayTextStyle:
                            AppStyle.header(color: AppStyle.blue[50]!),
                        selectedDayHighlightColor: AppStyle.blue,
                        disabledDayTextStyle:
                            AppStyle.header(color: AppStyle.gray),
                        todayTextStyle:
                            (DateTime.now().weekday == DateTime.saturday ||
                                    DateTime.now().weekday == DateTime.sunday)
                                ? AppStyle.header(color: AppStyle.red)
                                : AppStyle.header(),
                        yearTextStyle: AppStyle.header(),
                        selectedYearTextStyle:
                            AppStyle.header(color: AppStyle.blue[50]!),
                        centerAlignModePicker: true,
                        dayBorderRadius: BorderRadius.circular(100),
                        yearBorderRadius: BorderRadius.circular(4),
                        dayTextStylePredicate: ({required date}) {
                          TextStyle? textStyle;
                          if (date.weekday == DateTime.saturday ||
                              date.weekday == DateTime.sunday) {
                            textStyle = AppStyle.header(color: AppStyle.red);
                          }
                          return textStyle;
                        },
                        cancelButton: Text(
                          "清空",
                          style: AppStyle.header(color: AppStyle.red),
                        ),
                        okButton: Text(
                          "確定",
                          style: AppStyle.header(color: AppStyle.blue),
                        ),
                      ),
                      dialogSize: const Size(325, 400),
                      borderRadius: BorderRadius.circular(8),
                      dialogBackgroundColor: AppStyle.blue[50]!,
                    );

                    setState(() {
                      _bdController.text = (result == null || result.isEmpty)
                          ? ""
                          : (() {
                              String formattedDate =
                                  '${result[0]!.year}/${result[0]!.month.toString().padLeft(2, '0')}/${result[0]!.day.toString().padLeft(2, '0')}';
                              return formattedDate;
                            })();
                    });
                  },
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      // : () async {
                      //     setState(() {
                      //       _isLoading = true;
                      //     });
                      //     await _sentResetEmail(_emailController.text);
                      //     _sentSuccessOrFail();
                      //   },
                      : () {
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        },
                  style: AppStyle.primaryBtn(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppStyle.white,
                              ))
                          : SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset("assets/icons/Save.png"),
                            ),
                      const SizedBox(width: 8),
                      const Text("儲存修改"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
