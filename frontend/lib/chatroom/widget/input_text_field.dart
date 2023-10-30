part of 'chatroom_widget.dart';

class InputTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function() onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  const InputTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onTap,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: null,
      controller: widget.controller,
      onSubmitted: widget.onSubmitted,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      focusNode: widget.focusNode,
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
