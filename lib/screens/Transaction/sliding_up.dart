import 'package:flutter/material.dart';
import 'package:kappu/screens/Transaction/detailtransfer.dart';
import 'package:kappu/screens/Transaction/transfersucces.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingUp extends StatefulWidget {
  const SlidingUp({Key? key});

  @override
  State<SlidingUp> createState() => _SlidingUpState();
}

class _SlidingUpState extends State<SlidingUp> {
  bool isFinished = false;

  bool isPanelOpen = false;
  PanelController _panelController = PanelController();

  @override
  void initState() {
    super.initState();
    _panelController = PanelController();
  }

  @override
  Widget build(BuildContext context) {
    final Slidehight = MediaQuery.of(context).size.height / 1.2;

    return Scaffold(
      body: SlidingUpPanel(
        controller: _panelController,
        maxHeight: Slidehight,
        minHeight: 30,
        renderPanelSheet: false,
        panel: Container(
          child: SlideUpPage(),
        ),
        body: TransferSuccess(),
      ),
    );
  }
}
