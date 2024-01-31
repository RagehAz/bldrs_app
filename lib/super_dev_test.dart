import 'dart:async';

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:flutter/material.dart';

import 'z_components/buttons/general_buttons/bldrs_box.dart';

/// SUPER_DEV_TEST
Future<void> superDevTestGoX() async {

  // await Nav.goToNewScreen(context: getMainContext(), screen: const RoutingTestScreen());

}

class TheFastTestButton extends StatelessWidget {

  const TheFastTestButton({
    required this.onTap,
    super.key,
  });

  final Function onTap;

  @override
  Widget build(BuildContext context) {

    return BldrsBox(
      height: 60,
      width: 60,
      icon: Iconz.star,
      color: Colorz.bloodTest,
      iconSizeFactor: 0.6,
      onTap: onTap,
    );
  }
}


/// CHAT GBT PROMPTS
/*

for the following flutter method, write group of at-least 7 test methods in one test group to assure its perfectly
working, and call this static function from class called ( ________________ )


------------------

CHAT GBT TRANSLATION PROMPT

for the following list of lines by english and arabic
please figure out the best translation equivalent to each line into [es, it, de, fr, zh, tr, hi, ru, pt, fa]
and please only reply with the list of answers with the same order
do not explain anything, do not illustrate, just reply with translation value directly

don't do, don't write the keys or the source while replying to me
key: translation
key: translation
...

but do directly this without adding descriptions, pronunciations or any extra text
[langCode]
translation
translation
...

 */

// --------------

/*
for the following english and arabic equivalents
please conclude the translation of them in those langs [ar, es, it, de, fr, zh, tr, hi, ru, pt, fa]
write me the key value pairs for each lang in a Map<String, dynamic> {
  langCode: translation,
}

dont use this ' ' or this " " or this ''' ''' or this """ """
just write the values

* */
