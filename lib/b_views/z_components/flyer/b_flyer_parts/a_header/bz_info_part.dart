import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/max_header.dart';
import 'package:bldrs/d_providers/active_flyer_provider.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BzInfoPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzInfoPart({
    @required this.flyerBoxWidth,
    @required this.bzModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Consumer<ActiveFlyerProvider>(
      child: MaxHeader(
        flyerBoxWidth: flyerBoxWidth,
        bzModel: bzModel,
      ),
      builder: (BuildContext ctx, ActiveFlyerProvider activeFlyerProvider, Widget child){

        final bool _isExpanded = activeFlyerProvider.headerIsExpanded;
        final double _maxHeaderOpacity = activeFlyerProvider.headerPageOpacity;

        if (_isExpanded == true){
          return AnimatedOpacity(
            duration: Ratioz.durationSliding400,
            curve: Curves.easeIn,
            opacity: _maxHeaderOpacity,
            child: child,
          );
        }

        else {
          return Container();
        }

      },
    );

  }
}
