import 'package:flutter/material.dart';
import 'package:proj/main.dart';
import 'package:proj/style.dart';
import 'package:proj/edit_page/edit_page_pop_widget.dart';
import 'package:proj/edit_page/edit_page_api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:path/path.dart' as path;
import 'package:proj/widget.dart';

Widget unitLine(String key, String value, [VoidCallback? onPress]) {
  return Container(
    padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
    height: 44,
    child: Row(children: [
      SizedBox(
        width: 96,
        child: Text(
          key,
          style: AppStyle.header(level: 3, color: AppStyle.gray[700]!),
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: AppStyle.body(color: AppStyle.gray[500]!),
        ),
      ),
      if (onPress != null)
        TextButton(
          style: AppStyle.textBtn(),
          onPressed: onPress,
          child: const Text(
            '修改',
          ),
        ),
    ]),
  );
}

Widget title(String text, [String? tips, BuildContext? context]) {
  TextStyle linkStyle = TextStyle(
    color: AppStyle.blue[200]!,
    fontSize: 12,
    fontFamily: 'NotoSansTC',
    fontWeight: FontWeight.w300,
    letterSpacing: 0.4,
    decoration: TextDecoration.underline,
    decorationColor: AppStyle.blue[200]!,
  );
  TapGestureRecognizer tapDirect;
  if (tips != null && context != null) {
    tapDirect = TapGestureRecognizer()
      ..onTap = () {
        //TODO 改為回報問題頁面
        Navigator.pushNamed(context, '/home');
      };
  } else {
    tapDirect = TapGestureRecognizer()..onTap = () {};
  }
  return tips == null
      ? SizedBox(
          width: double.infinity,
          child: Text(
            text,
            style: AppStyle.header(color: AppStyle.gray[700]!),
            textAlign: TextAlign.left,
          ),
        )
      : Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: AppStyle.header(color: AppStyle.gray[700]!),
                textAlign: TextAlign.left,
              ),
            ),
            Tooltip(
                triggerMode: TooltipTriggerMode.tap,
                showDuration: const Duration(seconds: 10),
                richMessage: TextSpan(children: [
                  TextSpan(
                      text: "$tips無法修改\n若需修改請至 ",
                      style: AppStyle.info(color: AppStyle.white)),
                  TextSpan(
                    text: '回報問題',
                    style: linkStyle,
                    recognizer: tapDirect,
                  ),
                  TextSpan(
                      text: " 提出修改申請",
                      style: AppStyle.info(color: AppStyle.white)),
                ]),
                child: Image.asset("assets/icons/Tips.png")),
          ],
        );
}

Widget accountBox(BuildContext context, String? userID) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    decoration: BoxDecoration(
      color: AppStyle.white,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      children: [
        title("帳戶資料", "用戶ID", context),
        const SizedBox(
          height: 12,
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: AppStyle.gray[100],
        ),
        const SizedBox(
          height: 8,
        ),
        unitLine("用戶密碼", "***********", () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const PopEditPassword(),
          );
        }),
        const SizedBox(
          height: 8,
        ),
        unitLine(
          "用戶ID",
          userID ?? "",
        ),
      ],
    ),
  );
}

Widget infoBox(BuildContext context, String? birthday, String? name,
    String? intro, Function(String, String) update) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    decoration: BoxDecoration(
      color: AppStyle.white,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      children: [
        title("個人資料"),
        const SizedBox(
          height: 12,
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: AppStyle.gray[100],
        ),
        const SizedBox(
          height: 8,
        ),
        unitLine("使用者名稱", name ?? "", () async {
          final temp = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const PopEditName(),
          );
          if (temp != null) {
            update("name", temp);
          }
        }),
        const SizedBox(
          height: 8,
        ),
        unitLine("個性簽名", intro ?? "", () async {
          final temp = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const PopEditIntro(),
          );
          if (temp != null) {
            update("intro", temp);
          }
        }),
        const SizedBox(
          height: 8,
        ),
        unitLine(
            "生日",
            (birthday == null || birthday == "")
                ? "未設定"
                : birthday.replaceAll('-', ' / '), () async {
          final temp = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const PopEditBD(),
          );
          if (temp != null) {
            update("birthday", temp);
          }
        }),
      ],
    ),
  );
}

