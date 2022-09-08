import 'package:app/app/modules/controllers/state_controller.dart';
import 'package:app/app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SearchBarWidget2 extends StatefulWidget {
  final String? from;

  SearchBarWidget2(this.from);
  @override
  State<SearchBarWidget2> createState() => _SearchBarWidget2State();
}

class _SearchBarWidget2State extends State<SearchBarWidget2> {
  final String searchIcon = "assets/icons/search_icon.svg";
  final StateController state = Get.put(StateController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Color(0xFFF2F3F2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            searchIcon,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.70,
              child: TextFormField(
                cursorColor: Colors.black,
                autofocus: state.wasOnExploreScreen >= 2 ? false : true,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                    hintText: "Search Product"),
              ))
        ],
      ),
    );
  }
}
