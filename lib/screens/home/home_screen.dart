import 'package:app/app/common_widgets/ProductCard.dart';
import 'package:app/app/common_widgets/app_button.dart';
import 'package:app/app/common_widgets/app_text.dart';
import 'package:app/app/common_widgets/grocery_item_card_widget.dart';
import 'package:app/app/common_widgets/search_bar_widget.dart';
import 'package:app/app/common_widgets/shimmerEffect.dart';
import 'package:app/app/common_widgets/slider.dart';
import 'package:app/app/data/app_utils.dart';
import 'package:app/app/helpers/storage.dart';
import 'package:app/app/helpers/toast_service.dart';
import 'package:app/app/models/ProductList.dart';
import 'package:app/app/models/grocery_item.dart';
import 'package:app/app/modules/controllers/auth_controller.dart';
import 'package:app/app/modules/controllers/category_controller.dart';
import 'package:app/app/modules/controllers/state_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/styles/colors.dart';
import 'package:app/app/styles/theme.dart';
import 'package:app/screens/address/select_address.dart';
import 'package:app/screens/cart/checkout_bottom_sheet.dart';
import 'package:app/screens/onboarding/WelcomeScreen.dart';
import 'package:app/screens/product_details/product_details_screen.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../app/models/NewOrderResponse.dart';
import 'grocery_featured_Item_widget.dart';
import 'home_banner_widget.dart';
import 'package:geocoder2/geocoder2.dart';

// const TWO_PI

class TaskScreen extends StatefulWidget {
  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final List carouselList = [
    Slides("E Shopping", "Explore top organic fruits & grab them",
        "assets/images/banner_image.png", 1),
    Slides("Delivery on the way", "Get your order by speed delivery",
        "assets/images/pulses.png", 1),
    Slides("Delivery Arrived", "Order is arrived at your Place",
        "assets/images/banner_image.png", 1)
  ];
  LocationData? _currentPosition;
  String? _address, _dateTime;
  int pageIndex = 0;
  String orderStatus = "null";

  CarouselController _carouselController = CarouselController();
  final AuthController _authController = Get.put(AuthController());
  final CategoryController _categoryController = Get.put(CategoryController());
  final StateController state = Get.put(StateController());

  @override
  void initState() {
    super.initState();
    // getLoc();
    orderStatus = getData('orderStatus');

    print("nckdecjewfic${getData('token')}");
    _authController.Socket().on('test-pong', (data) {
      ToastService.show(data);
    });
    _authController.Socket().on('new-order', (data) {
      print("new order - ${data}");
      ToastService.show("new order");
      showOrderBottomSheet(context, data);
    });
    _authController.Socket().on('give_order_status', (data) {
      _authController.Socket().emit('send_order_status', {
        "order": data,
        "body": {
          "_id": "${getData('employee-id')}",
          "lat": "${_currentPosition?.latitude}",
          "long": "${_currentPosition?.latitude}"
        }
      });
    });
    print("laksss:${_authController.orderdata}");
  }