Widget communityBox(BuildContext context, String? email, String? phone) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    decoration: BoxDecoration(
      color: AppStyle.white,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      children: [
        title("通訊資料", "通訊資料", context),
        const SizedBox(
          height: 12,
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: AppStyle.gray[100],
        ),
        const SizedBox(
          height: 8,
        ),
        unitLine(
          "電子郵件",
          email ?? "",
        ),
        const SizedBox(
          height: 8,
        ),
        unitLine(
          "手機號碼",
          phone ?? "",
        ),
      ],
    ),
  );
}

class AvatarBox extends StatefulWidget {
  final String? avatar;
  final int id;
  const AvatarBox({
    super.key,
    required this.id,
    this.avatar,
  });
  @override
  State<AvatarBox> createState() => _AvatarBoxState();
}

class _AvatarBoxState extends State<AvatarBox> {
  bool _isLoading = false;
  int _responseCode = 400;
  String? copyAvatar;

  Future<void> _setPhoto({XFile? avatar, XFile? background}) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final int responseCode = await SetDetailAPI.modifyPhoto(
          avatar: avatar, background: background);
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

  Future<void> _deletePhoto() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final int responseCode = await SetDetailAPI.removeAvatar();
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

  int step = 0;
  @override
  Widget build(BuildContext context) {
    if (step == 1) {
      setState(() {
        copyAvatar = widget.avatar;
      });
    }
    ++step;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppStyle.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          title("個人頭像"),
          const SizedBox(
            height: 12,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: AppStyle.gray[100],
          ),
          const SizedBox(
            height: 8,
          ),
          if (copyAvatar != null)
            Container(
              height: 192,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Image.network(
                copyAvatar!,
                errorBuilder: (context, error, stackTrace) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.popAndPushNamed(context, '/edit');
                  });
                  return const SizedBox();
                },
                fit: BoxFit.contain,
              ),
            ),
          if (copyAvatar != null)
            const SizedBox(
              height: 8,
            ),
          copyAvatar != null
              ? Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                final avatar = await photoSource(context);
                                if (avatar != null) {
                                  await _setPhoto(avatar: avatar);
                                }
                                if (_responseCode == 200 && avatar != null) {
                                  String normalizedPath =
                                      path.normalize(avatar.path);
                                  List<String> parts =
                                      path.split(normalizedPath);
                                  setState(() {
                                    copyAvatar =
                                        "$imgPath/member/photo/${widget.id}/${parts.last}";
                                  });
                                  if (!context.mounted) return;
                                  showSuccess(context, "個人頭像");
                                } else if (avatar == null) {
                                } else {
                                  if (!context.mounted) return;
                                  showFail(
                                      context, "\n檔案格式僅接受:jpg、jpeg、gif、png");
                                }
                              },
                        style: AppStyle.secondaryBtn().copyWith(
                          minimumSize: MaterialStateProperty.all<Size>(
                            const Size(95, 40),
                          ),
                        ),
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
                                        Image.asset("assets/icons/img_box.png"),
                                  ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text("修改相片")
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                await _deletePhoto();
                                setState(() {
                                  copyAvatar = null;
                                });
                                if (!context.mounted) return;
                                showSuccess(context, "個人頭像");
                              },
                        style: AppStyle.dangerBtn().copyWith(
                          minimumSize: MaterialStateProperty.all<Size>(
                            const Size(95, 40),
                          ),
                        ),
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
                                        Image.asset("assets/icons/delete.png"),
                                  ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text("移除")
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : OutlinedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          final avatar = await photoSource(context);
                          if (avatar != null) {
                            await _setPhoto(avatar: avatar);
                          }
                          if (_responseCode == 200 && avatar != null) {
                            String normalizedPath = path.normalize(avatar.path);
                            List<String> parts = path.split(normalizedPath);
                            setState(() {
                              copyAvatar =
                                  "$imgPath/member/photo/${widget.id}/${parts.last}";
                            });
                            if (!context.mounted) return;
                            showSuccess(context, "個人頭像");
                          } else if (avatar == null) {
                          } else {
                            if (!context.mounted) return;
                            showFail(context, "\n檔案格式僅接受:jpg、jpeg、gif、png");
                          }
                        },
                  style: AppStyle.secondaryBtn().copyWith(
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(160, 40),
                    ),
                  ),
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
                              child: Image.asset("assets/icons/img_box.png"),
                            ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text("選擇相片")
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class BackgroundBox extends StatefulWidget {
  final String? background;
  final int id;
  const BackgroundBox({
    super.key,
    required this.id,
    this.background,
  });
  @override
  State<BackgroundBox> createState() => _BackgroundBoxState();
}

