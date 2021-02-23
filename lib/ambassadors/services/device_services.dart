// this should have the functions of device camera, phone gallery, gps location
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// Future<void> takeGalleryPicture() async {
//   final picker = ImagePicker();
//
//   final imageFile = await picker.getImage(
//     source: ImageSource.gallery,
//     maxWidth: 600,
//   );
//
//   if (imageFile == null){return;}
//   else {return File(imageFile.path);}
// }
//
// // final appDir = await sysPaths.getApplicationDocumentsDirectory();
// // final fileName = path.basename(imageFile.path);
// // final savedImage = await _storedLogo.copy('${appDir.path}/$fileName');
// // _selectImage(savedImage);
