import 'dart:convert';

import 'package:app/app/common_widgets/app_text.dart';
import 'package:app/app/helpers/storage.dart';
import 'package:app/app/helpers/toast_service.dart';
import 'package:app/app/styles/assets.dart';
import 'package:app/app/styles/colors.dart';
import 'package:app/screens/address/map.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SelectAddress extends StatefulWidget {
  double lat;
  double long;
  String currentAddress;
  SelectAddress(this.lat, this.long, this.currentAddress);

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  TextEditingController _searchcontroller = TextEditingController();
  String kGoogleApiKey = "AIzaSyDDXLeo4ai8XyDVJxILKlNoRiE3gP7mt4s";
  List<Prediction> adressList = [];
  String? description;
  @override
  void initState() {
    super.initState();
    // des();
  }

  // des() {
  //   setState(() {
  //     description = ad;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorTransparent,
          elevation: 0,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_sharp,
                color: colorBlack,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: "Search For Your Location",
                ),
              ),
              Container(
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
                          onChanged: (val) {
                            findPlace(val);
                          },
                          controller: _searchcontroller,
                          cursorColor: Colors.black,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText: "Address Search e.g. jhotwara"),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: <Widget>[
                  Expanded(child: Divider()),
                  Text("OR"),
                  Expanded(child: Divider()),
                ]),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => MapScreen(
                      widget.lat, widget.long, widget.currentAddress));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Icon(
                          Icons.my_location,
                          color: colorPrimary,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: AppText(
                          text: "Use Current Location",
                          color: colorPrimary,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 10,
                color: colorGreyExtraLight,
              ),
              _searchcontroller.text.isNotEmpty
                  ? ListView.builder(
                      itemCount: adressList.length > 4 ? 4 : adressList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        print("respose****${getData('recent_search_address')}");

                        return SingleChildScrollView(
                            child: _searchcontroller.text != ""
                                ? Column(
                                    children: [
                                      InkWell(
                                        onTap: (() {
                                          Geocoder2.getDataFromAddress(
                                                  address: adressList[index]
                                                          .description ??
                                                      "",
                                                  googleMapApiKey:
                                                      'AIzaSyDDXLeo4ai8XyDVJxILKlNoRiE3gP7mt4s')
                                              .then((value) => Get.to(() =>
                                                  MapScreen(
                                                      value.latitude,
                                                      value.longitude,
                                                      adressList[index]
                                                              .description ??
                                                          "")));
                                          // Get.to(() => Map());
                                        }),
                                        child: ListTile(
                                          leading:
                                              Icon(Icons.location_on_outlined),
                                          title: AppText(
                                              text: adressList[index]
                                                      .terms![index]
                                                      .value ??
                                                  ""),
                                          subtitle: Text(
                                              adressList[index].description ??
                                                  ""),
                                        ),
                                      ),
                                      Divider(), //
                                    ],
                                  )
                                : getData('recent_search_address'));
                        // Container(
                        //   child: Text("${adressList[index].description}"),
                        // );
                      })
                  : Container(),
              // Column(
              //   children: [
              //     AppText(
              //       text: "Recent Search",
              //     ),
              //     Row(
              //       children: [Icon(Icons.replay_circle_filled_rounded)],
              //     )
              //   ],
              // )
            ],
          ),
        ));
  }

  void findPlace(String Placename) async {
    if (Placename.length > 1) {
      String autoCompleteUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$Placename&types=address&components=country:in&location=${widget.lat}%2C${widget.long}&radius=50000&key=AIzaSyDDXLeo4ai8XyDVJxILKlNoRiE3gP7mt4s";

      var res = await http.get(Uri.parse(autoCompleteUrl),
          headers: {"Content-Type": "application/json"});

      if (res == 'failed') {
        return;
      }
      var ress = AdressList.fromJson(json.decode(res.body));
      setState(() {
        adressList = ress.predictions!;
      });
      if (_searchcontroller.text.isEmpty) {
        setState(() {
          adressList = [];
        });
      }
    }
  }
}
// To parse this JSON data, do
//
//     final adressList = adressListFromJson(jsonString);

AdressList adressListFromJson(String str) =>
    AdressList.fromJson(json.decode(str));

String adressListToJson(AdressList data) => json.encode(data.toJson());

class AdressList {
  AdressList({
    this.predictions,
    this.status,
  });

  List<Prediction>? predictions;
  String? status;

  factory AdressList.fromJson(Map<String, dynamic> json) => AdressList(
        predictions: List<Prediction>.from(
            json["predictions"].map((x) => Prediction.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "predictions": List<dynamic>.from(predictions!.map((x) => x.toJson())),
        "status": status,
      };
}

class Prediction {
  Prediction({
    this.description,
    this.matchedSubstrings,
    this.placeId,
    this.reference,
    this.structuredFormatting,
    this.terms,
    this.types,
  });

  String? description;
  List<MatchedSubstring>? matchedSubstrings;
  String? placeId;
  String? reference;
  StructuredFormatting? structuredFormatting;
  List<Term>? terms;
  List<String>? types;

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
        description: json["description"],
        matchedSubstrings: List<MatchedSubstring>.from(
            json["matched_substrings"]
                .map((x) => MatchedSubstring.fromJson(x))),
        placeId: json["place_id"],
        reference: json["reference"],
        structuredFormatting:
            StructuredFormatting.fromJson(json["structured_formatting"]),
        terms: List<Term>.from(json["terms"].map((x) => Term.fromJson(x))),
        types: List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "matched_substrings":
            List<dynamic>.from(matchedSubstrings!.map((x) => x.toJson())),
        "place_id": placeId,
        "reference": reference,
        "structured_formatting": structuredFormatting!.toJson(),
        "terms": List<dynamic>.from(terms!.map((x) => x.toJson())),
        "types": List<dynamic>.from(types!.map((x) => x)),
      };
}

class MatchedSubstring {
  MatchedSubstring({
    this.length,
    this.offset,
  });

  int? length;
  int? offset;

  factory MatchedSubstring.fromJson(Map<String, dynamic> json) =>
      MatchedSubstring(
        length: json["length"],
        offset: json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "length": length,
        "offset": offset,
      };
}

class StructuredFormatting {
  StructuredFormatting({
    this.mainText,
    this.mainTextMatchedSubstrings,
    this.secondaryText,
  });

  String? mainText;
  List<MatchedSubstring>? mainTextMatchedSubstrings;
  String? secondaryText;

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) =>
      StructuredFormatting(
        mainText: json["main_text"],
        mainTextMatchedSubstrings: List<MatchedSubstring>.from(
            json["main_text_matched_substrings"]
                .map((x) => MatchedSubstring.fromJson(x))),
        secondaryText: json["secondary_text"],
      );

  Map<String, dynamic> toJson() => {
        "main_text": mainText,
        "main_text_matched_substrings": List<dynamic>.from(
            mainTextMatchedSubstrings!.map((x) => x.toJson())),
        "secondary_text": secondaryText,
      };
}

class Term {
  Term({
    this.offset,
    this.value,
  });

  int? offset;
  String? value;

  factory Term.fromJson(Map<String, dynamic> json) => Term(
        offset: json["offset"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "value": value,
      };
}
