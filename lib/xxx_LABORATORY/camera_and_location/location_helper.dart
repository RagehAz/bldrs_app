import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_API_KEY = 'AIzaSyDQGuhqhKu1mSdNxAbS_BCP8NfCB1ENmaI';

int zoom = 16;
String size = '600x300';
String roadmap = 'satellite'; //roadmap // satellite // hybrid // terrain
String color1 = 'red%7C';
String label = 'B%7C';

class LocationHelper{
  static String generateLocationPreviewImage(double latitude, double longitude){
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=$zoom&size=$size&maptype=$roadmap&markers=color:${color1}label:$label$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}