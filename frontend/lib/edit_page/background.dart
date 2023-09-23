// import 'package:flutter/material.dart';
// import 'account_box.dart';
// import 'avatar_box.dart';


// class BackgroundBox extends StatefulWidget {
//   const BackgroundBox({super.key});

//   @override
//   State<BackgroundBox> createState() => _BackgroundBoxState();
// }

// class _BackgroundBoxState extends State<BackgroundBox> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               flex: 27,
//               child: unitHeader('背景相片'),
//             ),
//             divider(),
//             Expanded(
//               flex:192,
//               child: Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 child: const AssetImageLoader(assetPath: 'assets/images/Background.png'),
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             Expanded(
//               flex: 40,
//               child: buttonSet(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }