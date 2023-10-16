part of 'chatroom_list_widget.dart';

class TypeDropdownButton extends StatefulWidget {
  final String? type;
  final void Function(String?)? onChanged;

  const TypeDropdownButton({
    super.key,
    required this.type,
    required this.onChanged,
  });
  @override
  State<TypeDropdownButton> createState() => _TypeDropdownButtonState();
}

class _TypeDropdownButtonState extends State<TypeDropdownButton> {
  @override
  Widget build(BuildContext context) {
    final dropdownItems = [
      DropdownMenuItem<String>(
        value: "all",
        child: Container(
          height: 22,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          alignment: Alignment.center,
          child: Text(
            "全部",
            style: AppStyle.caption(level: 2, color: AppStyle.teal),
          ),
        ),
      ),
      DropdownMenuItem<String>(
        value: "1",
        enabled: false,
        child: Container(
          color: AppStyle.gray[100],
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          alignment: Alignment.center,
          child: Text(
            "三個字",
            style: AppStyle.caption(level: 2, color: AppStyle.gray[100]!),
          ),
        ),
      ),
      DropdownMenuItem<String>(
        value: "friend",
        child: Container(
          height: 22,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          alignment: Alignment.center,
          child: Text(
            "僅好友",
            style: AppStyle.caption(level: 2, color: AppStyle.yellow),
          ),
        ),
      ),
      DropdownMenuItem<String>(
        value: "2",
        enabled: false,
        child: Container(
          height: 22,
          color: AppStyle.gray[100],
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          alignment: Alignment.center,
          child: Text(
            "三個字",
            style: AppStyle.caption(level: 2, color: AppStyle.gray[100]!),
          ),
        ),
      ),
      DropdownMenuItem<String>(
        value: "group",
        child: Container(
          height: 22,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          alignment: Alignment.center,
          child: Text(
            "僅群組",
            style: AppStyle.caption(level: 2, color: AppStyle.teal),
          ),
        ),
      ),
    ];
    return Container(
      height: 24,
      decoration: BoxDecoration(
        border: widget.type == "all"
            ? Border.all(color: AppStyle.teal)
            : widget.type == "friend"
                ? Border.all(color: AppStyle.yellow)
                : Border.all(color: AppStyle.teal),
        borderRadius: BorderRadius.circular(8),
        color: widget.type == "all"
            ? AppStyle.white
            : widget.type == "friend"
                ? AppStyle.yellow
                : AppStyle.teal,
      ),
      child: DropdownButton2<String>(
          value: widget.type,
          items: dropdownItems,
          onChanged: widget.onChanged,
          dropdownStyleData: DropdownStyleData(
            padding: const EdgeInsets.all(0),
            width: 68,
            elevation: 0,
            isOverButton: false,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppStyle.white,
                border: Border.all(color: AppStyle.teal)),
          ),
          menuItemStyleData: MenuItemStyleData(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              customHeights: [22, 1, 22, 1, 22]),
          iconStyleData: IconStyleData(
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 24,
                color: widget.type == "all" ? AppStyle.teal : AppStyle.white,
              ),
            ),
            openMenuIcon: Icon(
              Icons.keyboard_arrow_up_rounded,
              size: 24,
              color: widget.type == "all" ? AppStyle.teal : AppStyle.white,
            ),
          ),
          isDense: true,
          enableFeedback: true,
          alignment: Alignment.center,
          underline: Container(
            height: 0,
            color: Colors.transparent,
          ),
          selectedItemBuilder: (BuildContext context) {
            return dropdownItems.map<Widget>((DropdownMenuItem<String> item) {
              return Container(
                padding: const EdgeInsets.only(left: 8),
                width: 43,
                child: Text(
                  ((item.child as Container).child as Text).data!,
                  style: AppStyle.caption(
                    level: 2,
                    color:
                        widget.type == "all" ? AppStyle.teal : AppStyle.white,
                  ),
                  textAlign: TextAlign.left,
                ),
              );
            }).toList();
          }),
    );
  }
}
