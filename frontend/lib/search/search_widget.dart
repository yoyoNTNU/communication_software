import 'package:flutter/material.dart';
import 'package:proj/style.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Switcher extends StatefulWidget {
  final void Function(bool) onChanged;

  const Switcher({
    super.key,
    required this.onChanged,
  });

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  bool _isChecked = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch.size(
      animationDuration: const Duration(milliseconds: 300),
      style: ToggleStyle(
          backgroundColor: AppStyle.white,
          borderRadius: BorderRadius.circular(8),
          indicatorColor: AppStyle.teal,
          borderColor: AppStyle.teal),
      indicatorSize: const Size(111, 28),
      iconBuilder: (bool value) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value ? '手機號碼' : '用戶ID',
              style: value
                  ? _isChecked
                      ? AppStyle.caption(color: AppStyle.white)
                      : AppStyle.caption(color: AppStyle.teal)
                  : _isChecked
                      ? AppStyle.caption(color: AppStyle.teal)
                      : AppStyle.caption(color: AppStyle.white),
            ),
          ],
        );
      },
      selectedIconScale: 1,
      height: 28,
      borderWidth: 1,
      iconOpacity: 1,
      selectedIconOpacity: 1,
      current: _isChecked,
      onChanged: (value) {
        widget.onChanged(value);
        setState(() {
          _isChecked = value;
        });
      },
      values: const [true, false],
    );
  }
}

class IDTextField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const IDTextField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  State<IDTextField> createState() => _IDTextFieldState();
}

class _IDTextFieldState extends State<IDTextField> {
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
      textInputAction: TextInputAction.search,
      controller: widget.controller,
      onChanged: widget.onChanged,
      onSubmitted: (value) {
        print(123);
        FocusScope.of(context).unfocus();
      },
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
                  });
                },
              )
            : null,
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

class PhoneTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController controller2;
  final void Function(String) onChanged;

  const PhoneTextField({
    super.key,
    required this.controller,
    required this.controller2,
    required this.onChanged,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
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
          level: 1, color: AppStyle.gray.shade900, weight: FontWeight.w500),
      onInputChanged: (PhoneNumber number) {
        widget.controller2.text = number.dialCode!;
        widget.onChanged(number.toString());
      },
      onSubmit: () {
        print(123);
        FocusScope.of(context).unfocus();
      },
      selectorConfig: const SelectorConfig(
        showFlags: true,
        setSelectorButtonAsPrefixIcon: false,
        selectorType: PhoneInputSelectorType.DIALOG,
      ),
      inputDecoration: InputDecoration(
        prefixIcon: Image.asset("assets/icons/Search.png"),
        suffixIcon: widget.controller.text != ""
            ? IconButton(
                splashRadius: 12,
                icon: Image.asset("assets/icons/X_blue.png"),
                onPressed: () {
                  setState(() {
                    widget.controller.text = "";
                  });
                },
              )
            : null,
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
      keyboardAction: TextInputAction.search,
      keyboardType: TextInputType.phone,
      textStyle: AppStyle.body(
          level: 1, color: AppStyle.gray.shade900, weight: FontWeight.w500),
      textFieldController: widget.controller,
      focusNode: _focusNode,
    );
  }
}
