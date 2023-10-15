part of 'chatroom_list_widget.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function() onTapX;

  const AppTextField({
    super.key,
    required this.controller,
    this.onChanged,
    required this.onTapX,
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
        hintText: "請輸入關鍵字",
        hintStyle: AppStyle.body(color: AppStyle.gray[500]!),
        prefixIcon: Image.asset("assets/icons/Search.png"),
        suffixIcon: widget.controller.text != ""
            ? IconButton(
                splashRadius: 12,
                icon: Image.asset("assets/icons/X_blue.png"),
                onPressed: () {
                  setState(() {
                    widget.controller.text = "";
                    widget.onTapX();
                  });
                },
              )
            : null,
        filled: true,
        fillColor: AppStyle.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
