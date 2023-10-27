part of 'search_widget.dart';

class IDTextField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;
  final void Function(String) onSubmit;

  const IDTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onSubmit,
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
        widget.onSubmit(value);
        FocusScope.of(context).unfocus();
      },
      focusNode: _focusNode,
      style: AppStyle.body(
          level: 1, color: AppStyle.gray.shade900, weight: FontWeight.w500),
      decoration: InputDecoration(
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
    );
  }
}
