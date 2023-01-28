import 'package:awomowa_vendor/providers/countrylistProvider.dart';
import 'package:awomowa_vendor/widgets/drop_down_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Countrycodedro extends StatefulWidget {
final GlobalDropDownButton globalDropDownButton;

  const Countrycodedro({Key key, this.globalDropDownButton}) : super(key: key);

  

  @override
  _CountrycodedroState createState() => _CountrycodedroState();
}

class _CountrycodedroState extends State<Countrycodedro> {
  Widget build(BuildContext context) {
    return Consumer<ContryListProvider>(
      builder: (BuildContext context, ContryListProvider countrylistprovider,
          Widget child) {
        return Scaffold(
          
          body:GlobalDropDownButton(
            items: countrylistprovider.countrycodelist.phoneCodeList.map((e) => e.phoneCodeList).toList(),
          )
        );
      },
    );
  }
}
