import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
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
          color: const Color(0xFFE6F0F5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              Image.asset('assets/images/Background.png').image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0.60,
                      child: Container(
                        width: double.infinity,
                        height: 180,
                        decoration: const BoxDecoration(color: Colors.white),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 24,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                          fixedSize: const Size(95, 24),
                          backgroundColor: const Color(0x01858585),
                        ),
                        icon: Image.asset('assets/icons/Edit.png'),
                        onPressed: () {},
                        label: const Text(
                          '編輯資料',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(color: Color(0xFFFFC93C)),
                      height: 4,
                    ),
                    const Positioned(
                      top: 90,
                      left: 12,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/images/Avatar.jpg'),
                        // child: const Text('e'),
                      ),
                    ),
                  ],
                ),

                // TODO: 好友列表 and 群組列表

                const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Rhoncus urna neque viverra justo nec ultrices. Neque ornare aenean euismod elementum nisi quis. Ac feugiat sed lectus vestibulum mattis ullamcorper velit sed ullamcorper. Eget duis at tellus at urna condimentum mattis. Metus vulputate eu scelerisque felis. Neque gravida in fermentum et sollicitudin. Aliquam ut porttitor leo a diam sollicitudin tempor id eu. Sollicitudin tempor id eu nisl nunc. Imperdiet sed euismod nisi porta lorem mollis. Leo vel fringilla est ullamcorper eget nulla facilisi. Nulla facilisi nullam vehicula ipsum a. Erat velit scelerisque in dictum. Id eu nisl nunc mi ipsum faucibus vitae. Ullamcorper sit amet risus nullam eget felis eget nunc. Magna ac placerat vestibulum lectus mauris ultrices. Id nibh tortor id aliquet lectus proin. Duis convallis convallis tellus id interdum. Sed velit dignissim sodales ut eu sem integer. Massa sed elementum tempus egestas sed sed risus pretium quam.In nulla posuere sollicitudin aliquam ultrices sagittis orci a. Rhoncus dolor purus non enim praesent elementum facilisis leo vel. Nibh venenatis cras sed felis eget velit aliquet sagittis id. Lacus sed turpis tincidunt id aliquet. Volutpat blandit aliquam etiam erat. Tincidunt arcu non sodales neque sodales ut. Aenean et tortor at risus viverra adipiscing at. Sagittis aliquam malesuada bibendum arcu vitae elementum. Phasellus faucibus scelerisque eleifend donec pretium vulputate sapien nec sagittis. Lacinia quis vel eros donec ac odio tempor. Phasellus vestibulum lorem sed risus ultricies. Justo donec enim diam vulputate ut pharetra sit amet. Turpis massa sed elementum tempus. Convallis a cras semper auctor. Sapien nec sagittis aliquam malesuada bibendum arcu vitae elementum curabitur. Aenean et tortor at risus viverra adipiscing at in. Gravida dictum fusce ut placerat orci nulla pellentesque dignissim enim. Faucibus et molestie ac feugiat sed lectus.Proin nibh nisl condimentum id venenatis a condimentum. Cras tincidunt lobortis feugiat vivamus. Neque sodales ut etiam sit amet. Enim ut sem viverra aliquet eget sit amet. Scelerisque eleifend donec pretium vulputate sapien nec sagittis aliquam. Mi ipsum faucibus vitae aliquet nec ullamcorper sit. Consequat mauris nunc congue nisi. Quisque id diam vel quam elementum pulvinar. Neque gravida in fermentum et sollicitudin ac orci phasellus egestas. Lorem mollis aliquam ut porttitor leo a diam. Orci nulla pellentesque dignissim enim sit amet venenatis urna cursus. Condimentum mattis pellentesque id nibh tortor id. Vel orci porta non pulvinar neque laoreet suspendisse interdum. Ultricies integer quis auctor elit sed vulputate mi sit amet. Felis eget velit aliquet sagittis id consectetur purus ut. Adipiscing elit pellentesque habitant morbi tristique senectus. Magna sit amet purus gravida quis. Purus faucibus ornare suspendisse sed. Ornare arcu odio ut sem nulla. Nunc mi ipsum faucibus vitae aliquet nec ullamcorper.Turpis nunc eget lorem dolor sed viverra ipsum nunc. Orci sagittis eu volutpat odio facilisis mauris sit. Sit amet luctus venenatis lectus. Facilisis sed odio morbi quis commodo odio aenean sed adipiscing. Orci eu lobortis elementum nibh tellus. Euismod lacinia at quis risus. Et ultrices neque ornare aenean euismod elementum nisi. Ut sem viverra aliquet eget sit amet. Amet nulla facilisi morbi tempus iaculis urna id. Viverra justo nec ultrices dui sapien eget mi. Urna molestie at elementum eu facilisis sed odio morbi. Eget gravida cum sociis natoque penatibus et magnis. Lobortis elementum nibh tellus molestie nunc non blandit massa enim.Tortor condimentum lacinia quis vel eros donec ac. Et malesuada fames ac turpis. Eu ultrices vitae auctor eu augue. Morbi quis commodo odio aenean sed adipiscing diam donec adipiscing. Purus ut faucibus pulvinar elementum. Cursus eget nunc scelerisque viverra mauris in. Nibh venenatis cras sed felis eget velit aliquet. Amet nulla facilisi morbi tempus iaculis urna id volutpat lacus. Risus feugiat in ante metus dictum at tempor. Sem fringilla ut morbi tincidunt. Cras fermentum odio eu feugiat pretium nibh ipsum. Nibh sit amet commodo nulla facilisi nullam vehicula ipsum a. Ac odio tempor orci dapibus ultrices. Et netus et malesuada fames. Justo nec ultrices dui sapien eget mi proin sed libero. Aliquam faucibus purus in massa tempor nec. Malesuada bibendum arcu vitae elementum curabitur vitae nunc. Morbi quis commodo odio aenean sed adipiscing.'),

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(127, 40),
                    foregroundColor: const Color(0xFFFB0C06),
                    backgroundColor: Colors.white,
                  ),
                  icon: Image.asset('assets/icons/Sign_out_circle.png'),
                  onPressed: () {},
                  label: const Text(
                    '登出',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFB0C06),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
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

void pass() {}
