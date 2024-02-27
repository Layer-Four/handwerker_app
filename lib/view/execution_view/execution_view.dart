// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:handwerker_app/constants/globals.dart';
// import 'package:handwerker_app/view/navigation_view/app_navigation_bar.dart';

// class ExecutionView extends ConsumerStatefulWidget {
//   const ExecutionView({super.key});
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _ExecutionViewState();
// }

// class _ExecutionViewState extends ConsumerState<ExecutionView> {
//   final dayPickerController = TextEditingController();
//   // final vonController?
//   // final bisController?

//   @override
//   Widget build(BuildContext context) {
//     DateTime? selecedDate;
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SmallTextFFieldLabel(
//                     label: 'Tag',
//                     formField: TextFormField(
//                       textInputAction: TextInputAction.done,
//                       controller: dayPickerController,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: const BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: const BorderSide(color: Colors.blue))),
//                       onTap: () async {
//                         selecedDate = await Utilits.selecetDate(context);
//                         if (selecedDate != null) {
//                           setState(() {
//                             dayPickerController.text =
//                                 '${selecedDate!.day}.${selecedDate!.month}.${selecedDate!.year}';
//                           });
//                         }
//                       },
//                     ),
//                   ),
//                   const SmallTextFFieldLabel(
//                     label: 'Dauer',
//                     formField: TextField(),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


