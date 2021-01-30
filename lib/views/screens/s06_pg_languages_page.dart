import 'package:bldrs/view_brains/localization/language_class.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/buttons/bt_main.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/main.dart';

class PGLanguageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          right: 10,
          left: 10,
        ),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(Ratioz.ddAppBarCorner)),
            color: Colorz.WhiteGlass),
        child: ListView.builder(
          itemCount: LanguageClass.languageList().length,
          itemBuilder: (context, index) {
            return BTMain(
              buttonVerse: LanguageClass.languageList()[index].langName,
              stretched: true,
              buttonVerseShadow: true,
              buttonColor:
              (LanguageClass.languageList()[index].langName) == (Wordz.languageName(context)) ?
                  Colorz.Yellow : Colorz.WhiteZircon,
              buttonIcon: '',
              splashColor: Colorz.White,
              function:
              // --- CALLING BACK FUTURE ASYNC FUNCTION INTO EBN A7BA ONPRESSED
              // --- YEL3AN MAYTEEN OMMEK
                  () async {
                Locale _temp = await setLocale(LanguageClass.languageList()[index].langCode);
                BldrsApp.setLocale(context, _temp);
                },
            );
            },
        ),
      ),
    );
  }

}
