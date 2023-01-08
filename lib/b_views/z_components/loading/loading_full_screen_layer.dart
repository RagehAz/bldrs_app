import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:scale/scale.dart';
import 'package:flutter/material.dart';

class LoadingFullScreenLayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LoadingFullScreenLayer({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
        width: Scale.screenWidth(context),
        height: Scale.screenWidth(context),
        child: const Center(
            child: Loading(
              loading: true,
            )
        )
    );
  }
/// --------------------------------------------------------------------------
}
