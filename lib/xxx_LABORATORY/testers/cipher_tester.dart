import 'package:bldrs/models/enums/enum_bldrs_section.dart';
import 'package:bldrs/models/enums/enum_bond_state.dart';
import 'package:bldrs/models/enums/enum_bz_form.dart';
import 'package:bldrs/models/enums/enum_bz_type.dart';
import 'package:bldrs/models/enums/enum_connection_state.dart';
import 'package:bldrs/models/enums/enum_contact_type.dart';
import 'package:bldrs/models/enums/enum_flyer_state.dart';
import 'package:bldrs/models/enums/enum_flyer_type.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class CipherTest extends StatefulWidget {

  @override
  _CipherTestState createState() => _CipherTestState();
}

class _CipherTestState extends State<CipherTest> {
  String printOut;

  @override
  Widget build(BuildContext context) {

    int x = 1;
    int i = 0;

    List<Map<String, Object>> ciphers = [
      {'name' : functionStringer(decipherBldrsSection), 'function' : decipherBldrsSection(x)},
      {'name' : functionStringer(cipherBldrsSection),   'function' : cipherBldrsSection(bldrsSectionsList[i])},

      {'name' : functionStringer(decipherBondState),   'function' : decipherBondState(x)},
      {'name' : functionStringer(cipherBondState),   'function' : cipherBondState(bondStatesList[i])},

      {'name' : functionStringer(decipherBzForm),   'function' : decipherBzForm(x)},
      {'name' : functionStringer(cipherBzForm),   'function' : cipherBzForm(bzFormsList[i])},

      {'name' : functionStringer(decipherBzType),   'function' : decipherBzType(x)},
      {'name' : functionStringer(cipherBzType),   'function' : cipherBzType(bzTypesList[i])},

      {'name' : functionStringer(decipherConnectionState),   'function' : decipherConnectionState(x)},
      {'name' : functionStringer(cipherConnectionState),   'function' : cipherConnectionState(connectionStatesList[i])},

      {'name' : functionStringer(decipherContactType),   'function' : decipherContactType(x)},
      {'name' : functionStringer(cipherContactType),   'function' : cipherContactType(contactTypesList[i])},

      {'name' : functionStringer(decipherFlyerState),   'function' : decipherFlyerState(x)},
      {'name' : functionStringer(cipherFlyerState),   'function' : cipherFlyerState(flyerStatesList[i])},

      {'name' : functionStringer(decipherFlyerType),   'function' : decipherFlyerType(x)},
      {'name' : functionStringer(cipherFlyerType),   'function' : cipherFlyerType(flyerTypesList[i])},

    ];

    // im feeling that this is stupid and can be automated some how !!

    return MainLayout(
      tappingRageh: (){print('------------');},
      appBarType: AppBarType.Scrollable,
      appBarRowWidgets: <Widget>[

        SuperVerse(
          verse: printOut,
          labelColor: Colorz.WhiteAir,
          margin: 5,
          size: 3,
        ),
      ],

      layoutWidget: ListView(
        children: <Widget>[

          Stratosphere(),

          ...List.generate(ciphers.length, (index) =>
              DreamBox(
                height: 40,
                verse: ciphers[index]['name'],
                verseScaleFactor: 0.7,
                boxMargins: EdgeInsets.all(5),
                boxFunction: (){
                  dynamic functionReturns = ciphers[index]['function'];
                  print(functionReturns);
                  setState(() {
                    printOut = '$functionReturns' ;
                  });
                },
              ),),

        ],
      ),
    );
  }
}
