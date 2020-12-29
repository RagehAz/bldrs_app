import 'package:bldrs/models/enums/enum_bz_type.dart';
import 'package:bldrs/views/widgets/ask/ask.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class AskWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      layoutWidget: Ask(
        tappingAskInfo: (){},
        bzType: BzType.Designer,
      ),
    );
  }
}
