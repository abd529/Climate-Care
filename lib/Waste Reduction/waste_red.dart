// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/simple/get_view.dart';
// import 'modules/chat_text/controllers/chat_text_controller.dart';

// class WasteRedScreen extends GetView<ChatTextController> {
//    WasteRedScreen({super.key});
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController controller_1 = TextEditingController();
//   TextEditingController controller_2 = TextEditingController();
//   TextEditingController controller_3 = TextEditingController();
//   TextEditingController controller_4 = TextEditingController();
//   TextEditingController controller_5 = TextEditingController();
//   int creator = 0;
//   bool fild_no_check = false;
//   void addButton() {
//     setState(() {
//       if (creator < 4) {
//         creator++;
//       }
//     });
//   }

//   void removeButton() {
//     setState(() {
//       if (creator >= 0) {
//         creator--;
//       }
//     });
//   }

//   void submit() {
//     if (_formKey.currentState!.validate()) {
//       if (controller_1.text.isNotEmpty) {
//         print(controller_1.text);
//         controller_1.clear();
//       }
//       if (controller_5.text.isNotEmpty) {
//         print(controller_2.text);
//         controller_2.clear();
//       }
//       if (controller_3.text.isNotEmpty) {
//         print(controller_3.text);
//         controller_3.clear();
//       }
//       if (controller_4.text.isNotEmpty) {
//         print(controller_4.text);
//         controller_4.clear();
//       }
//       if (controller_5.text.isNotEmpty) {
//         print(controller_5.text);
//         controller_5.clear();
//       }
//       controller.getTextCompletion(controllerOne.text,
//                       controllerTwo.text, controllerThree.text);
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(
//           child: Text(
//             "Waste Reduction Tool",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         backgroundColor: Colors.green,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Container(
//                   width: 250,
//                   child: const Text(
//                     "Add one or more items that you own and want to recycle!",
//                     softWrap: true,
//                   ),
//                 ),
//                 SizedBox(
//                     height: 80,
//                     width: 80,
//                     child: Image.asset("assets/cli-matee.png"))
//               ],
//             ),
//             Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     if (creator == 0) ...[
//                       TextFeildCon(controller_1)
//                     ] else if (creator == 1) ...[
//                       TextFeildCon(controller_1),
//                       TextFeildCon(controller_2),
//                     ] else if (creator == 2) ...[
//                       TextFeildCon(controller_1),
//                       TextFeildCon(controller_2),
//                       TextFeildCon(controller_3),
//                     ] else if (creator == 3) ...[
//                       TextFeildCon(controller_1),
//                       TextFeildCon(controller_2),
//                       TextFeildCon(controller_3),
//                       TextFeildCon(controller_4),
//                     ] else if (creator == 4) ...[
//                       TextFeildCon(controller_1),
//                       TextFeildCon(controller_2),
//                       TextFeildCon(controller_3),
//                       TextFeildCon(controller_4),
//                       TextFeildCon(controller_5),
//                     ],
//                   ],
//                 )),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   margin: const EdgeInsets.all(15),
//                   child: ElevatedButton(
//                     onPressed: addButton,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                     ),
//                     child: const Text(
//                       '+ Add more',
//                       style: TextStyle(color: Colors.black, fontSize: 11),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   margin: const EdgeInsets.all(15),
//                   child: ElevatedButton(
//                     onPressed: removeButton,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                     ),
//                     child: const Text(
//                       'Remove',
//                       style: TextStyle(color: Colors.red, fontSize: 11),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Container(
//               width: 130,
//               height: 45,
//               margin: const EdgeInsets.all(30),
//               child: ElevatedButton(
//                 onPressed: submit,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Theme.of(context).primaryColor,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(22)),
//                 ),
//                 child: const Text('Sumbit'),
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.all(30),
//               width: double.infinity,
//               height: 100,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: Colors.green.shade100,
//               ),
//               child: const Text(
//                 'Response \n its not responsive yet...',
//                 textAlign: TextAlign.center,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }