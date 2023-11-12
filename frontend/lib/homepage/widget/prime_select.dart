part of 'homepage_widget.dart';

class PrimeSelect extends StatelessWidget {
  const PrimeSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppStyle.white,
          borderRadius: BorderRadius.circular(4),
        ),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context, '/edit');
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/icons/edit_blue.png"),
                      Text(
                        '編輯資料',
                        style: AppStyle.caption(
                          level: 2,
                          color: AppStyle.blue,
                        ),
                      ),
                    ]),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context, '/invite');
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/icons/user_add.png"),
                      Text(
                        '好友邀請',
                        style: AppStyle.caption(
                          level: 2,
                          color: AppStyle.blue,
                        ),
                      ),
                    ]),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context, '/setting');
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/icons/setting.png"),
                      Text(
                        '設定',
                        style: AppStyle.caption(
                          level: 2,
                          color: AppStyle.blue,
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        ));
  }
}
