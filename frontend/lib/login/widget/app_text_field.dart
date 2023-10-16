part of 'login_widget.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? errorText;
  final bool isPassword;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final void Function(String)? onSubmit;

  const AppTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.isPassword = false,
    this.errorText,
    this.onChanged,
    this.onTap,
    this.onSubmit,
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
        const SizedBox(height: 4),
        TextField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          focusNode: _focusNode,
          obscureText: widget.isPassword ? _isObscure : false,
          textInputAction:
              widget.isPassword ? TextInputAction.done : TextInputAction.none,
          onSubmitted: widget.onSubmit,
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
            '※ 帳號或密碼錯誤 請重試',
            style: AppStyle.info(level: 1, color: AppStyle.red),
          )
        else
          const SizedBox(height: 9),
      ],
    );
  }
}