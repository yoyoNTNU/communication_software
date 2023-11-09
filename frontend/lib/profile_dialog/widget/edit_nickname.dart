part of 'profile_dialog_widget.dart';

class EditNickname extends StatefulWidget {
  final int friendID;
  const EditNickname({super.key, required this.friendID});

  @override
  State<EditNickname> createState() => _EditNicknameState();
}

class _EditNicknameState extends State<EditNickname> {
  final _nameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _responseCode = 400;

  Future<void> _setInfo(int friendID, String name) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final int responseCode = await FriendAPI.updateNickname(friendID, name);
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

  Future<void> _getName(int friendID) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final String name = await FriendAPI.getFriendOriginName(friendID);
      setState(() {
        _nameController.text = name;
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
                          '修改暱稱',
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
                          child: Image.asset("assets/icons/x_blue.png"),
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
                  labelText: '好友暱稱',
                  hintText: '請輸入好友暱稱',
                  onTap: () {
                    _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                              await _setInfo(
                                  widget.friendID, _nameController.text);
                              if (_responseCode == 200) {
                                if (!context.mounted) return;
                                Navigator.of(context).pop(_nameController.text);
                              } else {
                                if (!context.mounted) return;
                                Navigator.of(context).pop(null);
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
                                  child: Image.asset("assets/icons/save.png"),
                                ),
                          const SizedBox(width: 8),
                          const Text("儲存修改"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    OutlinedButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                              await _getName(widget.friendID);
                            },
                      style: AppStyle.secondaryBtn(),
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
                                  child:
                                      Image.asset("assets/icons/refresh_2.png"),
                                ),
                          const SizedBox(width: 8),
                          const Text("重置名稱"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
