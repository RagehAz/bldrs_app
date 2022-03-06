import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/b_flyer_loading.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/c_flyer_full_screen.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/c_flyer_hero.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/questions/a_question_structure/c_question_full_screen.dart';
import 'package:bldrs/b_views/z_components/questions/a_question_structure/d_question_hero.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/i_flyer_controller.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/xxx_lab/ask/question/question_model.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

class QuestionStarter extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const QuestionStarter({
    @required this.questionModel,
    @required this.minWidthFactor,
    this.heroTag,
    this.isFullScreen = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final QuestionModel questionModel;
  final double minWidthFactor;
  final bool isFullScreen;
  final String heroTag;
  /// --------------------------------------------------------------------------
  @override
  _QuestionStarterState createState() => _QuestionStarterState();
}

class _QuestionStarterState extends State<QuestionStarter> {
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(true);
// -----------------------------------
  Future<void> _triggerLoading({@required setTo}) async {
    _loading.value = setTo;
    blogLoading(loading: _loading.value);
  }
// -----------------------------------------------------------------------------
//   /// --- FLYER BZ MODEL
//   final ValueNotifier<BzModel> _bzModelNotifier = ValueNotifier(null);
// -----------------------------------------------------------------------------
//   /// FLYER BZ ZONE
//   final ValueNotifier<ZoneModel> _bzZoneNotifier = ValueNotifier(null);
// -----------------------------------------------------------------------------
//   /// FLYER ZONE
//   final ValueNotifier<ZoneModel> _flyerZoneNotifier = ValueNotifier(null);
// -----------------------------------------------------------------------------
  QuestionModel _questionModel;
// -----------------------------------------------------------------------------
//   /// CURRENT SLIDE INDEX
//   ValueNotifier<int> _currentSlideIndex;

  @override
  void initState() {
    _questionModel = widget.questionModel;
    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {
// -----------------------------------------------------------------
//         /// BZ MODEL
//         final BzModel _bzModel = await getFlyerBzModel(
//           context: context,
//           flyerModel: _questionModel,
//         );
// ------------------------------------------
//         /// BZ ZONE
//         final CountryModel _bzCountry = await getFlyerBzCountry(
//           context: context,
//           countryID: _bzModel?.zone?.countryID,
//         );
//         final CityModel _bzCity = await getFlyerBzCity(
//           context: context,
//           cityID: _bzModel?.zone?.cityID,
//         );
// -----------------------------------------------------------------
//         /// FLYER ZONE
//         final CountryModel _flyerCountry = await getFlyerBzCountry(
//           context: context,
//           countryID: widget.flyerModel.zone.countryID,
//         );
//         final CityModel _flyerCity = await getFlyerBzCity(
//           context: context,
//           cityID: widget.flyerModel.zone.cityID,
//         );
// -----------------------------------------------------------------
//         /// STARTING INDEX
//         final int _startingIndex = getPossibleStartingIndex(
//           flyerModel: widget.flyerModel,
//           bzModel: _bzModel,
//           heroTag: widget.heroTag,
//           startFromIndex: widget.startFromIndex,
//         );

        // blog('POSSIBLE STARTING INDEX IS for ${widget.flyerModel.id}: $_startingIndex');

// -----------------------------------------------------------------


        /// SETTERS

        // _bzModelNotifier.value = _bzModel;
        // _bzZoneNotifier.value = getZoneModel(
        //   context: context,
        //   countryModel: _bzCountry,
        //   cityModel: _bzCity,
        //   districtID: _bzModel.zone.districtID,
        // );

        // _flyerZoneNotifier.value = getZoneModel(
        //   context: context,
        //   countryModel: _flyerCountry,
        //   cityModel: _flyerCity,
        //   districtID: widget.flyerModel.zone.districtID,
        // );

        // _currentSlideIndex = ValueNotifier(_startingIndex);
// -----------------------------------------------------------------
        await _triggerLoading(setTo: false);

      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();

    // if (_currentSlideIndex != null){
    //   _currentSlideIndex.dispose();
    // }

  }
// -----------------------------------------------------------------------------
  Future<void> _openFullScreenFlyer() async {

    await context.pushTransparentRoute(
        QuestionFullScreen(
          key: const ValueKey<String>('Flyer_Full_Screen'),
          questionModel: _questionModel,
          minWidthFactor: widget.minWidthFactor,
          heroTag: widget.heroTag,
        )
    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _flyerBoxWidth = FlyerBox.width(context, widget.minWidthFactor);

    return ValueListenableBuilder(
        key: ValueKey<String>('QuestionStarter_${widget.questionModel?.id}'),
        valueListenable: _loading,
        child: FlyerLoading(flyerBoxWidth: widget.minWidthFactor,),
        builder: (_, bool isLoading, Widget child){

          if (isLoading == true){
            return child;
          }

          else {

            return GestureDetector(
              onTap: _openFullScreenFlyer,
              child: QuestionHero(
                key: const ValueKey<String>('Flyer_hero'),
                questionModel: _questionModel,
                minWidthFactor: widget.minWidthFactor,
                isFullScreen: widget.isFullScreen,
                heroTag: widget.heroTag,
              ),
            );

          }

        }
    );
  }
}
