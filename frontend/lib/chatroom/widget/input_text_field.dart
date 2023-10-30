part of 'chatroom_widget.dart';

class InputTextField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function() onTap;

  const InputTextField({
    super.key,
    required this.controller,
    this.onChanged,
    required this.onTap,
  });

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
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
      //TODO:按enter要可以送出訊息
      controller: widget.controller,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      focusNode: _focusNode,
      style: AppStyle.body(
          level: 1, color: AppStyle.gray.shade900, weight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: "請輸入訊息",
        hintStyle: AppStyle.body(color: AppStyle.gray[500]!),
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
