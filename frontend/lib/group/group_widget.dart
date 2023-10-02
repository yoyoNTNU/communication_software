import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:proj/style.dart';

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

  const MemberCard({
    super.key,
    required this.id,
    required this.avatar,
    required this.name,
  });
  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          check = !check;
        });
      },
      child: Container(
          height: 72,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: AppStyle.white),
          child: Row(
            children: [
              Container(
                width: 48,
                padding: const EdgeInsets.only(left: 24),
                child: check
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
