import 'dart:async';

import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class NewLogoScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NewLogoScreen({
    // @required this.error,
    // @required this.loading,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<NewLogoScreen> createState() => _NewLogoScreenState();
/// --------------------------------------------------------------------------
}

class _NewLogoScreenState extends State<NewLogoScreen> with TickerProviderStateMixin {
// -----------------------------------------------------------------------------
  // final String error;
  // final bool loading;
  AnimationController _scaleController; /// tamam disposed
  static const int _fadeCycleDuration = 750;
  final ValueNotifier<bool> _offset = ValueNotifier(true); /// tamam disposed
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------------------------------
  /// HAS TO BE A FUTURE TO BE USED IN didChangeDependencies
  Future<void> _triggerLoading() async {
    if (mounted){
      _loading.value = !_loading.value;
      blogLoading(
        loading: _loading.value,
        callerName: 'LogoScreen',
      );
    }
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _fadeCycleDuration),
    );


  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _scaleController.dispose();
    _loading.dispose();
    _offset.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading().then((_) async {

        // await initializeLogoScreen(
        //   context: context,
        //   mounted: mounted,
        // );

        _offset.value = false;

        await _triggerLoading();
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    _scaleController.repeat(reverse: true, min: 0.97, max: 1);

    return MainLayout(
      pyramidsAreOn: true,
      appBarType: AppBarType.non,
      loading: _loading,
      // onBack: (){
      //   Nav.closeApp(context);
      // },
      layoutWidget: Stack(
        children: <Widget>[

          ValueListenableBuilder(
                valueListenable: _offset,
                builder: (_, bool offset, Widget child){

                  blog('rebuilding : $offset');

                  final Tween<double> _tween = Tween<double>(begin: 0, end: 1);

                  return TweenAnimationBuilder<double>(
                    tween: _tween,
                    curve: Curves.easeOut,
                    duration: const Duration(seconds: 3),
                    builder: (BuildContext context, double _val, Widget child) {

                      return Opacity(
                        opacity: _val,
                        child: Padding(
                          padding: EdgeInsets.only(right: _val * 100),
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      width: 200.0 * 3,
                      height: 50.0 * 3,
                      color: Colorz.bloodTest,
                      child: WebsafeSvg.asset(Iconz.bldrsNameSingleLine, fit: BoxFit.fitHeight),
                    ),
                  );

                }
          ),

          // ValueListenableBuilder(
          //     valueListenable: _offset,
          //     builder: (_, double offset, Widget child){
          //
          //       return AnimatedPositioned(
          //         width: 200 * 6.0,
          //         height: 50 * 3.0,
          //         curve: Curves.easeOut,
          //         duration: const Duration(seconds: 1),
          //         right: offset,
          //         child: SuperPositioned(
          //           enAlignment: Alignment.bottomRight,
          //           horizontalOffset: Ratioz.pyramidsWidth,
          //           child: Transform.rotate(
          //             angle: Numeric.degreeToRadian(0),
          //             alignment: Alignment.bottomRight,
          //             child: ,
          //           ),
          //         ),
          //       );
          //
          //     }
          // ),

          DreamBox(
            width: 50,
            height: 50,
            onTap: (){
              _offset.value = !_offset.value;
            },
          ),

        ],
      ),
    );
  }
}

/// TASK : NEED TO PUT THESE STATEMENTS FOR BZZ
///  - NO SUBSCRIPTION FEES
///  - NO SALES COMMISSION
///  - SHARE YOUR WORK AND YOUR SOCIAL MEDIA LINKS
///  - BLDRS COMMUNITY IS REFERRAL COMMUNITY
///  - NO VIOLATIONS ALLOWED
///  ...
