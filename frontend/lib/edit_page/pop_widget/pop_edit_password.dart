part of 'edit_page_pop_widget.dart';

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
  int _responseCode = 400;

  Future<void> _setPwd(String oldPwd, String newPed, String confirmPwd) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final int responseCode =
          await SetDetailAPI.modifyPwd(oldPwd, newPed, confirmPwd);
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
                      : () async {
                          await _setPwd(
                              _oldPasswordController.text,
                              _newPasswordController.text,
                              _confirmPassController.text);
                          if (_responseCode == 200) {
                            if (!context.mounted) return;
                            Navigator.of(context).pop();
                            showSuccess(context, "使用者密碼");
                          } else {
                            if (!context.mounted) return;
                            Navigator.of(context).pop();
                            showFail(context,
                                "\n密碼需6~24位大小寫英數組合而成，\n同時請確認舊密碼輸入正確及兩次新密碼輸入一致");
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
