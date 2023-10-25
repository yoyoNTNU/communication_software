part of 'chatroom_widget.dart';

class ContactNoise extends StatelessWidget {
  final double recordDuration;
  final bool senderIsMe;

  const ContactNoise({
    super.key,
    required this.recordDuration,
    required this.senderIsMe,
  });

  @override
  Widget build(BuildContext context) {
    int noiseCount = (recordDuration / 2) > 10
        ? (recordDuration / 2) >= 30
            ? 30
            : recordDuration ~/ 2
        : 10;

    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [for (int i = 0; i < noiseCount; i++) _singleNoise(context)],
      ),
    );
  }

  Widget _singleNoise(BuildContext context) {
    final double height = math.Random().nextDouble() * 25 + 5;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      width: 3,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        color: senderIsMe ? AppStyle.white : AppStyle.gray[700]!,
      ),
    );
  }
}
