// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';

// import '../model/notemodel.dart';

// class CardNotes extends StatelessWidget {
//   final void Function() ontap;
//   final void Function()? onDelete;
//   final NoteModel noteModel;
//   const CardNotes(
//       {super.key,
//       required this.ontap,
//       required this.noteModel,
//       required this.onDelete});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: ontap,
//       child: Card(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Expanded(
//               flex: 1,
//               child: Image.asset(
//                 "assets/images/logo1.jpg",
//                 width: 75,
//                 height: 80,
//                 fit: BoxFit.fill,
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: ListTile(
//                 title: Text("${noteModel.noteTitle}"),
//                 subtitle: Text("${noteModel.noteContent}"),
//                 trailing: IconButton(
//                   onPressed: onDelete,
//                   icon: Icon(Icons.delete),
//                   color: Colors.red,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
