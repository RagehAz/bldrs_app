import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:flutter/material.dart';

class BzBuilder extends StatelessWidget {
  // --------------------------------------------------------------------------
  const BzBuilder({
    required this.bzID,
    required this.builder,
    super.key
  });
  // ------------------------
  final String? bzID;
  final Widget Function(bool loading, BzModel? bzModel) builder;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return FutureBuilder(
        future: BzProtocols.fetchBz(bzID: bzID),
        builder: (context, AsyncSnapshot<BzModel?> snap) {

          return builder(snap.connectionState == ConnectionState.waiting, snap.data);

        }
        );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
