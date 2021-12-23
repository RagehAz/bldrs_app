import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/y_views/a_starters/a_0_logo_screen_view.dart';
import 'package:bldrs/c_controllers/a_0_logo_controller.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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
    blogLoading(loading: _loading.value);
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
        await initializeLogoScreen(context);
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
      pyramidsAreOn: true,
      appBarType: AppBarType.non,
      // loading: true,
      layoutWidget: LogoScreenView(
        scaleController: _scaleController,
      ),
    );
  }
}
