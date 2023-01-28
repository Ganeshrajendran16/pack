import 'package:flutter/material.dart';

class GenderSelector extends StatelessWidget {
  final String label;
  final Icon icon;
  final bool isSelected;
  final Function onTap;

  const GenderSelector({this.label, this.icon, this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: InkWell(
          onTap: onTap,
          child: Card(
            margin: EdgeInsets.all(0),
            color: isSelected ? Color(0xffffc324) : Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  children: [
                    icon,
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      label,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
