import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_header.dart';
import 'package:flutter/material.dart';

class NewHeader extends StatefulWidget {
final SuperFlyer superFlyer;
final double flyerZoneWidth;

  const NewHeader({
  @required this.superFlyer,
    @required this.flyerZoneWidth,
});

  @override
  _NewHeaderState createState() => _NewHeaderState();
}

class _NewHeaderState extends State<NewHeader> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlyerHeader(
        superFlyer: widget.superFlyer,
        flyerZoneWidth: widget.flyerZoneWidth,
      ),
    );
  }
}
