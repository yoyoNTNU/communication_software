import 'package:flutter/material.dart';
import 'package:proj/style.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Logo.png',
            width: 120,
            height: 120,
          ),
          Text(
            'ExpressMessage',
            textAlign: TextAlign.center,
            style: AppStyle.header(level: 2, color: AppStyle.blue),
          ),
        ],
      ),
    );
  }
}

class AppBox extends StatelessWidget {
  final String title;
  final Widget content;
  final VoidCallback? onClicked;
  final bool needLeftButton;
  const AppBox({
    super.key,
    required this.title,
    required this.content,
    this.onClicked,
    required this.needLeftButton,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppStyle.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: AppStyle.black.withOpacity(0.4),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              if (needLeftButton)
                GestureDetector(
                    onTap: () {
                      if (onClicked != null) {
                        onClicked!();
                      }
                    },
                    child: Image.asset(
                      'assets/icons/left.png',
                      width: 24,
                      height: 24,
                    )),
              Expanded(
                  child: Center(
                      child: Text(title,
                          style: AppStyle.header(
                              level: 2, color: AppStyle.gray.shade700)))),
              if (needLeftButton)
                const SizedBox(
                  width: 24,
                  height: 24,
                )
            ],
          ),
          const SizedBox(height: 24),
          content,
        ],
      ),
    );
  }
}

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? errorText;
  final String hintText;
  final bool isRequired;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;

  const AppTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.isRequired = false,
    this.errorText,
    this.onChanged,
    this.onTap,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.errorText == null) const SizedBox(height: 8),
        Row(
          children: [
            Text(
              widget.labelText,
              style: AppStyle.header(
                  level: 3,
                  // Set Color to blue if TextField is focused
                  color: _focusNode.hasFocus
                      ? AppStyle.blue[500]!
                      : AppStyle.gray.shade700,
                  weight: FontWeight.w400),
            ),
            if (widget.isRequired)
              Text(
                '*',
                style: AppStyle.header(
                    level: 3,
                    // Set Color to blue if TextField is focused
                    color: AppStyle.red,
                    weight: FontWeight.w400),
              ),
          ],
        ),
        const SizedBox(height: 4),
        TextField(
          keyboardType: TextInputType.emailAddress,
          controller: widget.controller,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          focusNode: _focusNode,
          style: AppStyle.body(
              level: 1, color: AppStyle.gray.shade900, weight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppStyle.body(level: 1, color: AppStyle.gray.shade500),
            filled: true,
            fillColor: AppStyle.white,
            contentPadding: const EdgeInsets.all(8),
            enabledBorder: OutlineInputBorder(
              borderSide: widget.errorText != null
                  ? const BorderSide(color: AppStyle.red, width: 1.0)
                  : const BorderSide(color: AppStyle.gray, width: 1.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppStyle.blue, width: 1.25),
            ),
          ),
        ),
        if (widget.errorText != null)
          Text(
            '※ 電子信箱錯誤或不存在 請重試',
            style: AppStyle.info(level: 1, color: AppStyle.red),
          )
        else
          const SizedBox(height: 9),
      ],
    );
  }
}
