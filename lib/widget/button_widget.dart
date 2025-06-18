import 'package:flutter/material.dart';

class ApplicationButton extends StatelessWidget {
  const ApplicationButton({
    required this.label,
    required this.onPressed,
    required this.size,
    required this.isWithIcon,
    super.key,

    this.color,
    this.borderRadius = 10,
    this.textStyle,
    this.icon
  });
  final String label;
  final Size size;
  final VoidCallback onPressed;
  final Color? color;
  final double borderRadius;
  final TextStyle? textStyle;
  final bool isWithIcon;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return  isWithIcon?
      ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        minimumSize: size, // full-width button
      ),
      icon: icon,
      label: Text(
        label,
        style: textStyle ?? const TextStyle(fontSize: 19, color: Colors.white),
      ),
    )
    
    :
    
    ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        minimumSize: size, 
        
      ),
      child: Text(
        label,
        style: textStyle ?? const TextStyle(fontSize: 19, color: Colors.white),
      ),
    );
  }
}
