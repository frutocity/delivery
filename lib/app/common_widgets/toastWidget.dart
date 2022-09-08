import 'package:app/app/styles/assets.dart';
import 'package:app/app/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomeToast extends StatefulWidget {
  String message;
  CustomeToast(this.message);

  @override
  State<CustomeToast> createState() => _CustomeToastState();
}

class _CustomeToastState extends State<CustomeToast> {
  IconData ic = Icons.backspace_rounded;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    const delay = const Duration(seconds: 1);
    Future.delayed(delay, () {
      setState(() {
        ic = Icons.person_add;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: colorWhite),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              rotatingTomato,
              width: 30,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(child: Text(widget.message))
          ]),
    ));
  }
}
