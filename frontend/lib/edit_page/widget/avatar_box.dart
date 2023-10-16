part of 'edit_page_widget.dart';

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