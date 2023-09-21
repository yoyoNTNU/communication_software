import 'package:flutter/material.dart';
import 'package:proj/style.dart';
import 'package:proj/login/login_widget.dart';

class AddFriends extends StatefulWidget {
  const AddFriends({super.key});

  @override
  State<AddFriends> createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F0F5),
      appBar: AppBar(
        title: Text(
          '新增好友',
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 18,
            fontFamily: 'Noto Sans TC',
            fontWeight: FontWeight.w500,
            letterSpacing: 1.44,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: ImageIcon(AssetImage('assets/icons/Table.png')),
            label: '個人主頁',
          ),
          NavigationDestination(
            icon: ImageIcon(AssetImage('assets/icons/Chat.png')),
            label: '聊天室',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 150,
                child: searchBox(context),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: AppStyle.blue[50],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/icons/Group1.png',                            
                          ),
                        ),
                        Container(
                          child: const Text(
                            '查無結果',
                            style: TextStyle(
                              color: Color(0xFF707070),
                              fontSize: 12,
                              fontFamily: 'Noto Sans TC',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.48,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   flex: 17,
              //   child: Container(
              //     color: AppStyle.gray[400],
              //     child: Text('查無結果'),
              //   ),
              // ),
            ],
          ),
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('聊天室頁面'),
        ),
      ][currentPageIndex],
    );
  }
}

Widget searchBox(BuildContext context){
  final TextEditingController dobController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String labelText = '';
  String hintText = '';
  
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 111,
                height: 34,
                child: TextButton(
                  onPressed: () {
                    labelText = '手機號碼';
                    hintText = '請輸入手機號碼';
                    // _AddFriendsState().build(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF40A8C4),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50, color: Color(0xFF40A8C4)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "手機號碼",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              Container(
                width: 111,
                height: 34,
                child: TextButton(
                  onPressed: () {
                    labelText = '用戶ID';
                    hintText = '請輸入用戶ID';
                    // _AddFriendsState().build(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF40A8C4),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50, color: Color(0xFF40A8C4)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "用戶ID",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              // const SizedBox(width: 48.0),
            ],
          ),
        ),
        // const SizedBox(height: 16.0),
        Container(
          //height: 40,
          child: AppTextField(
            key: UniqueKey(),
            controller: dobController,
            labelText: '手機號碼',
            hintText: '請輸入手機號碼',
            // prefixIcon: Icon(Icons.search),
            onTap: () {
              _scrollController.animateTo(
                  _scrollController.position
                      .maxScrollExtent,
                  duration: const Duration(
                      milliseconds: 300),
                  curve: Curves.easeInOut);
            },
          ),
        ),
      ],
    ),
  );
}