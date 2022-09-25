import 'package:app/app/helpers/toast_service.dart';
import 'package:app/app/modules/controllers/auth_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/styles/colors.dart';
import 'package:app/app/styles/heroTags.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class MobileVerification extends StatefulWidget {
  const MobileVerification({Key? key}) : super(key: key);

  @override
  State<MobileVerification> createState() => _MobileVerificationState();
}

class _MobileVerificationState extends State<MobileVerification> {
  final RoundedRectangleBorder r = new RoundedRectangleBorder(
      side: BorderSide.none, borderRadius: new BorderRadius.circular(5.0));
  CircleBorder c = const CircleBorder(side: BorderSide.none);
  List numList = [];
  List otpList = [];
  IconData ic = Icons.backspace_rounded;
  final AuthController _authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authController.Socket();
    _authController.socket?.on('msg', (data) {
      print('dataaa ' + data);
    });
  }

  getNumber() {
    return numList.join("");
  }

  getOtp() {
    return otpList.join("");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (_context) {
      return Scaffold(
        body: Column(children: [
          SizedBox(
            height: 80,
          ),
          _authController.isOtpSent
              ? SizedBox(
                  height: 80,
                  child: ListView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xffEFEFEF),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "${otpList.length > index ? otpList[index] : ""}",
                            style: TextStyle(
                              fontSize: 24,
                              color: colorBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                )
              : Hero(
                  tag: signUpScreenTags,
                  child: Material(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: 52,
                      // alignment: Alignment.centerLeft,
                      // padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: colorGrey.withOpacity(0.4), width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                width: 2,
                                color: colorGrey.withOpacity(0.4),
                              )),
                            ),
                            child: Text(
                              "+91",
                              style: TextStyle(
                                fontSize: 17,
                                color: Color(0xff909090),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Text(
                                numList.length > 0
                                    ? getNumber()
                                    : "Enter Your Mobile Number",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff393939),
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          SizedBox(
            height: 50,
          ),
          ButtonTheme(
            minWidth: MediaQuery.of(context).size.width - 20,
            height: 52,
            shape: ShapeBorder.lerp(r, c, 0.1),
            buttonColor: colorPrimary,
            colorScheme: ColorScheme.dark(),
            child: ElevatedButton(
              onPressed: _authController.isOtpSent
                  ? () {
                      if (otpList.length == 0) {
                        return ToastService.show(
                            "Enter the 4 Digit OTP sent to your mobile number");
                      }
                      if (otpList.length < 4) {
                        return ToastService.show(
                            "Enter the 4 Digit OTP sent to your mobile number");
                      }

                      _authController.verifyOtpBody["otp"] =
                          int.parse(getOtp());
                      _authController.verifyOtp(_authController.verifyOtpBody);
                    }
                  : () {
                      if (numList.length == 0) {
                        return ToastService.show("Enter Your Mobile Number");
                      }
                      if (numList.length < 10) {
                        return ToastService.show("Invaild Mobile Number");
                      }
                      Map<String, dynamic> body = {};
                      body["phone"] = getNumber();
                      print(body);
                      _authController.sendOtp(body);
                      if (!_authController.isLoading) {
                        setState(() {
                          // _authController.isOtpSent = true;
                        });
                      }
                    },
              child: Text(
                  _authController.isOtpSent
                      ? "VERIFY OTP"
                      : "Send Otp".toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  )),
            ),
          ),
          Expanded(
            child: Center(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: _authController.isOtpSent
                          ? () {
                              if (index == 11) {
                                return;
                              }
                              if (index == 9) {
                                setState(() {
                                  otpList.removeLast();
                                });
                                return;
                              }
                              if (index != 9 || index != 11) {
                                if (otpList.length == 4) {
                                  return;
                                }
                                setState(() {
                                  otpList.add(index == 10 ? 0 : index + 1);
                                  if (otpList.length == 4) {
                                    _authController.verifyOtpBody["otp"] =
                                        int.parse(getOtp());
                                    _authController.verifyOtp(
                                        _authController.verifyOtpBody);
                                  }
                                });
                              }
                            }
                          : () {
                              if (index == 11) {
                                return;
                              }
                              if (index == 9) {
                                setState(() {
                                  numList.removeLast();
                                });
                                return;
                              }
                              if (index != 9 || index != 11) {
                                if (numList.length == 10) {
                                  return;
                                }
                                setState(() {
                                  numList.add(index == 10 ? 0 : index + 1);
                                });
                              }
                            },
                      child: index == 9
                          ? Icon(
                              Icons.backspace_rounded,
                              color: colorBlack,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Text(
                                    "${index == 11 ? "OK" : index == 10 ? "0" : index + 1}",
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: colorBlack,
                                    ),
                                  ),
                                ]),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: Color(0xffEFEFEF),
                        shadowColor: Colors.transparent,
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ]),
      );
    });
  }
}
