part of 'edit_page_pop_widget.dart';

class PopEditIntro extends StatefulWidget {
  const PopEditIntro({super.key});

  @override
  State<PopEditIntro> createState() => _PopEditIntroState();
}

class _PopEditIntroState extends State<PopEditIntro> {
  final _introController = TextEditingController();
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
                          '修改個性簽名',
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
                      : () async {
                          await _setInfo(intro: _introController.text);
                          if (_responseCode == 200) {
                            if (!context.mounted) return;
                            Navigator.of(context).pop(_introController.text);
                            showSuccess(context, "個性簽名");
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
