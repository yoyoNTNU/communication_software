import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE6F0F5),
      padding: const EdgeInsets.only(
        top: 44,
        left: 24,
        right: 24,
        bottom: 34,
      ),
      child: const Center(
        child: Column(
          children: [
            Logo(),
            DialogBox(title: "使用者登入", content: Text("Hello")),
            ElevatedButton(
              onPressed: null,
              child: Text("註冊"),
            )
          ],
        ),
      ),
    );
  }
}

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       clipBehavior: Clip.antiAlias,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Color(0x3F000000),
//           blurRadius: 4,
//             offset: Offset(0, 4),
//             spreadRadius: 0,
//           )
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 375,
//             height: 44,
//             padding: const EdgeInsets.only(
//               top: 13,
//               left: 32,
//               right: 15,
//               bottom: 10,
//             ),
//             clipBehavior: Clip.antiAlias,
//             decoration: const BoxDecoration(color: Color(0xFFE6F0F5)),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Text(
//                   '9:41',
//                   style: TextStyle(
//                     color: Color(0xFF020202),
//                     fontSize: 15,
//                     fontFamily: 'Roboto',
//                     fontWeight: FontWeight.w500,
//                     height: 21,
//                     letterSpacing: -0.32,
//                   ),
//                 ),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: 20,
//                       height: 16,
//                       child: Stack(
//                         children: [
//                           Positioned(
//                             left: 1,
//                             top: 3,
//                             child: Container(
//                               width: 17,
//                               height: 10.67,
//                               decoration: const BoxDecoration(
//                                 image: DecorationImage(
//                                   image: NetworkImage(
//                                       "https://via.placeholder.com/17x11"),
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: 16,
//                       height: 16,
//                       child: Stack(
//                         children: [
//                           Positioned(
//                             left: 0.35,
//                             top: 3,
//                             child: Container(
//                               width: 15.27,
//                               height: 10.97,
//                               decoration: const BoxDecoration(
//                                 image: DecorationImage(
//                                   image: NetworkImage(
//                                       "https://via.placeholder.com/15x11"),
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       width: 25,
//                       height: 16,
//                       clipBehavior: Clip.antiAlias,
//                       decoration: const BoxDecoration(),
//                       child: const Stack(children: []),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               clipBehavior: Clip.antiAlias,
//               decoration: const BoxDecoration(color: Color(0xFFE6F0F5)),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(vertical: 48),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           width: 120,
//                           height: 120,
//                           clipBehavior: Clip.antiAlias,
//                           decoration: const BoxDecoration(),
//                           child: Stack(
//                             children: [
//                               Positioned(
//                                 left: 9.33,
//                                 top: 16.62,
//                                 child: Container(
//                                   width: 99.48,
//                                   height: 93.09,
//                                   decoration: const BoxDecoration(
//                                     image: DecorationImage(
//                                       image: NetworkImage(
//                                           "https://via.placeholder.com/99x93"),
//                                       fit: BoxFit.fill,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Text(
//                           'ExpressMessage',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Color(0xFF07689F),
//                             fontSize: 16,
//                             fontFamily: 'Noto Sans TC',
//                             fontWeight: FontWeight.w500,
//                             letterSpacing: 1.28,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: 327,
//                     height: 308,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 24, vertical: 16),
//                     clipBehavior: Clip.antiAlias,
//                     decoration: ShapeDecoration(
//                       color: Colors.white,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)),
//                       shadows: const [
//                         BoxShadow(
//                           color: Color(0x3F000000),
//                           blurRadius: 2,
//                           offset: Offset(0, 1),
//                           spreadRadius: 0,
//                         )
//                       ],
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           width: double.infinity,
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Opacity(
//                                 opacity: 0,
//                                 child: Container(
//                                   width: 24,
//                                   height: 24,
//                                   padding: const EdgeInsets.only(
//                                       top: 6, left: 4, right: 5, bottom: 6),
//                                   child: const Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [],
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               const Expanded(
//                                 child: SizedBox(
//                                   height: 23,
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         '使用者登入',
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           color: Color(0xFF707070),
//                                           fontSize: 16,
//                                           fontFamily: 'Noto Sans TC',
//                                           fontWeight: FontWeight.w500,
//                                           letterSpacing: 1.28,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               Opacity(
//                                 opacity: 0,
//                                 child: SizedBox(
//                                   width: 24,
//                                   height: 24,
//                                   child: Stack(
//                                     children: [
//                                       Positioned(
//                                         left: 3,
//                                         top: 3,
//                                         child: Container(
//                                           width: 18,
//                                           height: 18,
//                                           decoration: const ShapeDecoration(
//                                             shape: OvalBorder(
//                                               side: BorderSide(
//                                                 width: 1,
//                                                 strokeAlign: BorderSide
//                                                     .strokeAlignCenter,
//                                                 color: Color(0xFF333333),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           width: double.infinity,
//                           height: 64,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(
//                                 width: 50,
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       '帳號（電子郵件）',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         color: Color(0xFF07689F),
//                                         fontSize: 14,
//                                         fontFamily: 'Noto Sans TC',
//                                         fontWeight: FontWeight.w400,
//                                         letterSpacing: 0.56,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 width: double.infinity,
//                                 height: 40,
//                                 margin: const EdgeInsets.all(8),
//                                 padding: const EdgeInsets.all(8),
//                                 decoration: ShapeDecoration(
//                                   shape: RoundedRectangleBorder(
//                                     side: const BorderSide(
//                                         width: 0.50, color: Color(0xFF07689F)),
//                                     borderRadius: BorderRadius.circular(4),
//                                   ),
//                                 ),
//                                 child: TextFormField(
//                                   controller: _emailController,
//                                   keyboardType: TextInputType.emailAddress,
//                                   decoration: const InputDecoration(
//                                     labelText: 'Email',
//                                     border: InputBorder.none,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           width: double.infinity,
//                           height: 64,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(
//                                 width: 50,
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       '密碼',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         color: Color(0xFF07689F),
//                                         fontSize: 14,
//                                         fontFamily: 'Noto Sans TC',
//                                         fontWeight: FontWeight.w400,
//                                         letterSpacing: 0.56,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 width: double.infinity,
//                                 height: 40,
//                                 margin: const EdgeInsets.all(8),
//                                 padding: const EdgeInsets.all(8),
//                                 decoration: ShapeDecoration(
//                                   shape: RoundedRectangleBorder(
//                                     side: const BorderSide(
//                                         width: 0.50, color: Color(0xFF07689F)),
//                                     borderRadius: BorderRadius.circular(4),
//                                   ),
//                                 ),
//                                 child: TextFormField(
//                                   controller: _passwordController,
//                                   obscureText: true,
//                                   decoration: const InputDecoration(
//                                     labelText: 'Password',
//                                     border: InputBorder.none,
//                                     suffixIcon: Icon(Icons.visibility),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           width: double.infinity,
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ElevatedButton(
//                                   onPressed: () {
//                                     // Navigate to the SecondScreen when the button is pressed.
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const SecondScreen()),
//                                     );
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     foregroundColor: Colors.white, // Text color
//                                     backgroundColor: const Color(
//                                         0xFF40A8C4), // background color
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(4)),
//                                   ),
//                                   child: const Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 32, vertical: 8),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           '登入',
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 14,
//                                             fontFamily: 'Noto Sans TC',
//                                             fontWeight: FontWeight.w500,
//                                             letterSpacing: 2.24,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                               const SizedBox(width: 24),
//                               ElevatedButton(
//                                   onPressed: () {
//                                     print('button');
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     foregroundColor: const Color(0xFF40A8C4),
//                                     backgroundColor:
//                                         Colors.white, // background color
//                                     shape: RoundedRectangleBorder(
//                                       side: const BorderSide(
//                                           width: 0.50,
//                                           color: Color(0xFFCDE1EC)),
//                                       borderRadius: BorderRadius.circular(4),
//                                     ),
//                                   ),
//                                   child: const Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 32, vertical: 8),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           '忘記密碼',
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                             color: Color(0xFF40A8C4),
//                                             fontSize: 14,
//                                             fontFamily: 'Noto Sans TC',
//                                             fontWeight: FontWeight.w500,
//                                             letterSpacing: 2.24,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(vertical: 32),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 32, vertical: 8),
//                           decoration: ShapeDecoration(
//                             color: const Color(0xFFFFC93C),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(4)),
//                           ),
//                           child: const Row(
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 '註冊',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   color: Color(0xFF333333),
//                                   fontSize: 14,
//                                   fontFamily: 'Noto Sans TC',
//                                   fontWeight: FontWeight.w500,
//                                   letterSpacing: 2.24,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         const Text(
//                           '新用戶？點我註冊',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Color(0xFF856F37),
//                             fontSize: 10,
//                             fontFamily: 'Noto Sans TC',
//                             fontWeight: FontWeight.w400,
//                             letterSpacing: 0.40,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             width: double.infinity,
//             decoration: const BoxDecoration(color: Color(0xFFE6F0F5)),
//             child: const Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   'Instant Communication, Delivered Express',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Color(0xFF195374),
//                     fontSize: 10,
//                     fontFamily: 'Noto Sans TC',
//                     fontWeight: FontWeight.w400,
//                     letterSpacing: 0.40,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             width: 375,
//             height: 34,
//             padding: const EdgeInsets.only(
//               top: 21,
//               left: 121,
//               right: 120,
//               bottom: 8,
//             ),
//             decoration: const BoxDecoration(color: Color(0xFFE6F0F5)),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 134,
//                   height: 5,
//                   decoration: ShapeDecoration(
//                     color: const Color(0xFF020202),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(100),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ));
//   }
// }

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Logo.png',
            width: 120,
            height: 120,
          ),
          const SizedBox(height: 8),
          const Text(
            'Instant Communication, Delivered Express',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF195374),
              fontSize: 16,
              fontFamily: 'Noto Sans TC',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.40,
            ),
          ),
        ],
      ),
    );
  }
}

class DialogBox extends StatelessWidget {
  final String title;
  final Widget content;
  const DialogBox({super.key, required this.title, required this.content});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            offset: Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(title),
          const SizedBox(height: 8),
          content,
        ],
      ),
    );
  }
}
