import 'dart:io';
import 'package:bldrs/providers/local_db/ldb.dart';
import 'package:flutter/foundation.dart';

import 'location_helper.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });
}

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;
  final String address;

  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
    this.address,
  });
}

class GreatPlaces with ChangeNotifier {
  List<Place> _items = <Place>[];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(String pickedTitle, File pickedImage, PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(latitude: pickedLocation.latitude, longitude: pickedLocation.longitude);
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: updatedLocation,
      image: pickedImage,
      address: address,
    );
    _items.add(newPlace);
    notifyListeners();

  //   LDB.insert('user_places', {
  //     'id': newPlace.id,
  //     'title': newPlace.title,
  //     'image': newPlace.image.path,
  //     'loc_lat': newPlace.location.latitude,
  //     'loc_lng': newPlace.location.longitude,
  //     'address' : newPlace.location.address,
  //   });
  // }
///
//   Future<void> fetchAndSetPlaces() async {
//     final dataList = await DBHelper.getData('user_places');
//     dataList.map((item)=>Place(
//         id: item['id'],
//         title: item['title'],
//         image: File(item['image']),
//         location: PlaceLocation(
//             latitude: item['loc_lat'],
//             longitude: item['loc_lng'],
//             address: item['address'],
//         ),
//     )
//     ).toList();
//     notifyListeners();
}
}
