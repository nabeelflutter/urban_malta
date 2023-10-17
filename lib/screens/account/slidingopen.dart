import 'package:flutter/material.dart';
import 'down.dart';
import 'moneysend.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingUpPaging extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String iban;
  final String amount;
  final bool success;
  const SlidingUpPaging(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.iban,
      required this.amount,
      required this.success})
      : super(key: key);

  @override
  State<SlidingUpPaging> createState() => _SlidingUpPagingState();
}

class _SlidingUpPagingState extends State<SlidingUpPaging> {
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
          child: SlidingUperPage(
             firstName: widget.firstName,
          lastName: widget.lastName,
          iban: widget.iban,
          amount: widget.amount,
          success: widget.success,
          ),
        ),
        body: MoneySend(
          firstName: widget.firstName,
          lastName: widget.lastName,
          iban: widget.iban,
          amount: widget.amount,
          success: widget.success,
        ),
      ),
    );
  }
}
