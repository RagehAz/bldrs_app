// import 'package:basics/helpers/classes/checks/tracers.dart';
// import 'package:bldrs/a_models/b_bz/bz_model.dart';
// import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
// import 'package:bldrs/a_models/f_flyer/publication_model.dart';
// import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
// import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
// import 'package:fire/super_fire.dart';
// import 'package:flutter/cupertino.dart';

/// SUPER_DEV_TEST
Future<void> superDevTest() async {

  // final BuildContext context = getMainContext();
  // final List<Map<String, dynamic>> _maps = await Fire.readAllColl(coll: 'bzz');
  //
  // int i = 0;
  // for (final Map<String, dynamic> map in _maps){
  //
  //   blog('$i : Doing with ${map['id']}');
  //
  //   i++;
  //
  //   final BzModel? _bz = BzModel.decipherBz(map: map, fromJSON: false);
  //
  //   final List<FlyerModel> _flyers = await FlyerProtocols.fetchFlyers(
  //     context: context,
  //     flyersIDs: _bz?.flyersIDs,
  //   );
  //
  //   PublicationModel _publication = PublicationModel.emptyModel;
  //
  //   for (final FlyerModel _flyer in _flyers){
  //
  //     _publication = PublicationModel.insertFlyerInPublications(
  //         pub: _publication,
  //         flyerID: _flyer.id!,
  //         toState: _flyer.publishState!,
  //     );
  //
  //   }
  //
  //   await Fire.updateDocField(
  //       coll: 'bzz',
  //       doc: _bz!.id!,
  //       field: 'publication',
  //       input: _publication.toMap(),
  //   );
  //
  // }
  //
  // blog('done all : i : $i');

}
