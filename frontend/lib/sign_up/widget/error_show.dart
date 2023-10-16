part of 'sign_up_widget.dart';

class ErrorShow extends StatefulWidget {
  final List<String> mainType;
  final List<String> mainIcon;
  final List<List<String>> secType;
  final List<List<bool>> isPass;

  const ErrorShow({
    super.key,
    required this.mainType,
    required this.mainIcon,
    required this.secType,
    required this.isPass,
  });

  @override
  State<ErrorShow> createState() => _ErrorShowState();
}

class _ErrorShowState extends State<ErrorShow> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppStyle.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: AppStyle.gray,
            width: 2.0,
          ),
        ),
        child: Column(
          children: List.generate(4, (index1) {
            return Column(children: [
              MainLine(
                  icon: widget.mainIcon[index1], type: widget.mainType[index1]),
              Column(
                  children:
                      List.generate(widget.secType[index1].length, (index2) {
                return SecLine(
                    isPass: widget.isPass[index1][index2],
                    type: widget.secType[index1][index2]);
              }))
            ]);
          }),
        ));
  }
}