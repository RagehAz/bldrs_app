import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/super_lock/lock_wheel.dart';
import 'package:flutter/material.dart';

class LockTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const LockTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<LockTestScreen> createState() => _LockTestScreenState();
/// --------------------------------------------------------------------------
}

class _LockTestScreenState extends State<LockTestScreen> {
  // --------------------
  static const int _indexA = 3;
  static const int _indexB = 5;
  static const int _indexC = 1;
  String _a;
  String _b;
  String _c;
  // --------------------
  @override
  void initState() {
    super.initState();
    _a = LockWheel.standardLockIcons[_indexA].key;
    _b = LockWheel.standardLockIcons[_indexB].key;
    _c = LockWheel.standardLockIcons[_indexC].key;
  }
  // --------------------
  void _changeA(String a){_a = a;}
  void _changeB(String b){_b = b;}
  void _changeC(String c){_c = c;}
  // --------------------
  Future<void> _onOpenSesame() async {

    final List<String> _selections = <String>[_a, _b, _c];
    const List<String> _correctCode = <String>[
      'assets/icons/dv_rageh.svg',
      'assets/icons/gi_views.svg',
      'assets/icons/cont_africa.svg',
    ];

    final bool _areTheSame = Mapper.checkListsAreIdentical(
        list1: _selections,
        list2: _correctCode,
    );

    if (_areTheSame == true){

      await TopDialog.showTopDialog(
        context: context,
        firstVerse: Verse.plain('Alf Mabrouk , etfaddal m3ana'),
        color: Colorz.green255,
        textColor: Colorz.white255,
      );

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
      sectionButtonIsOn: false,
      pageTitleVerse: Verse.plain('Lock Test'),
      appBarType: AppBarType.basic,
      confirmButtonModel: ConfirmButtonModel(
        firstLine: Verse.plain('Open Sesame'),
        onTap: _onOpenSesame,
      ),
      layoutWidget: Container(
        width: Scale.superScreenWidth(context),
        height: Scale.superScreenHeightWithoutSafeArea(context),
        color: Colorz.black50,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(
              width: Scale.superScreenWidth(context) * 0.8,
              child: const SuperVerse(
                verse: Verse(
                  text: _message,
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

          ],
        ),
      ),
    );

  }
}
