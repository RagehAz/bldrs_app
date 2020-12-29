import 'dart:io';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/space/stratosphere.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/test_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as sysPaths;
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class MaxCameraScreen extends StatefulWidget {
  @override
  _MaxCameraScreenState createState() => _MaxCameraScreenState();
}

class _MaxCameraScreenState extends State<MaxCameraScreen> {
  final _titleController = TextEditingController();
  File _storedImage;
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
  }

  // void _selectPlace(double lat, double lng){
  //   _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  // }

  void _savePlace(){
    if (_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null){
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage, _pickedLocation);
    // Navigator.of(context).pop();
  }

  Future<void> _takeCameraPicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null){
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await sysPaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    _selectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;


    return MainLayout(
      appBarType: AppBarType.Basic,
      appBarRowWidgets: <Widget>[

        DreamBox(
          height: 40,
          width: 40,
          boxMargins: EdgeInsets.all(5),
          icon: Iconz.Camera,
          iconSizeFactor: 0.8,
          color: Colorz.Nothing,
          boxFunction: _takeCameraPicture,
        ),

        DreamBox(
          height: 40,
          // width: 40,
          boxMargins: EdgeInsets.all(5),
          icon: Iconz.Save,
          iconSizeFactor: 0.5,
          verse: 'Save Place',
          color: Colorz.Nothing,
          boxFunction: (){
            print('stored image : $_storedImage');
            print('picked image : $_pickedImage');
            _savePlace();
          },

        ),

      ],

      layoutWidget: Column(
        children: <Widget>[

          Stratosphere(),

          Center(
            child: Container(
              height: screenWidth * 0.8,
              width: screenWidth * 0.8,
              child: _storedImage == null ?
              DreamBox(
                height: screenWidth * 0.8,
                icon: Iconz.DumUniverse,
              ) :
              Image.file(
                _storedImage,
                fit: BoxFit.cover,
                width: screenWidth * 0.8,
              ),
            ),
          ),

          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: _titleController,
          ),

          Container(
            width: screenWidth,
            // height: screenWidth * 0.5,
            child: FutureBuilder(
              future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
              builder:(ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting ?
              Center(
                child: CircularProgressIndicator(),
              ) :
              Consumer<GreatPlaces>(
                child: SuperVerse(
                  verse: 'bo bo bo',
                ),
                builder: (ctx, greatPlaces, ch) =>
                greatPlaces.items.length <= 0 ? ch :
                ListView.builder(
                  itemCount: greatPlaces.items.length,
                  itemBuilder: (ctx, i) =>
                      DreamBox(
                        height: 50,
                        iconFile: greatPlaces.items[i].image,
                        verse: greatPlaces.items[i].title,
                        secondLine: greatPlaces.items[i].address,
                        boxFunction: (){

                        },
                      ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
