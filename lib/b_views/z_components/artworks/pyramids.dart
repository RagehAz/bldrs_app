import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/bldrs_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

enum PyramidType{
  yellow,
  crystalYellow,

  white,
  crystalWhite,

  crystalBlue,
  glass,

  non,
}

class Pyramids extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const Pyramids({
    @required this.pyramidType,
    @required this.loading,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PyramidType pyramidType;
  final ValueNotifier<bool> loading;
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
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  String getPyramid(PyramidType type){

    switch (type){
      case PyramidType.yellow:        return Iconz.pyramidsYellow; break;
      case PyramidType.crystalYellow: return Iconz.pyramidzYellow; break;
      case PyramidType.white:         return Iconz.pyramidsWhite; break;
      case PyramidType.crystalWhite:  return Iconz.pyramidzWhite; break;
      case PyramidType.crystalBlue:   return Iconz.pyramidsCrystal; break;
      case PyramidType.glass:         return Iconz.pyramidsGlass; break;
      case PyramidType.non:           return null; break;
      default: return Iconz.pyramidzYellow;
    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel _userModel = UsersProvider.proGetMyUserModel(context);
    final String _pyramidIcon = _userModel?.isAdmin == true ? Iconz.pyramidsCrystal : getPyramid(widget.pyramidType);
    final Color _pyramidColor = _userModel?.isAdmin == true ? Colorz.red255 : null;

    return Positioned(
      bottom: 0,
      right: 0,
      child: SizedBox(
        width: Ratioz.pyramidsWidth,
        height: Ratioz.pyramidsHeight,
        child: GestureDetector(
          onDoubleTap: () async {

            // if (_userModel?.isAdmin == true){
              await Nav.goToNewScreen(
                context: context,
                screen: const BldrsDashBoard(),
              );

            // }

          },
          child: widget.loading == null ?

          WebsafeSvg.asset(_pyramidIcon, color: _pyramidColor)

              :

          ValueListenableBuilder(
            valueListenable: widget.loading,
            child: WebsafeSvg.asset(_pyramidIcon, color: _pyramidColor),
            builder: (_, bool loading, Widget child){

              if (loading == true) {
                _controller.repeat(reverse: true);
              }

              else {
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
