import 'package:flutter/material.dart';
import 'package:proj/style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Dropdown extends StatefulWidget {
  final String? type;
  final void Function(String?)? onChanged;

  const Dropdown({
    super.key,
    required this.type,
    required this.onChanged,
  });
  
  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String? _chosenValue;
  bool _isDropdownOpened = false;
  final GlobalKey _textFieldKey = GlobalKey();
  // This variable will store which dropdown item is being hovered over
  String? hoveredItemValue;

  @override
  Widget build(BuildContext context) {
    final dropdownItems = [
      DropdownMenuItem<String>(
        value: "email",
        child: MouseRegion(
          onEnter: (_) => setState(() {
            hoveredItemValue = "email";
          }),
          onExit: (_) => setState(() {
            hoveredItemValue = null;
          }),
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              "電子郵件",
              style: AppStyle.caption(level: 1, color: 
                hoveredItemValue == "email" ? AppStyle.blue[500]! : AppStyle.black),
            ),
          ),
        ),
      ),
      DropdownMenuItem<String>(
        value: "id",
        child: MouseRegion(
          onEnter: (_) => setState(() {
            hoveredItemValue = "id";
          }),
          onExit: (_) => setState(() {
            hoveredItemValue = null;
          }),
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              "用戶 ID",
              style: AppStyle.caption(level: 1, color: 
                hoveredItemValue == "id" ? AppStyle.blue[500]! : AppStyle.black),
            ),
          ),
        ),
      ),
      DropdownMenuItem<String>(
        value: "number",
        child: MouseRegion(
          onEnter: (_) => setState(() {
            hoveredItemValue = "number";
          }),
          onExit: (_) => setState(() {
            hoveredItemValue = null;
          }),
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              "手機號碼",
              style: AppStyle.caption(level: 1, color: 
                hoveredItemValue == "number" ? AppStyle.blue[500]! : AppStyle.black),
            ),
          ),
        ),
      ),
    ];
    return Container(
      height: 40,
      width: 370,
      decoration: BoxDecoration(
        border: Border.all(color: AppStyle.blue[500]!),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton2<String>(
          value: widget.type,
          items: dropdownItems,
          onChanged: widget.onChanged,
          dropdownStyleData: const DropdownStyleData(
            padding: EdgeInsets.all(0),
            width: 360,
            elevation: 0,
            isOverButton: false,
          ),
          // ignore: prefer_const_constructors
          menuItemStyleData: MenuItemStyleData(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              customHeights: [40, 40, 40]),
          iconStyleData: IconStyleData(
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 30,
                color: AppStyle.blue[500]!,
              ),
            ),
            openMenuIcon: Icon(
              Icons.keyboard_arrow_up_rounded,
              size: 30,
              color: AppStyle.blue[500]!,
            ),
          ),
          isDense: true,
          enableFeedback: true,
          alignment: Alignment.centerLeft,
          // underline: Container(
          //   height: 0,
          //   color: Colors.transparent,
          // ),
          selectedItemBuilder: (BuildContext context) {
            return dropdownItems.map<Widget>((DropdownMenuItem<String> item) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                width: 327,
                child: Text(
                  (((item.child as MouseRegion).child as Container).child as Text).data!,
                  style: AppStyle.caption(
                    level: 1,
                    color: AppStyle.black,
                  ),
                  textAlign: TextAlign.left,
                ),
              );
            }).toList();
          }),
    );
    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     const SizedBox(height: 4),
    //     Container(
    //       key: _textFieldKey,
    //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    //       decoration: BoxDecoration(
    //         border: Border.all(color: Colors.grey),
    //         borderRadius: BorderRadius.circular(5),
    //       ),
    //       child: PopupMenuButton<String>(
    //         onSelected: (String value) {
    //           setState(() {
    //             _chosenValue = value;
    //           });
    //         },
    //         itemBuilder: (BuildContext context) {
    //           // Determine width of the text field
    //           final RenderBox renderBox = _textFieldKey.currentContext!.findRenderObject() as RenderBox;
    //           double width = renderBox.size.width;

    //           return <String>['選項1', '選項2', '選項3'].map((String value) {
    //             return PopupMenuItem<String>(
    //               value: value,
    //               child: Container(
    //                 width: width,
    //                 child: Text(value),
    //               ),
    //             );
    //           }).toList();
    //         },
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(_chosenValue!),
    //             const Icon(Icons.arrow_drop_down),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}