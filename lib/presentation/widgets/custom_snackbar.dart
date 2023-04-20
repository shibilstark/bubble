// import 'package:flutter/material.dart';
// import 'package:bubble/presentation/widgets/rounded_container.dart';

// import '../../config/themes/themes.dart';

// void showCustomSnackBar(
//   BuildContext context, {
//   required String message,
// }) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       padding: const EdgeInsets.all(10),
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       content: Container(
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.background,
//         ),
//         child: Row(
//           children: [
//             RoundedContainerWidget(
//               borderRadius: BorderRadius.circular(5),
//               height: 15,
//               width: 15,
//               decoration: const BoxDecoration(
//                 color: Palette.purple,
//               ),
//             ),
//             WhiteSpace.gapW15,
//             Expanded(
//               child: Text(
//                 message,
//                 style: Theme.of(context).textTheme.bodySmall!.copyWith(),
//               ),
//             ),
//           ],
//         ),
//       )));
// }
