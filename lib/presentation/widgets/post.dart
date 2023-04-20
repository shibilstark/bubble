// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:wave/config/themes/themes.dart';
// import 'package:wave/presentation/widgets/gap.dart';
// import 'package:wave/presentation/widgets/rounded_container.dart';

// class PostWidget extends StatelessWidget {
//   const PostWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     final postWidth = size.width;
//     final postHeight = postWidth * 0.7;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             LimitedBox(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   RoundedContainerWidget(
//                     borderRadius: BorderRadius.circular(5),
//                     height: 30,
//                     width: 30,
//                     decoration: const BoxDecoration(
//                       color: Palette.lightRed,
//                     ),
//                   ),
//                   Gap(W: 5.w),
//                   Text(
//                     "David Jhone",
//                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                           fontSize: AppFontSize.bodySmall,
//                           fontWeight: AppFontWeight.medium,
//                         ),
//                   )
//                 ],
//               ),
//             ),
//             IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.more_vert,
//                   size: 15,
//                 ))
//           ],
//         ),
//         RoundedContainerWidget(
//           borderRadius: BorderRadius.circular(5),
//           height: postHeight,
//           width: postWidth,
//           decoration: BoxDecoration(
//             color: Theme.of(context).colorScheme.background,
//           ),
//         ),
//         Gap(H: 5.h),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 5),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "150 Bolts  150 Comments",
//                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       fontWeight: AppFontWeight.medium,
//                       fontSize: AppFontSize.displayLarge,
//                     ),
//               ),
//               Text(
//                 "10h",
//                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       fontWeight: AppFontWeight.medium,
//                       fontSize: AppFontSize.displayLarge,
//                     ),
//               ),
//             ],
//           ),
//         ),
//         Row(
//           children: [
//             IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.bolt,
//                 size: 20,
//                 color: Theme.of(context).colorScheme.surface,
//               ),
//             ),
//             IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.comment,
//                 size: 20,
//                 color: Theme.of(context).colorScheme.surface,
//               ),
//             ),
//             IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.send,
//                 size: 20,
//                 color: Theme.of(context).colorScheme.surface,
//               ),
//             ),
//           ],
//         ),
//         Text(
//           "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots",
//           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                 fontSize: AppFontSize.displayLarge,
//               ),
//         )
//       ],
//     );
//   }
// }
