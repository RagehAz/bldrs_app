import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/bldrs_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

class Pyramids extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const Pyramids({
    @required this.pyramidsIcon,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String pyramidsIcon;
  /// --------------------------------------------------------------------------
  @override
  _PyramidsState createState() => _PyramidsState();
  /// --------------------------------------------------------------------------
}

class _PyramidsState extends State<Pyramids> with TickerProviderStateMixin {
// -----------------------------------------------------------------------------
  AnimationController _controller;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Ratioz.duration750ms,
    );

  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel _userModel = UsersProvider.proGetMyUserModel(context);
    final String _pyramidIcon = _userModel?.isAdmin == true ? Iconz.pyramidsCrystal : widget.pyramidsIcon;
    final Color _pyramidColor = _userModel?.isAdmin == true ? Colorz.red255 : null;

    return Positioned(
      bottom: 0,
      right: 0,
      child: SizedBox(
        width: Ratioz.pyramidsWidth,
        height: Ratioz.pyramidsHeight,
        child: GestureDetector(
          onDoubleTap: () async {


            if (_userModel?.isAdmin == true){
              await goToNewScreen(
                context: context,
                screen: const BldrsDashBoard(),
              );

            }

          },
          child: Selector<UiProvider, bool>(
            selector: (_, UiProvider uiProvider) => uiProvider.isLoading,
            child: WebsafeSvg.asset(_pyramidIcon, color: _pyramidColor),
            // shouldRebuild: ,
            builder: (BuildContext context, bool loading, Widget child){

              if (loading == true) {
                _controller.repeat(reverse: true);
              } else {
                _controller.forward();
              }

              return FadeTransition(
                opacity: _controller,
                child: child,
              );

            },
          ),
        ),
      ),
    );
  }
}
