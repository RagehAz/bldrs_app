import 'dart:async';

import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

/// SUPER_DEV_TEST
Future<void> superDevTestGoX() async {

  await Nav.goToNewScreen(
      context: getMainContext(),
      screen: const Blah(),
  );

}


class Blah extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const Blah({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  _BlahState createState() => _BlahState();
  /// --------------------------------------------------------------------------
}

class _BlahState extends State<Blah> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(true);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await _triggerLoading(setTo: true);
        /// GO BABY GO
        await _triggerLoading(setTo: false);

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }

  bool loading = false;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MainLayout(
      loading: _loading,
      appBarType: AppBarType.basic,
      appBarRowWidgets: [

        AppBarButton(
          loading: loading,
          verse: Verse.plain(loading == true ? 'loading' : 'not loading'),
          onTap: (){

            loading = _loading.value;

            _triggerLoading(setTo: !loading);

            setState(() {
              loading = !loading;
            });



          },
        ),

      ],
      child: Container(),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
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
please conclude the translation of them in those langs [es, it, de, fr, zh, tr, hi, ru, pt, fa]
write me the key value pairs for each lang in a Map<String, dynamic> {
  'langCode': 'translation',
}

* */
