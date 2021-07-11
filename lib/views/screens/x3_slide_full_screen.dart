import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/zoomable_widget.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/buttons/panel_button.dart';
import 'package:bldrs/views/widgets/buttons/publish_button.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:bldrs/views/screens/x1_flyers_publisher_screen.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class SlideFullScreen extends StatelessWidget {
  final dynamic image;

  SlideFullScreen({
    @required this.image,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pageTitle: 'Create flyers',
      pyramids: Iconz.DvBlankSVG,
      appBarType: AppBarType.Non,
      appBarRowWidgets: <Widget>[

      ],
      layoutWidget:
      Center(
        child: Container(
          width: Scale.superScreenWidth(context),
          height: Scale.superScreenHeight(context),
          child: ZoomableWidget(
              child: superImageWidget(image)
          ),
        ),
      ),
    );
  }
}




