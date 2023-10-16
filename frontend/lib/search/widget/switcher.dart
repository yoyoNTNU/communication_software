part of 'search_widget.dart';

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