import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text("Custom Buttons")), 
        body: Padding(
          padding: const EdgeInsets.all(16), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              CustomButton(label: "Submit", 
                icon: Icons.check, 
                type: ButtonType.primary),
              SizedBox(height: 16), 
              CustomButton(label: "Time", 
                icon: Icons.access_time, 
                type: ButtonType.secondary, 
                iconPos: IconPosition.right),
              SizedBox(height: 16),
              CustomButton(label: "Account", 
                icon: Icons.account_tree, 
                type: ButtonType.disabled, 
                iconPos: IconPosition.right),
            ],
          ),
        ),
      ),
    );
  }
}

enum ButtonType { primary, secondary, disabled }
enum IconPosition { left, right }

// widget that creates a button with a label and an icon.
class CustomButton extends StatelessWidget {
  final String label; 
  final IconData icon; 
  final ButtonType type; 
  final IconPosition iconPos; 

  const CustomButton({
    Key? key,
    required this.label,
    required this.icon,
    this.type = ButtonType.primary, 
    this.iconPos = IconPosition.left, 
  }) : super(key: key);

  // background color button type.
  Color get color {
    switch (type) {
      case ButtonType.primary:
        return Colors.blue;
      case ButtonType.secondary:
        return Colors.green;
      case ButtonType.disabled:
        return Colors.grey.shade400;
    }
  }

  Color get textColor {
    return type == ButtonType.disabled ? Colors.grey.shade600 : Colors.grey.shade800;
  }


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: type == ButtonType.disabled ? null : () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16), 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        minimumSize: Size(double.infinity, 48), 
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, 
        children: iconPos == IconPosition.left
            ? [
                Icon(icon, color: textColor), 
                const SizedBox(width: 8), 
                Text(label, style: TextStyle(color: textColor))
              ]
            : [
                Text(label, style: TextStyle(color: textColor)), 
                const SizedBox(width: 8), 
                Icon(icon, color: textColor)
              ],
      ),
    );
  }
}
