import 'package:flutter/material.dart';
import '../../config/app_color.dart';

class CustomButtonIcon extends StatelessWidget {
  const CustomButtonIcon({Key? key, required this.onTap, required this.icon})
      : super(key: key);
  final Function onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.secondary,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () => onTap(),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            icon,
            color: AppColor.dark,
          ),
        ),
      ),
    );
  }
}
