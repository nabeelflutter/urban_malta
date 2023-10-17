// import 'package:flutter/material.dart';
// import 'package:kappu/screens/home_page/home_screen.dart';
// import 'package:kappu/screens/homescreen/home2.dart';

// import 'package:sliding_up_panel/sliding_up_panel.dart';

// class Sliding extends StatefulWidget {
//   const Sliding({Key? key});

//   @override
//   State<Sliding> createState() => _SlidingUpPagingState();
// }

// class _SlidingUpPagingState extends State<Sliding> {
//   bool isFinished = false;

//   bool isPanelOpen = false;
//   PanelController _panelController = PanelController();

//   @override
//   void initState() {
//     super.initState();
//     _panelController = PanelController();
//   }
//   @override
//   Widget build(BuildContext context) {
//     final Slidehight = MediaQuery.of(context).size.height / 1.2;

//     return Scaffold(
//       body: SlidingUpPanel(
//         controller: _panelController,
//         maxHeight: Slidehight,
//         minHeight: 30,
//         renderPanelSheet: false,
//         panel: Container(
//           child: Homescreen2(jsonData: ,),
//         ),
//         body: HomeScreen(),
//       ),
//     );
//   }
// }
