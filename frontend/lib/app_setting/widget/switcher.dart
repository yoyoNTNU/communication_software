part of 'app_setting_widget.dart';

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
          borderRadius: BorderRadius.circular(20),
          indicatorColor: AppStyle.teal,
          borderColor: AppStyle.teal),
      indicatorSize: const Size(24, 24),
      iconBuilder: (bool value) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '',
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
      selectedIconScale: 1.5,
      height: 24,
      // width: 48,
      borderWidth: 2,
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