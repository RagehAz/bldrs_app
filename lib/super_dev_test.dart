import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:fire/super_fire.dart';

/// SUPER_DEV_TEST
Future<void> superDevTest() async {

  // final BuildContext context = getMainContext();
  final List<Map<String, dynamic>> _maps = await Fire.readAllColl(coll: 'bzz');

  int i = 0;
  for (final Map<String, dynamic> map in _maps){

    blog('$i : Doing with ${map['id']}');

    i++;

    // await Fire.deleteDocField(coll: 'bzz', doc: map['id'], field: 'flyersIDs');

  }

  blog('done all : i : $i');

}
