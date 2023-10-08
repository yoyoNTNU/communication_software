part of 'group_widget.dart';

class PhotoBox extends StatefulWidget {
  final String title;
  final void Function(XFile?) onChanged;
  const PhotoBox({
    super.key,
    required this.title,
    required this.onChanged,
  });
  @override
  State<PhotoBox> createState() => _PhotoBoxState();
}

class _PhotoBoxState extends State<PhotoBox> {
  XFile? photo;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppStyle.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          title(widget.title),
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
          if (photo != null)
            Container(
              height: 192,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Image.file(
                File(photo!.path),
                fit: BoxFit.contain,
              ),
            ),
          if (photo != null)
            const SizedBox(
              height: 8,
            ),
          photo != null
              ? Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          final newPhoto = await photoSource(context);
                          if (newPhoto != null) {
                            if (checkFileType(newPhoto)) {
                              setState(() {
                                photo = newPhoto;
                                widget.onChanged(photo);
                              });
                              if (!context.mounted) return;
                              showSuccess(context, widget.title);
                            } else {
                              if (!context.mounted) return;
                              showFail(context, "\n檔案格式僅接受:jpg、jpeg、gif、png");
                            }
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
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset("assets/icons/img_box.png"),
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
                        onPressed: () {
                          setState(() {
                            photo = null;
                            widget.onChanged(photo);
                          });
                          if (!context.mounted) return;
                          showSuccess(context, widget.title);
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
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset("assets/icons/delete.png"),
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
                  onPressed: () async {
                    final newPhoto = await photoSource(context);
                    if (newPhoto != null) {
                      if (checkFileType(newPhoto)) {
                        setState(() {
                          photo = newPhoto;
                          widget.onChanged(photo);
                        });
                        if (!context.mounted) return;
                        showSuccess(context, widget.title);
                      } else {
                        if (!context.mounted) return;
                        showFail(context, "\n檔案格式僅接受:jpg、jpeg、gif、png");
                      }
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
                      SizedBox(
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