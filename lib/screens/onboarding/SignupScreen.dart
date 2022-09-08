import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/styles/assets.dart';
import 'package:app/app/styles/colors.dart';
import 'package:app/app/styles/heroTags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 60,
        ),
        Image.asset(appLogo),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.MOBILEVERIFY);
          },
          child: Hero(
            tag: signUpScreenTags,
            child: Material(
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 52,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: colorGrey.withOpacity(0.4), width: 2),
                    borderRadius: BorderRadius.circular(10)),
                child: Text("Enter Your Mobile Number",
                    style: TextStyle(fontSize: 12, color: Color(0xff393939))),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Text(
            "OR",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 160.0,
              height: 45,
              child: OutlinedButton(
                onPressed: null,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0))),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Login with"),
                      Image.asset(
                        googleLogo,
                        width: 26,
                      ),
                    ]),
              ),
            )
          ],
        )
      ]),
    );
  }
}