class _BackgroundBoxState extends State<BackgroundBox> {
  bool _isLoading = false;
  int _responseCode = 400;
  String? copyBackground;

  Future<void> _setPhoto({XFile? avatar, XFile? background}) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final int responseCode = await SetDetailAPI.modifyPhoto(
          avatar: avatar, background: background);
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

  Future<void> _deletePhoto() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final int responseCode = await SetDetailAPI.removeBackground();
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

  int step = 0;
  @override
  Widget build(BuildContext context) {
    if (step == 1) {
      setState(() {
        copyBackground = widget.background;
      });
    }
    ++step;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppStyle.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          title("背景相片"),
          const SizedBox(
            height: 12,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: AppStyle.gray[100],
          ),
          const SizedBox(
            height: 8,
          ),
          if (copyBackground != null)
            Container(
              height: 192,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Image.network(
                copyBackground!,
                errorBuilder: (context, error, stackTrace) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.popAndPushNamed(context, '/edit');
                  });
                  return const SizedBox();
                },
                fit: BoxFit.contain,
              ),
            ),
          if (copyBackground != null)
            const SizedBox(
              height: 8,
            ),
          copyBackground != null
              ? Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                final background = await photoSource(context);
                                if (background != null) {
                                  await _setPhoto(background: background);
                                }
                                if (_responseCode == 200 &&
                                    background != null) {
                                  String normalizedPath =
                                      path.normalize(background.path);
                                  List<String> parts =
                                      path.split(normalizedPath);
                                  setState(() {
                                    copyBackground =
                                        "$imgPath/member/background/${widget.id}/${parts.last}";
                                  });
                                  if (!context.mounted) return;
                                  showSuccess(context, "背景相片");
                                } else if (background == null) {
                                } else {
                                  if (!context.mounted) return;
                                  showFail(
                                      context, "\n檔案格式僅接受:jpg、jpeg、gif、png");
                                }
                              },
                        style: AppStyle.secondaryBtn().copyWith(
                          minimumSize: MaterialStateProperty.all<Size>(
                            const Size(95, 40),
                          ),
                        ),
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
                                        Image.asset("assets/icons/img_box.png"),
                                  ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text("修改相片")
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                await _deletePhoto();
                                setState(() {
                                  copyBackground = null;
                                });
                                if (!context.mounted) return;
                                showSuccess(context, "背景相片");
                              },
                        style: AppStyle.dangerBtn().copyWith(
                          minimumSize: MaterialStateProperty.all<Size>(
                            const Size(95, 40),
                          ),
                        ),
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
                                        Image.asset("assets/icons/delete.png"),
                                  ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text("移除")
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : OutlinedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          final background = await photoSource(context);
                          if (background != null) {
                            await _setPhoto(background: background);
                          }
                          if (_responseCode == 200 && background != null) {
                            String normalizedPath =
                                path.normalize(background.path);
                            List<String> parts = path.split(normalizedPath);
                            setState(() {
                              copyBackground =
                                  "$imgPath/member/background/${widget.id}/${parts.last}";
                            });
                            if (!context.mounted) return;
                            showSuccess(context, "背景相片");
                          } else if (background == null) {
                          } else {
                            if (!context.mounted) return;
                            showFail(context, "\n檔案格式僅接受:jpg、jpeg、gif、png");
                          }
                        },
                  style: AppStyle.secondaryBtn().copyWith(
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(160, 40),
                    ),
                  ),
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
                              child: Image.asset("assets/icons/img_box.png"),
                            ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text("選擇相片")
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

void showSuccess(BuildContext context, String? type) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        '編輯$type成功，資訊已更新',
        style: AppStyle.body(color: AppStyle.white),
      ),
      duration: const Duration(milliseconds: 1500),
    ),
  );
}

void showFail(BuildContext context, String? hintText) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        "修改失敗，請再試一次 提醒您：$hintText",
        style: AppStyle.body(color: AppStyle.white),
      ),
      duration: const Duration(milliseconds: 1500),
    ),
  );
}
