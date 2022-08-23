import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:flutter/cupertino.dart';

// ---------------------------------------------------------------------------

/// SYNC

// -----------------------------
Future<void> onSyncSpecPickers({
  @required BuildContext context,
  @required ValueNotifier<List<SpecPicker>> initialSpecPickers,
  @required ValueNotifier<List<SpecPicker>> tempSpecPickers,
}) async {

  blog('onSyncSpecPickers');

  SpecPicker.blogSpecsPickers(tempSpecPickers.value);

}
// ---------------------------------------------------------------------------
