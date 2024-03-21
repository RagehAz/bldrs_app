import 'dart:io';
import 'dart:typed_data';
import 'package:basics/mediator/models/media_models.dart';
import 'package:basics/mediator/video_maker/video_ops.dart';
import 'package:flutter/material.dart';

class CoverResultPopup extends StatefulWidget {

  const CoverResultPopup({
    required this.cover,
    super.key,
  });

  final File cover;

  @override
  State<CoverResultPopup> createState() => _CoverResultPopupState();

}

class _CoverResultPopupState extends State<CoverResultPopup> {

  Uint8List? _imagebytes;

  Size? _fileDimension;
  late String _fileMbSize;

  @override
  void initState() {
    super.initState();

    _imagebytes = widget.cover.readAsBytesSync();

    _getSetDimensions();

    _fileMbSize = VideoOps.getSizeMbString(
      file: widget.cover,
    );

  }

  Future<void> _getSetDimensions() async {

    final Dimensions? _dims = await DimensionsGetter.fromFile(
        file: widget.cover,
    );

    if (_dims != null){

      setState(() {
        _fileDimension = _dims.toSize();
      });

    }

  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Stack(
          children: [

            if (_imagebytes != null)
            Image.memory(_imagebytes!),

            Positioned(
              bottom: 0,
              child: FileDescription(
                description: {
                  'Cover path': widget.cover.path,
                  // 'Cover ratio': Fraction.fromDouble(_fileDimension?.aspectRatio ?? 0).reduce().toString(),
                  'Cover dimension': _fileDimension.toString(),
                  'Cover size': _fileMbSize,
                },
              ),
            ),

          ],
        ),
      ),
    );

  }

}

class FileDescription extends StatelessWidget {

  const FileDescription({
    required this.description,
    super.key,
  });

  final Map<String, String> description;

  @override
  Widget build(BuildContext context) {

    return DefaultTextStyle(
      style: const TextStyle(fontSize: 11),
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        padding: const EdgeInsets.all(10),
        color: Colors.black.withOpacity(0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: description.entries.map((entry) => Text.rich(
            TextSpan(
              children: [

                TextSpan(
                  text: '${entry.key}: ',
                  style: const TextStyle(fontSize: 11),
                ),

                TextSpan(
                  text: entry.value,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),

              ],
            ),
          ),
          ).toList(),
        ),
      ),
    );

  }

}
