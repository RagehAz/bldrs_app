import 'package:bldrs/z_components/loading/loading.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:flutter/material.dart';

class LoadingFullScreenLayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LoadingFullScreenLayer({
    super.key
  });
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
