import 'namez_model.dart';
// ---------------------------------------------------------------------------
class Area{
  /// country id
  final String iso3;
  final String province;
  /// Area id
  final String id;
  final String name;
  final List<Namez> names;
  /// dashboard manual switch to deactivate entire cities.
  final bool isActivated;
  /// automatic switch when flyers reach 'city publishing-target ~ 1000 flyers'
  /// then all flyers will be visible to users not only between bzz
  final bool isPublic;


  Area({
    this.iso3,
    this.province,
    this.id,
    this.name,
    this.names,
    this.isActivated,
    this.isPublic,
  });

// Map<String, Object> toMap(){
//   return {
//     'iso3' : iso3,
//     'province' : province,
//     'name' : name,
//     'names' : names,
//
//   };
// }
}
// ---------------------------------------------------------------------------
