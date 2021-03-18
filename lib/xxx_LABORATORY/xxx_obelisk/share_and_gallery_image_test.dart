import 'package:bldrs/controllers/drafters/zoomable_widget.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';

class ShareAndAddImageTest extends StatefulWidget {
  @override
  ShareAndAddImageTestState createState() => ShareAndAddImageTestState();
}

class ShareAndAddImageTestState extends State<ShareAndAddImageTest> {
  String text = 'Earth';
  String subject = 'Sharing Planet Earth';
  List<String> imagePaths = [Iconz.DumUniverse, Iconz.DumBusinessLogo];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Share Earth',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Share Planet Earth'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Share text:',
                      hintText: 'Enter some text and/or link to share',
                    ),
                    maxLines: 2,
                    onChanged: (String value) => setState(() {
                      text = value;
                    }),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Share subject:',
                      hintText: 'Enter subject to share (optional)',
                    ),
                    maxLines: 2,
                    onChanged: (String value) => setState(() {
                      subject = value;
                    }),
                  ),

                  // const Padding(padding: EdgeInsets.only(top: 12.0)),
                  // ImagePreviews(imagePaths, onDelete: _onDeleteImage),

                  ListTile(
                    leading: Icon(Icons.add),
                    title: Text("Add image"),
                    onTap: () async {
                      final imagePicker = ImagePicker();
                      final pickedFile = await imagePicker.getImage(
                        source: ImageSource.gallery,
                      );
                      if (pickedFile != null) {
                        setState(() {
                          imagePaths.add(pickedFile.path);
                        });
                      }
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(top: 12.0)),
                  Builder(
                    builder: (BuildContext context) {
                      return RaisedButton(
                        child: const Text('Share'),
                        onPressed: text.isEmpty && imagePaths.isEmpty
                            ? null
                            : () => _onShare(context),
                      );
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(top: 12.0)),
                  Builder(
                    builder: (BuildContext context) {
                      return RaisedButton(
                        child: const Text('Share With Empty Origin'),
                        onPressed: () => _onShareWithEmptyOrigin(context),
                      );
                    },
                  ),

                  Container(
                    width: double.infinity,
                    height: 20,
                    color: Colorz.Yellow,
                  ),

                  ZoomableWidget(
                    child: DreamBox(
                      height: 100,
                      icon: Iconz.DvRageh,
                    ),
                  ),


                ],
              ),
            ),
          )),
    );
  }

  // _onDeleteImage(int position) {
  //   setState(() {
  //     imagePaths.removeAt(position);
  //   });
  // }

  _onShare(BuildContext context) async {
    // A builder is used to retrieve the context immediately
    // surrounding the RaisedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendant tree when it's not
    // a RenderObjectWidget. The RaisedButton's RenderObject
    // has its position and size after it's built.
    final RenderBox box = context.findRenderObject();

    if (imagePaths.isNotEmpty) {
      await Share.shareFiles(imagePaths,
          text: text,
          subject: subject,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share(text,
          subject: subject,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }

  _onShareWithEmptyOrigin(BuildContext context) async {
    await Share.share("text");
  }
}
