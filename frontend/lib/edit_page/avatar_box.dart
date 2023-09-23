// import 'package:flutter/material.dart';
// import 'account_box.dart';
// import 'package:proj/style.dart';

// class AvatarBox extends StatefulWidget {
//   const AvatarBox({super.key});

//   @override
//   State<AvatarBox> createState() => _AvatarBoxState();
// }

// class _AvatarBoxState extends State<AvatarBox> {
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
//               child: unitHeader('個人相片'),
//             ),
//             divider(),
//             Expanded(
//               flex: 192,
//               child: Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 child: const AssetImageLoader(
//                     assetPath: 'assets/images/Avatar.jpg'),
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

// class AssetImageLoader extends StatelessWidget {
//   final String assetPath;

//   const AssetImageLoader({super.key, required this.assetPath});

//   @override
//   Widget build(BuildContext context) {
//     return Image.asset(
//       assetPath,
//     );
//   }
// }

// class TextWithColorParameter extends StatelessWidget {
//   final String text;
//   final Color textColor;

//   const TextWithColorParameter(this.text, this.textColor, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: TextStyle(
//         color: textColor,
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//       ),
//     );
//   }
// }

// Widget buttonIcon1() {
//   return ElevatedButton.icon(
//       style: ElevatedButton.styleFrom(
//         padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
//         backgroundColor: Colors.white,
//       ),
//       icon: Image.asset(
//         'assets/icons/Img_box.png', // Replace with the correct asset path
//         width: 24, // Set the width and height as needed
//         height: 24,
//         color: Color(0xFF40A8C4),
//       ),
//       onPressed: () {
//         PhotoAlbumAndroidState photoAlbum = PhotoAlbumAndroidState();
//         photoAlbum.importPhotos();
//       },
//       label: Text(
//         '修改相片', // Replace with your desired text
//         style: TextStyle(
//           color: Color(0xFF40A8C4), // Set the text color
//           fontSize: 18, // Set the text size
//         ),
//       ));
// }

// Widget buttonIcon2() {
//   return ElevatedButton.icon(
//       style: ElevatedButton.styleFrom(
//         padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
//         backgroundColor: Colors.white,
//       ),
//       icon: Image.asset(
//         'assets/icons/Trash.png', // Replace with the correct asset path
//         width: 24, // Set the width and height as needed
//         height: 24,
//         color: AppStyle.red,
//       ),
//       onPressed: () {},
//       label: Text(
//         '移除', // Replace with your desired text
//         style: TextStyle(
//           color: AppStyle.red, // Set the text color
//           fontSize: 18, // Set the text size
//         ),
//       ));
// }

// Widget buttonSet() {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Expanded(
//         flex: 1,
//         child: buttonIcon1(),
//       ),
//       const SizedBox(width: 24.0),
//       Expanded(
//         flex: 1,
//         child: buttonIcon2(),
//       ),
//     ],
//   );
// }
