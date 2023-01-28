import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconBgColor;
  final Function onTap;
  final Widget trailing;
  final Widget subtitle;

  const SettingsItem(
      {this.title,
      this.icon,
      this.iconBgColor,
      this.onTap,
      this.trailing,
      this.subtitle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        subtitle: subtitle,
        leading: Card(
          color: iconBgColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 16.0),
        ),
        trailing: trailing,
      ),
    );
  }
}
