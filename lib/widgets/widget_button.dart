import 'package:flutter/material.dart';

class WidgetButton extends StatefulWidget {
  final IconData? icon;
  final VoidCallback? onTap;
  const WidgetButton({Key? key, this.icon, this.onTap}) : super(key: key);

  @override
  State<WidgetButton> createState() => _WidgetButtonState();
}

class _WidgetButtonState extends State<WidgetButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap!,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Icon(
            widget.icon!,
            color: Colors.white,
            size: 35,
          ),
          decoration: BoxDecoration(
              color: Color(0XFF0B1F38), borderRadius: BorderRadius.circular(8)),
          height: 50,
          width: 110,
        ),
      ),
    );
  }
}
