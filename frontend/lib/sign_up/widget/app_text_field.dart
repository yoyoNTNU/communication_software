part of 'sign_up_widget.dart';

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
            keyboardType: widget.labelText == "電子信箱"
                ? TextInputType.emailAddress
                : TextInputType.text,
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