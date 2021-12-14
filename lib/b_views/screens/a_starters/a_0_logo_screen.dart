import 'package:bldrs/b_views/widgets/general/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/c_controllers/a_0_logo_controller.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class LogoScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const LogoScreen({
    // @required this.error,
    // @required this.loading,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<LogoScreen> createState() => _LogoScreenState();
  /// --------------------------------------------------------------------------
}

class _LogoScreenState extends State<LogoScreen> with TickerProviderStateMixin {
// -----------------------------------------------------------------------------
  // final String error;
  // final bool loading;
  AnimationController _scaleController;
  static const int _fadeCycleDuration = 750;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;

    if (_loading.value == true) {
      blog('LOADING --------------------------------------');
    } else {
      blog('LOADING COMPLETE -----------------------------');
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
    super.dispose();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading().then((_) async {
        await controlLogoScreen(context);
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

    traceWidgetBuild(widgetName: 'Logo screen', varName: '_isInit', varValue: _isInit);
    return MainLayout(
      pyramids: Iconz.pyramidzYellow,
      appBarType: AppBarType.non,
      loading: true,
      layoutWidget: Stack(
        children: <Widget>[

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              /// LOGO SLOGAN
              ScaleTransition(
                scale: _scaleController,
                child: const LogoSlogan(
                  showTagLine: true,
                  showSlogan: true,
                  sizeFactor: 0.8,
                ),
              ),

              const SizedBox(
                height: Ratioz.appBarMargin,
              ),

              // if (loading == true)
              //   Center(
              //     child: Loading(
              //       loading: loading,
              //     ),
              //   ),
              //
              // if (error != null)
              //   SuperVerse(
              //     verse: error,
              //     weight: VerseWeight.thin,
              //   ),

              const SizedBox(
                height: Ratioz.appBarMargin,
              ),

            ],
          ),

        ],
      ),
    );
  }
}
