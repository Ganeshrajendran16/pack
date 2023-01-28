import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final Function onClick;
  final IconData buttonIcon;
  final String btnText;
  final String subtitle;

  EmptyState(
      {this.title,
      this.onClick,
      this.buttonIcon = Icons.add,
      this.btnText = 'Publish new offers',
      this.subtitle = 'Add new SHops to explore their offers'});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/empty_state.svg',
            height: 200.0,
            width: 200.0,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            '$title',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            '$subtitle',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 14.0,
          ),
        ],
      ),
    );
  }
}
