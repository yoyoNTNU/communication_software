part of 'edit_page_widget.dart';

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
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final int responseCode = await SetDetailAPI.modifyPhoto(
          avatar: avatar, background: background);
      if (!mounted) return;
      setState(() {
        _responseCode = responseCode;
      });
    } catch (e) {
      print('API request error: $e');
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _deletePhoto() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final int responseCode = await SetDetailAPI.removeBackground();
      if (!mounted) return;
      setState(() {
        _responseCode = responseCode;
      });
    } catch (e) {
      print('API request error: $e');
    }
    if (!mounted) return;
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
                                  if (!mounted) return;
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
                                if (!mounted) return;
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
                            if (!mounted) return;
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
