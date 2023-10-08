part of 'group_widget.dart';

class Title extends StatelessWidget {
  final String text;

  // Constructor to receive the text
  const Title(this.text);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        text,
        style: AppStyle.header(color: AppStyle.gray[700]!),
        textAlign: TextAlign.left,
      ),
    );
  }
}
