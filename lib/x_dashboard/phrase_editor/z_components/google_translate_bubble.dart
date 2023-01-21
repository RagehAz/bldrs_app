import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/e_back_end/f_cloud/google_translator.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class GoogleTranslateBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const GoogleTranslateBubble({
    @required this.enController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TextEditingController enController;
  /// --------------------------------------------------------------------------
  @override
  State<GoogleTranslateBubble> createState() => _GoogleTranslateBubbleState();
  /// --------------------------------------------------------------------------
}

class _GoogleTranslateBubbleState extends State<GoogleTranslateBubble> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<String> _translation = ValueNotifier('');
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
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

    widget.enController.addListener(() {
      _translate(widget.enController.text);
    });

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        /// FUCK

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _translation.dispose();
    super.dispose();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _translate(String text) async {

    if (mounted == true && TextCheck.isEmpty(text) == false && text.length > 1){

      final String _result = await GoogleTranslate.translate(
        input: text,
        from: 'en',
        to: 'ar',
      );

      setNotifier(
        notifier: _translation,
        mounted: mounted,
        value: _result,
      );

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Bubble(
      bubbleHeaderVM: const BubbleHeaderVM(
        headlineVerse: Verse(text: 'Google translate', translate: false),
        leadingIcon: Iconz.comGooglePlus,
      ),
      childrenCentered: true,
      columnChildren: <Widget>[

        const SizedBox(height: 5),

        ValueListenableBuilder(
            valueListenable: _translation,

            builder: (_, String value, Widget child){

              return SuperVerse(
                verse: Verse.plain(value),
                labelColor: Colorz.black255,
                onTap: () => Keyboard.copyToClipboard(
                    context: context,
                    copy: value,
                ),
              );

            }
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
