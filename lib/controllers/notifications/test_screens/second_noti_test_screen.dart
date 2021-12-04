import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:flutter/material.dart';

class SecondNotiTestScreen extends StatelessWidget {
  const SecondNotiTestScreen({Key key}) : super(key: key);

//   final String thing;
//
//   const SecondNotiTestScreen({
//     @required this.thing,
// });

  @override
  Widget build(BuildContext context) {

    // log(thing);

    return MainLayout(
      pyramids: Iconz.PyramidsWhite,
      layoutWidget: Column(
        children: <Widget>[

          const Stratosphere(),

          Container(
            width: 300,
            height: 400,
            color: Colorz.bloodTest,
            child: Container(),
          ),

        ],
      ),


    );
  }
}
