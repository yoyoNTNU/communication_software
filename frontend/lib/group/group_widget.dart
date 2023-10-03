import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proj/style.dart';
import 'package:proj/widget.dart';

class StepProgressIndicator extends StatefulWidget {
  final int currentStep;

  const StepProgressIndicator({
    super.key,
    required this.currentStep,
  });

  @override
  State<StepProgressIndicator> createState() => _StepProgressIndicatorState();
}

class _StepProgressIndicatorState extends State<StepProgressIndicator> {
  int stepCircle = 0;
  int stepLine = 0;
  @override
  Widget build(BuildContext context) {
    if (stepCircle == 1 && stepCircle != widget.currentStep) {
      setState(() {
        stepCircle = widget.currentStep;
      });
    }
    if (stepLine == 0 && stepLine != widget.currentStep) {
      setState(() {
        stepLine = widget.currentStep;
      });
    }
    return SizedBox(
      height: 46,
      width: 223,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppStyle.teal,
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: 144,
                    height: 5,
                    color: AppStyle.gray,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: stepLine == 0 ? 0 : 144,
                    height: 5,
                    color: AppStyle.teal,
                    onEnd: () {
                      if (stepCircle == 0) {
                        setState(() {
                          stepCircle = widget.currentStep;
                        });
                      }
                    },
                  )
                ],
              ),
              AnimatedContainer(
                width: 16,
                height: 16,
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: stepCircle == 0 ? AppStyle.gray : AppStyle.teal,
                ),
                onEnd: () {
                  if (stepLine == 1) {
                    setState(() {
                      stepLine = widget.currentStep;
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "選擇成員",
                style: AppStyle.caption(color: AppStyle.teal),
              ),
              Text(
                "編輯資料",
                style: AppStyle.caption(
                    color: stepCircle == 1 ? AppStyle.teal : AppStyle.gray),
              )
            ],
          )
        ],
      ),
    );
  }
}

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function()? onTapX;

  const AppTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.onTapX,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      focusNode: _focusNode,
      style: AppStyle.body(
          level: 1, color: AppStyle.gray.shade900, weight: FontWeight.w500),
      decoration: InputDecoration(
        prefixIcon: Image.asset("assets/icons/Search.png"),
        suffixIcon: widget.controller.text != ""
            ? IconButton(
                splashRadius: 12,
                icon: Image.asset("assets/icons/X_blue.png"),
                onPressed: () {
                  setState(() {
                    widget.controller.text = "";
                    widget.onTapX!();
                  });
                },
              )
            : null,
        hintStyle: AppStyle.body(level: 1, color: AppStyle.gray.shade500),
        filled: true,
        fillColor: AppStyle.white,
        contentPadding: const EdgeInsets.all(8),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppStyle.gray, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppStyle.blue, width: 1.25),
        ),
      ),
    );
  }
}

class MemberCard extends StatefulWidget {
  final int id;
  final String? avatar;
  final String name;
  final bool check;
  final void Function() onTap;

  const MemberCard({
    super.key,
    required this.id,
    required this.avatar,
    required this.name,
    required this.check,
    required this.onTap,
  });
  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          height: 72,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: AppStyle.white),
          child: Row(
            children: [
              Container(
                width: 48,
                padding: const EdgeInsets.only(left: 24),
                child: widget.check
                    ? Image.asset("assets/icons/select.png")
                    : Image.asset("assets/icons/unselect.png"),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(children: [
                  ClipOval(
                      child: widget.avatar != null
                          ? Image.network(
                              widget.avatar!,
                              width: 48,
                              height: 48,
                            )
                          : Image.asset('assets/images/Avatar.png')),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    widget.name,
                    style: AppStyle.header(level: 2),
                  )
                ]),
              )
            ],
          )),
    );
  }
}

Widget title(String text) {
  return SizedBox(
    width: double.infinity,
    child: Text(
      text,
      style: AppStyle.header(color: AppStyle.gray[700]!),
      textAlign: TextAlign.left,
    ),
  );
}

Widget unitLine(String key, TextEditingController controller) {
  final FocusNode focusNode = FocusNode();
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
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          style: AppStyle.body(
              level: 1, color: AppStyle.gray.shade900, weight: FontWeight.w500),
          decoration: InputDecoration(
            hintStyle: AppStyle.body(level: 1, color: AppStyle.gray.shade500),
            filled: true,
            fillColor: AppStyle.white,
            contentPadding: const EdgeInsets.all(8),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppStyle.gray, width: 1.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppStyle.blue, width: 1.25),
            ),
          ),
        ),
      )
    ]),
  );
}

class PhotoBox extends StatefulWidget {
  final String title;
  const PhotoBox({
    super.key,
    required this.title,
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

bool checkFileType(XFile file) {
  String filePath = file.path;
  String fileExtension = filePath.split('.').last.toLowerCase();

  if (fileExtension == 'jpg' ||
      fileExtension == 'jpeg' ||
      fileExtension == 'png' ||
      fileExtension == 'gif') {
    return true;
  } else {
    return false;
  }
}
