import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/x_dashboard/zz_widgets/dashboard_layout.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';

class StepperTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const StepperTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _StepperTestScreenState createState() => _StepperTestScreenState();
  /// --------------------------------------------------------------------------
}

class _StepperTestScreenState extends State<StepperTestScreen> {
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
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return DashBoardLayout(
      loading: _loading,
      listWidgets: <Widget>[

        Stepper(
          physics: const NeverScrollableScrollPhysics(),
          // type: StepperType.vertical,
          margin: EdgeInsets.zero,
          // currentStep: 0,
          onStepCancel: (){
            blog('is cancelled');
          },
          onStepContinue: (){
            blog('is continue');
          },
          onStepTapped: (int index){
            blog('is tapped');
          },
          elevation: 0,
          controlsBuilder: (_, ControlsDetails details){

            return const Loading(loading: true);
          },
          steps: [

            Step(
              title: BldrsText.verseInfo(verse: Verse.plain('title')),
              isActive: true,
              label: BldrsText.verseInfo(verse: Verse.plain('label')),
              content: BldrsText.verseInfo(verse: Verse.plain('Content')),
              state: StepState.editing,
              subtitle: BldrsText.verseInfo(verse: Verse.plain('subtitle')),
            ),

            Step(
              title: BldrsText.verseInfo(verse: Verse.plain('title2')),
              subtitle: BldrsText.verseInfo(verse: Verse.plain('subtitle2')),
              content: BldrsText.verseInfo(verse: Verse.plain('Content2')),
              isActive: true,
              label: BldrsText.verseInfo(verse: Verse.plain('label2')),
              state: StepState.error,
            ),

          ],
        ),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
