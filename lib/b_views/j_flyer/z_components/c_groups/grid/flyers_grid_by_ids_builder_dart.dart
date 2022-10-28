import 'dart:async';

import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/flyer_selection_stack.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart';
import 'package:flutter/material.dart';

class FutureFlyer extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const FutureFlyer({
    @required this.flyerID,
    @required this.heroPath,
    @required this.flyerBoxWidth,
    this.isSelected = false,
    this.onFlyerNotFound,
    this.onFlyerOptionsTap,
    this.onSelectFlyer,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final String flyerID;
  final String heroPath;
  final double flyerBoxWidth;
  final bool isSelected;
  final ValueChanged<FlyerModel> onSelectFlyer;
  final ValueChanged<FlyerModel> onFlyerOptionsTap;
  final Function onFlyerNotFound;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: FlyerProtocols.fetchFlyer(
          context: context,
          flyerID: flyerID,
        ),
        builder: (_, AsyncSnapshot<Object> snap){

          final FlyerModel _flyerModel = snap?.data;

          /// WHILE LOADING
          if (Streamer.connectionIsLoading(snap) == true){
            return FlyerLoading(
              flyerBoxWidth: flyerBoxWidth,
              animate: false,
            );
          }

          /// FLYER IS LOADED
          else {

            /// FLYER IS NOT FOUND
            if (_flyerModel == null){

              if (onFlyerNotFound != null){
                unawaited(onFlyerNotFound());
              }

              return const SizedBox();
            }

            /// FLYER IS FOUND
            else {
              return FlyerSelectionStack(
                flyerModel: _flyerModel,
                flyerBoxWidth: flyerBoxWidth,
                heroPath: heroPath,
                onSelectFlyer: onSelectFlyer == null ? null : () => onSelectFlyer(_flyerModel),
                onFlyerOptionsTap: onFlyerOptionsTap == null ? null : () => onFlyerOptionsTap(_flyerModel),
                isSelected: isSelected,
              );
            }

          }

        }
    );

  }
  // -----------------------------------------------------------------------------
}
