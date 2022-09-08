import 'package:app/app/common_widgets/ProductCard.dart';
import 'package:app/app/common_widgets/app_text.dart';
import 'package:app/app/common_widgets/grocery_item_card_widget.dart';
import 'package:app/app/common_widgets/search_bar_widget.dart';
import 'package:app/app/common_widgets/shimmerEffect.dart';
import 'package:app/app/data/app_utils.dart';
import 'package:app/app/helpers/storage.dart';
import 'package:app/app/models/ProductList.dart';
import 'package:app/app/models/grocery_item.dart';
import 'package:app/app/modules/controllers/auth_controller.dart';
import 'package:app/app/modules/controllers/category_controller.dart';
import 'package:app/app/modules/controllers/state_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/styles/colors.dart';
import 'package:app/app/styles/theme.dart';
import 'package:app/screens/address/select_address.dart';
import 'package:app/screens/onboarding/WelcomeScreen.dart';
import 'package:app/screens/product_details/product_details_screen.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shimmer/shimmer.dart';
import 'grocery_featured_Item_widget.dart';
import 'home_banner_widget.dart';
import 'package:geocoder2/geocoder2.dart';

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

  CarouselController _carouselController = CarouselController();
  final AuthController _authController = Get.put(AuthController());
  final CategoryController _categoryController = Get.put(CategoryController());
  final StateController state = Get.put(StateController());

  @override
  void initState() {
    super.initState();
    _categoryController.categoryList();
    _authController.bannerList();
    _authController.exclusiveOfferList();
    _authController.bestSellingOfferList();
    _authController.mostPopularList();
    ("nckdecjewfic${getData('token')}");
    getLoc();
    _authController.socket?.on('new-order', (data) {
      print("new order - ${data}");
    }); 
  }

  dynamic handlePageChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      pageIndex = index;
    });
  }

  GeoData? geoAdress;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
   
      },
      child: GetBuilder<AuthController>(builder: (_context) {
        return Scaffold(
          
          
          appBar: AppBar(
            backgroundColor: Colors.transparent,
  elevation: 0,
            title: AppText(text:"Arshad",),
          ),
          body: SafeArea(
            child: Container(
              child: Center(
                child: Image.asset('assets/images/order_failed_image.png'),
              )
            ),
          ),
        );
      }),
    );
  }

  Widget padded(Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: widget,
    );
  }

  Widget getHorizontalItemSlider(List<GroceryItem> items) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 248,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onItemClicked(context, items[index]);
            },
            child: GroceryItemCardWidget(
              item: items[index],
              heroSuffix: "home_screen",
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 20,
          );
        },
      ),
    );
  }

  Widget getHomeItemSlider(List<Product> items) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 248,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(Routes.PRODUCTDETAIL,
                  parameters: {'id': items[index].id});
            },
            child: ProductCard(
              item: items[index],
              heroSuffix: "home_screen",
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 20,
          );
        },
      ),
    );
  }

  Widget getHomeItemShimmer(List<Product> items) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 248,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ShimmerEffect(174, 250);
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 20,
          );
        },
      ),
    );
  }

  void onItemClicked(BuildContext context, GroceryItem groceryItem) {
    // Get.toNamed(Routes.PRODUCTDETAIL, parameters: {'id': });
  }

  Widget subTitle(String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 30, 29, 31)),
        ),
        Spacer(),
        Text(
          "",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: colorPrimary),
        ),
      ],
    );
  }

  Widget locationWidget() {
    String locationIconPath = "assets/icons/location_icon.svg";
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              locationIconPath,
              width: 15.13,
              height: 18.07,
            ),
            SizedBox(
              width: 1,
            ),
            if (geoAdress?.address != null)
              InkWell(
                onTap: () {
                  Get.to(() => SelectAddress(geoAdress!.latitude,
                      geoAdress!.longitude, geoAdress!.address));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${splitString(geoAdress?.address)}",
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        fontFamily: gilroyFontFamily,
                        color: Color(0xff4C4F4D)),
                  ),
                ),
              )
          ],
        ),
        Row(
          children: [
            // Text(
            //   "Instant",
            //   style: TextStyle(
            //     fontSize: 14,
            //     color: Colors.green,
            //   ),
            // ),
            Text(
              " 20 ",
              style: TextStyle(
                fontSize: 14,
                color: Colors.green,
              ),
            ),

            Text(
              "Min",
              style: TextStyle(
                fontSize: 14,
                color: Colors.green,
              ),
            ),
            Icon(
              Icons.electric_bolt,
              color: Colors.amber,
              size: 15,
            ),
          ],
        )
      ],
    );
  }

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

  String splitString(str) {
    var text = str.split(" ");
    if (text.length > 1) {
      return "${text[0]} ${text[1]}";
    }
    return text;
  }

  // _getAddress(double lat, double lang) async {
  //   // var adress = await location.getLocation(lat, lang);
  // }

  // Future<List<Address>> _getAddress(double lat, double lang) async {
  //   final coordinates = new Coordinates(lat, lang);
  //   List<Address> add = await localeIdentifier(coordinates);
  //   return add;
  // }
}