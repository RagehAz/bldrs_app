import 'package:filers/filers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class GoBackWidget extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const GoBackWidget({
    this.onGoBack,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final Function onGoBack;
  // -----------------------------------------------------------------------------
  @override
  State<GoBackWidget> createState() => _GoBackWidgetState();
  // -----------------------------------------------------------------------------
}

class _GoBackWidgetState extends State<GoBackWidget> {
  /// Stream<List<NoteModel>> _receivedNotesStream;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {
        // -------------------------------

        if (widget.onGoBack != null){
          widget.onGoBack();
        }

        await Nav.pushHomeAndRemoveAllBelow(
          context: context,
          invoker: 'GoBackWidgetTest',
        );
        // -------------------------------
        await _triggerLoading(setTo: false);
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    blog('GoBackWidget : should go back now ahoooooooooooooooooooooooo');

    return Container(
      width: Scale.screenWidth(context),
      height: Scale.screenHeight(context),
      color: Colorz.black230,
      // child: const Center(
      //   child: SuperVerse(
      //     verse:  'Wtf are you doing here ?',
      //     size: 5,
      //     weight: VerseWeight.black,
      //   ),
      // ),
    );

  }
  // -----------------------------------------------------------------------------
}
