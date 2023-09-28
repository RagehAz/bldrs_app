import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/space/scale.dart';

class GoBackWidget extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const GoBackWidget({
    this.onGoBack,
    super.key
  });
  // -----------------------------------------------------------------------------
  final Function? onGoBack;
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
  Future<void> _triggerLoading({required bool setTo}) async {
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

    if (_isInit && mounted) {
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {
        // -------------------------------

        widget.onGoBack?.call();

        await Nav.pushHomeAndRemoveAllBelow(
          context: context,
          invoker: 'GoBackWidgetTest',
          homeRoute: RouteName.home,
        );
        // -------------------------------
        await _triggerLoading(setTo: false);
      });

    }

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
