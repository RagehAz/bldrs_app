import 'package:basics/components/super_box/super_box.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/static_flyer/b_static_header.dart';
import 'package:flutter/material.dart';

class HeaderFootprint extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HeaderFootprint({
    required this.flyerBoxWidth,
    required this.bzModel,
    required this.authorID,
    super.key
  });
  // --------------------
  final double flyerBoxWidth;
  final BzModel bzModel;
  final String authorID;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Disabler(
      isDisabled: true,
      disabledOpacity: 1,
      child: StaticHeader(
        flyerBoxWidth: flyerBoxWidth,
        bzModel: bzModel,
        authorID: authorID,
        flyerShowsAuthor: true,
        showHeaderLabels: true,
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
