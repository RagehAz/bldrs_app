import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/b_flyer_loading.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/c_flyer_full_screen.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/c_flyer_hero.dart';
import 'package:bldrs/c_controllers/i_flyer_controller.dart';
import 'package:bldrs/d_providers/active_flyer_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlyerStarter extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerStarter({
    @required this.flyerModel,
    @required this.minWidthFactor,
    this.isFullScreen = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final double minWidthFactor;
  final bool isFullScreen;
  /// --------------------------------------------------------------------------
  @override
  _FlyerStarterState createState() => _FlyerStarterState();
}

class _FlyerStarterState extends State<FlyerStarter> {
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(true);
// -----------------------------------
  Future<void> _triggerLoading({@required setTo}) async {
    _loading.value = setTo;
    blogLoading(loading: _loading.value);
  }
// -----------------------------------------------------------------------------
  /// --- FLYER BZ MODEL
  final ValueNotifier<BzModel> _bzModelListenableValue = ValueNotifier(null);
// -----------------------------------
  Future<void> _setBz(BzModel bzModel) async {
    _bzModelListenableValue.value = bzModel;
  }
// -----------------------------------------------------------------------------
  FlyerModel _flyerModel;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _flyerModel = widget.flyerModel;
    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {

        final BzModel _bzModel = await getFlyerBzModel(
          context: context,
          flyerModel: _flyerModel,
        );

        await _setBz(_bzModel);

        await _triggerLoading(setTo: false);

      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        key: ValueKey<String>('flyerID_${widget.flyerModel.id}'),
        valueListenable: _loading,
        child: FlyerLoading(flyerWidthFactor: widget.minWidthFactor,),
        builder: (_, bool isLoading, Widget child){

          if (isLoading == true){

            return child;

          }

          else {

            return ValueListenableBuilder(
                valueListenable: _bzModelListenableValue,
                builder: (_, BzModel bzModel, Widget child){

                  if (bzModel == null || widget.flyerModel == null){
                    return FlyerLoading(flyerWidthFactor: widget.minWidthFactor,);
                  }

                  else {

                    return GestureDetector(
                      onTap: () async {

                        blog('getting city and county on flyer ${_flyerModel.id} tap');

                        await onOpenFullScreenFlyer(
                          context: context,
                          bzModel: bzModel,
                        );

                        await context.pushTransparentRoute(
                            FlyerFullScreen(
                              flyerModel: _flyerModel,
                              bzModel: bzModel,
                              minWidthFactor: widget.minWidthFactor,
                            )
                        );
                      },
                      child: FlyerHero(
                        flyerModel: _flyerModel,
                        bzModel: bzModel,
                        minWidthFactor: widget.minWidthFactor,
                        isFullScreen: widget.isFullScreen,
                      ),
                    );

                  }

                }
            );

          }

        }
    );
  }
}
