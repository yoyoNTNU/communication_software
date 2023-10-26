part of 'edit_page_pop_widget.dart';

class PopEditName extends StatefulWidget {
  const PopEditName({super.key});

  @override
  State<PopEditName> createState() => _PopEditNameState();
}

class _PopEditNameState extends State<PopEditName> {
  final _nameController = TextEditingController();
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
                          '修改使用者名稱',
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
                      : () async {
                          await _setInfo(name: _nameController.text);
                          if (_responseCode == 200) {
                            if (!context.mounted) return;
                            Navigator.of(context).pop(_nameController.text);
                            showSuccess(context, "使用者名稱");
                          } else {
                            if (!context.mounted) return;
                            Navigator.of(context).pop();
                            showFail(context, "使用者名稱不可為空");
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
