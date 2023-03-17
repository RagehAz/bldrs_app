import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:mapper/mapper.dart';
import 'package:numeric/numeric.dart';
import 'package:flutter/foundation.dart';
import 'package:scale/scale.dart';
import 'package:layouts/layouts.dart';
import 'package:bldrs/x_dashboard/a_dashboard_home/a_lock_screen/lock_wheel.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class LockScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const LockScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<LockScreen> createState() => _LockScreenState();
/// --------------------------------------------------------------------------
}

class _LockScreenState extends State<LockScreen> {
  // --------------------
  int _indexA = 3;
  int _indexB = 5;
  int _indexC = 1;
  String _a;
  String _b;
  String _c;
  // --------------------
  @override
  void initState() {
    super.initState();

    final int _iconsLength = LockWheel.standardLockIcons.length;
    _indexA = Numeric.createRandomIndex(listLength: _iconsLength);
    _indexB = Numeric.createRandomIndex(listLength: _iconsLength);
    _indexC = Numeric.createRandomIndex(listLength: _iconsLength);

    _a = LockWheel.standardLockIcons[_indexA].key;
    _b = LockWheel.standardLockIcons[_indexB].key;
    _c = LockWheel.standardLockIcons[_indexC].key;
  }
  // --------------------
  void _changeA(String a){_a = a;}
  void _changeB(String b){_b = b;}
  void _changeC(String c){_c = c;}
  // --------------------
  Future<void> _onGoBeyond() async {

    final List<String> _selections = <String>[_a, _b, _c];
    const List<String> _correctCode = <String>[
      Iconz.dvRageh,
      Iconz.viewsIcon,
      Iconz.contAfrica,
    ];

    final bool _areTheSame = Mapper.checkListsAreIdentical(
        list1: _selections,
        list2: _correctCode,
    );

    if (_areTheSame == true || kDebugMode == true){

      await TopDialog.showTopDialog(
        context: context,
        firstVerse: Verse.plain('Alf Mabrouk , etfaddal m3ana'),
        color: Colorz.green255,
        textColor: Colorz.white255,
        milliseconds: 500,
      );

      await Nav.goBack(context: context, invoker: 'Go Beyond', passedData: true);

    }

    else {

      await TopDialog.showTopDialog(
        context: context,
        firstVerse: Verse.plain('You Shall Not pass'),
        color: Colorz.red255,
        textColor: Colorz.white255,
      );

    }

  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    const String _message = 'Only Those on hold of the sacred words shall pass to the way beyond';

    return MainLayout(
      pyramidsAreOn: true,
      title: Verse.plain('Lock Test'),
      appBarType: AppBarType.basic,
      child: Container(
        width: Scale.screenWidth(context),
        height: Scale.screenHeight(context),
        color: Colorz.black50,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(
              width: Scale.screenWidth(context) * 0.8,
              child: const SuperVerse(
                verse: Verse(
                  id: _message,
                  translate: false,
                ),
                // size: 2,
                weight: VerseWeight.thin,
                color: Colorz.yellow200,
                maxLines: 5,
                italic: true,
                shadow: true,
                margin: 20,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                LockWheel(
                  onChanged: _changeA,
                  startingIndex: _indexA,
                ),

                const SizedBox(width: 10,),

                LockWheel(
                  onChanged: _changeB,
                  startingIndex: _indexB,
                ),

                const SizedBox(width: 10,),

                LockWheel(
                  onChanged: _changeC,
                  startingIndex: _indexC,
                ),

              ],
            ),

            DreamBox(
              width: Scale.screenWidth(context) * 0.7,
              height: 70,
              margins: 20,
              // verse: Verse.plain('Go Beyond'),
              icon: Iconz.dvGouran,
              iconColor: Colorz.white125,
              iconSizeFactor: 0.8,
              onTap: _onGoBeyond,
            ),

          ],
        ),
      ),
    );

  }
}
