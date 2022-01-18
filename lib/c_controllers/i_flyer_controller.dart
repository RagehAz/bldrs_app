import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------
Future<BzModel> getFlyerBzModel({
  @required BuildContext context,
  @required FlyerModel flyerModel,
}) async {

  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  final BzModel _bzModel = await _bzzProvider.fetchBzModel(
      context: context,
      bzID: flyerModel.bzID
  );

  return _bzModel;
}
// -----------------------------------------------------------------------------
