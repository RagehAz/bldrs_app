import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/records/publish_time_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;

// -----------------------------------------------------------------------------
int getInitialMyBzScreenTabIndex(BuildContext context){
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  final BzTab _currentTab = _uiProvider.currentBzTab;
  final int _index = BzModel.getBzTabIndex(_currentTab);
  return _index;
}
// -----------------------------------------------------------------------------
void onChangeMyBzScreenTabIndexWhileAnimation({
  @required BuildContext context,
  @required TabController tabController,
}){

  if (tabController.indexIsChanging == false) {

    final int _indexFromAnimation = (tabController.animation.value).round();
    onChangeMyBzScreenTabIndex(
      context: context,
      index: _indexFromAnimation,
      tabController: tabController,
    );

  }

}
// -----------------------------------------------------------------------------
void onChangeMyBzScreenTabIndex({
  @required BuildContext context,
  @required int index,
  @required TabController tabController,
}) {

  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

  final BzTab _newBzTab = BzModel.bzTabsList[index];
  final BzTab _previousBzTab = _uiProvider.currentBzTab;

  /// ONLY WHEN THE TAB CHANGES FOR REAL IN THE EXACT MIDDLE BETWEEN BUTTONS
  if (_newBzTab != _previousBzTab){
    // blog('index is $index');
    _uiProvider.setCurrentBzTab(_newBzTab);
    tabController.animateTo(index,
        curve: Curves.easeIn,
        duration: Ratioz.duration150ms
    );
  }

}
// -----------------------------------------------------------------------------

  /// BZ FLYERS PAGE

// -------------------------------
Future<void> onFlyerOptionsTap({
  @required BuildContext context,
  @required FlyerModel flyer,
}) async {

  blog('SHOULD DELETE THIS FLYER');
  blog('if flyer is only 48 hours old');

  final String _age = Timers.getSuperTimeDifferenceString(
    from: PublishTime.getPublishTimeFromTimes(
        times: flyer.times,
        state: FlyerState.published,
    )?.time,
    to: DateTime.now(),
  );

  await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      buttonHeight: 40,
      numberOfWidgets: 2,
      title: 'published $_age',
      builder: (_, PhraseProvider pro){

        return <Widget>[

          BottomDialog.wideButton(
            context: context,
            verse: 'Edit flyer',
            verseCentered: true,
            onTap: () => _onEditFlyer(flyer),
          ),

          BottomDialog.wideButton(
            context: context,
            verse: 'Delete flyer',
            verseCentered: true,
            onTap: () => _onDeleteFlyer(flyer),
          ),


        ];

      }
  );

}
// -----------------------------------------------------------------------------
Future<void> _onEditFlyer(FlyerModel flyer) async {
  blog('should edit flyer');
}
// -----------------------------------------------------------------------------
Future<void> _onDeleteFlyer(FlyerModel flyer) async {
  blog('should delete flyer now');
}
// -----------------------------------------------------------------------------
