

import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/b_views/z_components/specs/spec_label.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SpecsWrapper extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecsWrapper({
    @required this.boxWidth,
    @required this.specs,
    @required this.onSpecTap,
    @required this.xIsOn,
    this.padding = Ratioz.appBarMargin,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double boxWidth;
  final List<SpecModel> specs;
  final ValueChanged<SpecModel> onSpecTap;
  final bool xIsOn;
  final dynamic padding;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      width: boxWidth,
      padding: superMargins(margins: padding),
      child: Wrap(
        spacing: Ratioz.appBarPadding,
        children: <Widget>[

          ...List<Widget>.generate(specs.length,
                  (int index) {

                final SpecModel _spec = specs[index];

                return SpecLabel(
                    xIsOn: xIsOn,
                    spec: _spec,
                    onTap: () => onSpecTap(_spec),
                );

              }),

        ],
      ),
    );

  }
}
