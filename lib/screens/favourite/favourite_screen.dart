import 'package:app/app/common_widgets/app_text.dart';
import 'package:flutter/cupertino.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: AppText(
          text: "No Favorite Items",
          fontWeight: FontWeight.w600,
          color: Color(0xFF7C7C7C),
        ),
      ),
    );
  }
}
