import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/bz_page_headline.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class BzNameBelowLogoPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzNameBelowLogoPart({
    @required this.flyerBoxWidth,
    @required this.bzModel,
    @required this.bzZone,
    @required this.headerIsExpanded,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final BzModel bzModel;
  final ZoneModel bzZone;
  final ValueNotifier<bool> headerIsExpanded;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// TASK : TEMP
    return ValueListenableBuilder<bool>(
        valueListenable: headerIsExpanded,
        child: Container(
          color: Colorz.black80,
          child: BzPageHeadline(
            flyerBoxWidth: flyerBoxWidth,
            bzPageIsOn: true,
            bzModel: bzModel,
            bzZone: bzZone,
          ),
        ),
        builder: (_, bool _headerIsExpanded, Widget child){

          if (_headerIsExpanded == true){
            return child;
          }

          else {
            return const SizedBox();
          }

        }
    );

  }
}
