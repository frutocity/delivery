import 'package:app/app/common_widgets/app_text.dart';
import 'package:app/app/models/CategoryList.dart';
import 'package:app/app/models/category_item.dart';
import 'package:flutter/material.dart';

class CategoryItemCardWidget extends StatelessWidget {
  CategoryItemCardWidget({this.item, this.color = Colors.blue});
  final CategoryData? item;

  final height = 200.0;

  final width = 175.0;

  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withOpacity(0.7),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 120,
            width: 120,
            child: imageWidget(),
          ),
          SizedBox(
            height: 60,
            child: Center(
              child: AppText(
                text: item?.name ?? "",
                textAlign: TextAlign.center,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      child: Image.network(
        item?.photo ?? "",
        fit: BoxFit.contain,
      ),
    );
  }
}