  dynamic handlePageChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      pageIndex = index;
    });
  }

  showOrderBottomSheet(context, data) {
    Future.delayed(Duration.zero, () {
      showBottomSheet(context, data);
    });
  }

  GeoData? geoAdress;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: GetBuilder<AuthController>(builder: (_context) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: AppText(
                text: getData('user')['name'] == null
                    ? ""
                    : "${getData('user')['name'] ?? ""}",
              ),
            ),
            body: _authController.orderRec == false
                ? SafeArea(
                    child: Container(
                        child: Center(
                      child:
                          Image.asset('assets/images/order_failed_image.png'),
                    )),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  AppText(text: "New Order"),
                                  Container(
                                      child: Center(
                                    child: Image.asset(
                                        'assets/images/order_failed_image.png'),
                                  )),
                                  // CircularCountDownTimer(
                                  //   duration: 60,
                                  //   initialDuration: 0,
                                  //   controller: CountDownController(),
                                  //   width: MediaQuery.of(context).size.width / 3,
                                  //   height: MediaQuery.of(context).size.height / 3,
                                  //   ringColor: Colors.grey[300]!,
                                  //   ringGradient: null,
                                  //   fillColor: colorPrimary,
                                  //   fillGradient: null,
                                  //   backgroundGradient: null,
                                  //   strokeWidth: 2.0,
                                  //   strokeCap: StrokeCap.round,
                                  //   textStyle: TextStyle(
                                  //       fontSize: 33.0,
                                  //       color: colorBlack,
                                  //       fontWeight: FontWeight.bold),
                                  //   textFormat: CountdownTextFormat.S,
                                  //   isReverse: true,
                                  //   isReverseAnimation: true,
                                  //   isTimerTextShown: true,
                                  //   autoStart: true,
                                  //   onStart: () {
                                  //     // debugPrint('Countdown Started');
                                  //   },
                                  //   onComplete: () {
                                  //     // debugPrint('Countdown Ended');
                                  //   },
                                  //   onChange: (String timeStamp) {
                                  //     // debugPrint('Countdown Changed $timeStamp');
                                  //   },
                                  // )
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //       border: Border.all(color: colorBlack),
                                  //       borderRadius:
                                  //           BorderRadius.all(Radius.circular(10000))),
                                  //   child: Image.asset(
                                  //     'assets/images/order_failed_image.png',
                                  //     fit: BoxFit.fill,
                                  //   ),
                                  // )

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            AppText(text: "Total cost"),
                                            Text("₹ 20")
                                          ],
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              _authController.orderdata[
                                                              'lat'] !=
                                                          null &&
                                                      _authController.orderdata[
                                                              'long'] !=
                                                          null
                                                  ? MapUtils.openMap(0.0, 0.0)
                                                  : ToastService.show(
                                                      "User Current Location Not Found");
                                              ;
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: colorPrimary),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text('Open map'),
                                                Icon(Icons.arrow_forward)
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AppText(text: "Address:-"),
                                      ),
                                      Text(
                                          "${_authController.orderdata['address']}"),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AppText(text: "Items:-"),
                                      ),
                                      ListView.builder(
                                          itemCount: 3,
                                          shrinkWrap: true,
                                          itemBuilder: (context, i) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text("Tomato (2kg)"),
                                                Text("₹ 20")
                                              ],
                                            );
                                          })
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Center(
                              child: Stack(children: [
                            Visibility(
                                visible: orderStatus == "Order Picked",
                                child: slider()),
                            Visibility(
                                visible: orderStatus == "Reach Destination",
                                child: slider()),
                            Visibility(
                                visible: orderStatus == "Order Delivered",
                                child: slider()),
                          ])),
                        ],
                      ),
                    ),
                  ));
      }),
    );
  }

  Widget slider() {
    return SliderButton(
        action: () {
          if (orderStatus == "Order Picked") {
            setData('orderStatus', "Reach Destination");
            // setState(() {
            //   orderStatus = "Reach Destination";
            // });
          } else if (orderStatus == "Reach Destination") {
            setData('orderStatus', "Order Delivered");
          } else if (orderStatus == "Order Delivered") {
            setData('orderStatus', '');
            _authController.orderRec = false;
          }
        },
        label: Text(
          "${orderStatus}    ",
          style: TextStyle(
              color: Color(0xff4a4a4a),
              fontWeight: FontWeight.w500,
              fontSize: 17),
        ),
        icon: Icon(Icons.arrow_forward));
  }

  listTile(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        child: ListTile(
          title: Text('$title'),
          subtitle: Text("${subtitle}"),
        ),
      ),
    );
  }

  // Widget padded(Widget widget) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 25),
  //     child: widget,
  //   );
  // }

  // Widget getHorizontalItemSlider(List<GroceryItem> items) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 10),
  //     height: 248,
  //     child: ListView.separated(
  //       padding: EdgeInsets.symmetric(horizontal: 20),
  //       itemCount: items.length,
  //       scrollDirection: Axis.horizontal,
  //       itemBuilder: (context, index) {
  //         return GestureDetector(
  //           onTap: () {
  //             onItemClicked(context, items[index]);
  //           },
  //           child: GroceryItemCardWidget(
  //             item: items[index],
  //             heroSuffix: "home_screen",
  //           ),
  //         );
  //       },
  //       separatorBuilder: (BuildContext context, int index) {
  //         return SizedBox(
  //           width: 20,
  //         );
  //       },
  //     ),
  //   );
  // }

  // Widget getHomeItemSlider(List<Product> items) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 10),
  //     height: 248,
  //     child: ListView.separated(
  //       padding: EdgeInsets.symmetric(horizontal: 20),
  //       itemCount: items.length,
  //       scrollDirection: Axis.horizontal,
  //       itemBuilder: (context, index) {
  //         return GestureDetector(
  //           onTap: () {
  //             Get.toNamed(Routes.PRODUCTDETAIL,
  //                 parameters: {'id': items[index].id});
  //           },
  //           child: ProductCard(
  //             item: items[index],
  //             heroSuffix: "home_screen",
  //           ),
  //         );
  //       },
  //       separatorBuilder: (BuildContext context, int index) {
  //         return SizedBox(
  //           width: 20,
  //         );
  //       },
  //     ),
  //   );
  // }

  // Widget getHomeItemShimmer(List<Product> items) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 10),
  //     height: 248,
  //     child: ListView.separated(
  //       padding: EdgeInsets.symmetric(horizontal: 20),
  //       itemCount: 3,
  //       scrollDirection: Axis.horizontal,
  //       itemBuilder: (context, index) {
  //         return ShimmerEffect(174, 250);
  //       },
  //       separatorBuilder: (BuildContext context, int index) {
  //         return SizedBox(
  //           width: 20,
  //         );
  //       },
  //     ),
  //   );
  // }

  // void onItemClicked(BuildContext context, GroceryItem groceryItem) {
  //   // Get.toNamed(Routes.PRODUCTDETAIL, parameters: {'id': });
  // }

  // Widget subTitle(String text) {
  //   return Row(
  //     children: [
  //       Text(
  //         text,
  //         style: TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.w600,
  //             color: Color.fromARGB(255, 30, 29, 31)),
  //       ),
  //       Spacer(),
  //       Text(
  //         "",
  //         style: TextStyle(
  //             fontSize: 18, fontWeight: FontWeight.w600, color: colorPrimary),
  //       ),
  //     ],
  //   );
  // }

  // Widget locationWidget() {
  //   String locationIconPath = "assets/icons/location_icon.svg";
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           SvgPicture.asset(
  //             locationIconPath,
  //             width: 15.13,
  //             height: 18.07,
  //           ),
  //           SizedBox(
  //             width: 1,
  //           ),
  //           if (geoAdress?.address != null)
  //             InkWell(
  //               onTap: () {
  //                 Get.to(() => SelectAddress(geoAdress!.latitude,
  //                     geoAdress!.longitude, geoAdress!.address));
  //               },
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Text(
  //                   "${splitString(geoAdress?.address)}",
  //                   maxLines: 2,
  //                   style: TextStyle(
  //                       fontSize: 10,
  //                       fontWeight: FontWeight.w600,
  //                       fontFamily: gilroyFontFamily,
  //                       color: Color(0xff4C4F4D)),
  //                 ),
  //               ),
  //             )
  //         ],
  //       ),
  //       Row(
  //         children: [
  //           // Text(
  //           //   "Instant",
  //           //   style: TextStyle(
  //           //     fontSize: 14,
  //           //     color: Colors.green,
  //           //   ),
  //           // ),
  //           Text(
  //             " 20 ",
  //             style: TextStyle(
  //               fontSize: 14,
  //               color: Colors.green,
  //             ),
  //           ),

  //           Text(
  //             "Min",
  //             style: TextStyle(
  //               fontSize: 14,
  //               color: Colors.green,
  //             ),
  //           ),
  //           Icon(
  //             Icons.electric_bolt,
  //             color: Colors.amber,
  //             size: 15,
  //           ),
  //         ],
  //       )
  //     ],
  //   );
  // }
  Location location = Location();
  LatLng _initialcameraposition = LatLng(0.5937, 0.9629);
  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _initialcameraposition = LatLng(_currentPosition!.latitude ?? 3.13,
        _currentPosition?.longitude ?? 36.11);
    location.onLocationChanged.listen((LocationData currentLocation) {
      _currentPosition = currentLocation;
      _initialcameraposition = LatLng(_currentPosition?.latitude ?? 3.13,
          _currentPosition?.longitude ?? 36.11);

      DateTime now = DateTime.now();
      _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
      // _getAddress(_currentPosition?.latitude ?? 3.13,
      //         _currentPosition?.longitude ?? 36.11)
      //     .then((value) {
      //   setState(() {
      //     _address = "${value.first.addressLine}";
      //   });
      // });
    });
    GeoData GeoAdress = await Geocoder2.getDataFromCoordinates(
        latitude: _currentPosition?.latitude ?? 40.714224,
        longitude: _currentPosition?.longitude ?? -73.961452,
        googleMapApiKey: "AIzaSyDDXLeo4ai8XyDVJxILKlNoRiE3gP7mt4s");

    if (GeoAdress.address != null) {
      setState(() {
        geoAdress = GeoAdress;
      });
    }
  }

  // String splitString(str) {
  //   var text = str.split(" ");
  //   if (text.length > 1) {
  //     return "${text[0]} ${text[1]}";
  //   }
  //   return text;
  // }

  // _getAddress(double lat, double lang) async {
  //   // var adress = await location.getLocation(lat, lang);
  // }

  // Future<List<Address>> _getAddress(double lat, double lang) async {
  //   final coordinates = new Coordinates(lat, lang);
  //   List<Address> add = await localeIdentifier(coordinates);
  //   return add;
  // }

  void showBottomSheet(context, data) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return CheckoutBottomSheet(
            data: data,
          );
        });
  }
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double lat, double long) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if (await canLaunchUrlString(googleUrl)) {
      await launchUrlString(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
