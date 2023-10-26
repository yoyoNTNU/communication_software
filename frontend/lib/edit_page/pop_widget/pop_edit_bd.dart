part of 'edit_page_pop_widget.dart';

class PopEditBD extends StatefulWidget {
  const PopEditBD({super.key});

  @override
  State<PopEditBD> createState() => _PopEditBDState();
}

class _PopEditBDState extends State<PopEditBD> {
  final _bdController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _responseCode = 400;

  Future<void> _setInfo(
      {String? name,
      String? birthday,
      String? intro,
      String? isLoginMail}) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final int responseCode = await SetDetailAPI.modifyInfo(
          name: name,
          birthday: birthday,
          intro: intro,
          isLoginMail: isLoginMail);
      setState(() {
        _responseCode = responseCode;
      });
    } catch (e) {
      print('API request error: $e');
    }
    setState(() {
      _isLoading = false;
    });
  }

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
                        onTap: _isLoading
                            ? null
                            : () {
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
                        weekdayLabelTextStyle: AppStyle.header(level: 2),
                        controlsTextStyle: AppStyle.header(level: 2),
                        dayTextStyle: AppStyle.body(),
                        selectedDayTextStyle: AppStyle.header(level: 2),
                        selectedDayHighlightColor: AppStyle.yellow,
                        disabledDayTextStyle:
                            AppStyle.body(color: AppStyle.gray),
                        todayTextStyle:
                            AppStyle.header(level: 2, color: AppStyle.blue),
                        yearTextStyle: AppStyle.header(level: 2),
                        selectedYearTextStyle: AppStyle.header(level: 2),
                        centerAlignModePicker: true,
                        dayBorderRadius: BorderRadius.circular(100),
                        yearBorderRadius: BorderRadius.circular(4),
                        dayTextStylePredicate: ({required date}) {
                          if (date.weekday == DateTime.saturday ||
                              date.weekday == DateTime.sunday) {
                            return AppStyle.body(color: AppStyle.teal);
                          }
                          return AppStyle.body();
                        },
                        cancelButton: SizedBox(
                          width: 130,
                          child: Text(
                            "清空日期",
                            style: AppStyle.caption(color: AppStyle.gray),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        okButton: SizedBox(
                          width: 130,
                          child: Text(
                            "確定日期",
                            style: AppStyle.caption(color: AppStyle.teal),
                            textAlign: TextAlign.center,
                          ),
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
                      : () async {
                          await _setInfo(birthday: _bdController.text);
                          if (_responseCode == 200) {
                            if (!context.mounted) return;
                            Navigator.of(context).pop(_bdController.text);
                            showSuccess(context, "生日");
                          } else {
                            if (!context.mounted) return;
                            Navigator.of(context).pop();
                            showFail(context, "發生非預期錯誤，請回報相關人員");
                          }
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
