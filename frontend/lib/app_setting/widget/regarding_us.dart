part of 'app_setting_widget.dart';

Widget regardingUS() {
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppStyle.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          title("關於我們"),
          const SizedBox(
            height: 12,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: AppStyle.gray[100],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 192,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'fkjweoaonviewn;volasdnklf;dsnfmklsdmnkl;fmsdldkfjkals;djfkldslkf;aklsdfds',
            style: AppStyle.info(level: 2, color: AppStyle.gray[700]!),
          ),
        ]
      )
  );       
}