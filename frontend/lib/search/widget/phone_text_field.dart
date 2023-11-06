part of 'search_widget.dart';

class PhoneTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController controller2;
  final void Function(String) onChanged;
  final void Function() onSubmit;

  const PhoneTextField({
    super.key,
    required this.controller,
    required this.controller2,
    required this.onChanged,
    required this.onSubmit,
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
        widget.onSubmit();
        FocusScope.of(context).unfocus();
      },
      selectorConfig: const SelectorConfig(
        showFlags: true,
        setSelectorButtonAsPrefixIcon: false,
        selectorType: PhoneInputSelectorType.DIALOG,
      ),
      inputDecoration: InputDecoration(
        prefixIcon: Image.asset("assets/icons/search.png"),
        suffixIcon: widget.controller.text != ""
            ? IconButton(
                splashRadius: 12,
                icon: Image.asset("assets/icons/x_blue.png"),
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
