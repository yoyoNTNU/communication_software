import 'package:flutter/material.dart';
import 'package:proj/style.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

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
  final TextEditingController? controller2;
  final String labelText;
  final String hintText;
  final String? errorText;
  final bool isPassword;
  final bool isRequired;
  final bool isPhone;
  final String? additionText;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;

  const AppTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.controller2,
    this.isPassword = false,
    this.isRequired = false,
    this.isPhone = false,
    this.additionText,
    this.errorText,
    this.onChanged,
    this.onTap,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isObscure = true;
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
        Row(children: [
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
          const SizedBox(width: 8),
          if (widget.additionText != null)
            Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      widget.additionText!,
                      style:
                          AppStyle.info(level: 2, color: AppStyle.gray[500]!),
                    )))
        ]),
        const SizedBox(height: 4),
        if (widget.isPhone)
          InternationalPhoneNumberInput(
            countries: const [
              "TW",
              "CN",
              "JP",
              "US",
              "KP",
              "KR",
              "CA",
              "GB",
              "AU",
              "FR",
              "DE",
              "IN",
              "BR",
              "RU",
              "SG",
              "MN",
              "MY",
              "ID"
            ],
            initialValue: PhoneNumber(
              isoCode: 'TW',
            ),
            spaceBetweenSelectorAndTextField: 0,
            selectorTextStyle: AppStyle.body(
                level: 1,
                color: AppStyle.gray.shade900,
                weight: FontWeight.w500),
            onInputChanged: (PhoneNumber number) {
              widget.controller2!.text = number.dialCode!;
            },
            selectorConfig: const SelectorConfig(
              showFlags: true,
              setSelectorButtonAsPrefixIcon: false,
              selectorType: PhoneInputSelectorType.DIALOG,
            ),
            inputDecoration: InputDecoration(
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
            keyboardType: TextInputType.phone,
            textStyle: AppStyle.body(
                level: 1,
                color: AppStyle.gray.shade900,
                weight: FontWeight.w500),
            textFieldController: widget.controller,
            focusNode: _focusNode,
          ),
        if (!widget.isPhone)
          TextField(
            controller: widget.controller,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            focusNode: _focusNode,
            obscureText: widget.isPassword ? _isObscure : false,
            style: AppStyle.body(
                level: 1,
                color: AppStyle.gray.shade900,
                weight: FontWeight.w500),
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
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: _isObscure
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                      color: AppStyle.blue.shade400,
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    )
                  : null,
            ),
          ),
        if (widget.errorText != null)
          Text(
            '※ ${widget.errorText!}',
            style: AppStyle.info(level: 1, color: AppStyle.red),
          )
        else
          const SizedBox(height: 9),
      ],
    );
  }
}

class ErrorShow extends StatefulWidget {
  final List<String> mainType;
  final List<String> mainIcon;
  final List<List<String>> secType;
  final List<List<bool>> isPass;

  const ErrorShow({
    super.key,
    required this.mainType,
    required this.mainIcon,
    required this.secType,
    required this.isPass,
  });

  @override
  State<ErrorShow> createState() => _ErrorShowState();
}

class _ErrorShowState extends State<ErrorShow> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppStyle.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: AppStyle.gray,
            width: 2.0,
          ),
        ),
        child: Column(
          children: List.generate(4, (index1) {
            return Column(children: [
              MainLine(
                  icon: widget.mainIcon[index1], type: widget.mainType[index1]),
              Column(
                  children:
                      List.generate(widget.secType[index1].length, (index2) {
                return SecLine(
                    isPass: widget.isPass[index1][index2],
                    type: widget.secType[index1][index2]);
              }))
            ]);
          }),
        ));
  }
}

class MainLine extends StatelessWidget {
  final String icon;
  final String type;

  const MainLine({super.key, required this.icon, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          icon,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 8),
        Text(
          type,
          style: AppStyle.caption(),
        )
      ],
    );
  }
}

class SecLine extends StatelessWidget {
  final bool isPass;
  final String type;

  const SecLine({super.key, required this.isPass, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const SizedBox(
        width: 24,
        height: 24,
      ),
      isPass
          ? Image.asset(
              'assets/icons/pass.png',
              width: 24,
              height: 24,
            )
          : Image.asset(
              'assets/icons/not_pass.png',
              width: 24,
              height: 24,
            ),
      const SizedBox(width: 8),
      Text(
        type,
        textAlign: TextAlign.left,
        style: AppStyle.caption(
            color: isPass ? Colors.lightGreenAccent[400]! : AppStyle.red),
      ),
    ]);
  }
}
