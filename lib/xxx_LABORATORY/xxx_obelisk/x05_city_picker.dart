import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';

class CityPicker extends StatefulWidget {
  @override
  _CityPickerState createState() => _CityPickerState();
}

class _CityPickerState extends State<CityPicker> {
  String countryValue;
  String stateValue;
  String cityValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      layoutWidget: Center(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 600,
            child:
            Column(
              children: [
                SelectState(
                  onCountryChanged: (value) {
                    setState(() {
                      countryValue = value;
                    });
                  },
                  onStateChanged:(value) {
                    setState(() {
                      stateValue = value;
                    });
                  },
                  onCityChanged:(value) {
                    setState(() {
                      cityValue = value;
                    });
                  },

                ),
                // InkWell(
                //   onTap:(){
                //     print('country selected is $countryValue');
                //     print('country selected is $stateValue');
                //     print('country selected is $cityValue');
                //   },
                //   child: Text(' Check')
                // )
              ],
            )
        ),
      ),
    );
  }
}
