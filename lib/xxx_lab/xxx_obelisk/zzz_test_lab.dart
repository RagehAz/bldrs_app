import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/stacks/flyers_shelf.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_controllers/a_1_home_controller.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/xxx_dashboard/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestLab extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const TestLab({Key key}) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _TestLabState createState() => _TestLabState();
}
/// --------------------------------------------------------------------------
class _TestLabState extends State<TestLab> with SingleTickerProviderStateMixin {

  ScrollController _scrollController;
  AnimationController _animationController;
  UiProvider _uiProvider;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _scrollController = ScrollController();

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _uiProvider = Provider.of<UiProvider>(context, listen: false);

    // works
    // Provider.of<FlyersProvider>(context,listen: false).fetchAndSetBzz();

    // hack around
    // Future.delayed(Duration.zero).then((_){
    //   Provider.of<FlyersProvider>(context,listen: true).fetchAndSetBzz();
    // });

    super.initState();
  }

// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      // _triggerLoading().then((_) async {
      //   /// do Futures here
      //   unawaited(_triggerLoading(function: () {
      //     /// set new values here
      //   }));
      // });
    }
    _isInit = false;
    super.didChangeDependencies();
  }


//   File _file;

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
//     double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------

    // double _gWidth = _screenWidth * 0.4;
    // double _gHeight = _screenWidth * 0.6;

    // final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: true);

    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      // loading: _loading,
      appBarRowWidgets: const <Widget>[],
      layoutWidget: Center(
        child: OldMaxBounceNavigator(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            children: <Widget>[

              const Stratosphere(),

              /// DO SOMETHING
              WideButton(
                  color: Colorz.red255,
                  verse: 'DO THE DAMN THING',
                  icon: Iconz.star,
                  onTap: () async {

                    _uiProvider.triggerLoading(setLoadingTo: true);


                    _uiProvider.triggerLoading(setLoadingTo: false);

                  }),


              /// MANIPULATE LOCAL ASSETS TESTING
              // GestureDetector(
              //   onTap: () async {
              //
              //     _triggerLoading();
              //
              //     File file = await Imagers.getFileFromLocalRasterAsset(
              //       context: context,
              //       width: 200,
              //       localAsset: Iconz.BldrsAppIcon,
              //     );
              //
              //     if (file != null){
              //       setState(() {
              //         _file = file;
              //       });
              //
              //     }
              //
              //     _triggerLoading();
              //   },
              //   child: Container(
              //     width: 100,
              //     height: 100,
              //     color: Colorz.facebook,
              //     alignment: Alignment.center,
              //     child: SuperImage(
              //       _file ?? Iconz.DumAuthorPic,
              //       width: 100,
              //       height: 100,
              //
              //     ),
              //   ),
              // ),

              /// PROMOTED FLYERS
              Selector<FlyersProvider, List<FlyerModel>>(
                selector: (_, FlyersProvider flyersProvider) => flyersProvider.promotedFlyers,
                builder: (BuildContext ctx, List<FlyerModel> flyers, Widget child){

                  return

                      FlyersShelf(
                        title: 'Promoted Flyers',
                        titleIcon: Iconz.flyer,
                        flyers: flyers,
                        flyerOnTap: (FlyerModel flyer) => onFlyerTap(context: context, flyer: flyer),
                        onScrollEnd: (){blog('REACHED SHELF END');},
                      );

                },
              ),


            ],
          ),
        ),
      ),
    );
  }
}
