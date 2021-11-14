import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/kw/specs/spec%20_list_model.dart';
import 'package:bldrs/models/kw/specs/spec_model.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/scroller.dart';
import 'package:bldrs/views/widgets/general/textings/data_strip.dart';
import 'package:flutter/material.dart';

class SpecPickerScreen extends StatelessWidget {
  final SpecList specList;
  final List<Spec> allSelectedSpecs;

  const SpecPickerScreen({
    @required this.specList,
    @required this.allSelectedSpecs,
});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBarType: AppBarType.Basic,
      // appBarBackButton: true,
      sky: Sky.Black,
      pageTitle: Name.getNameByCurrentLingoFromNames(context, specList.names),
      pyramids: Iconz.PyramidzYellow,
      layoutWidget: MaxBounceNavigator(
        child: Scroller(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: const <Widget>[

              const Stratosphere(),

              const DataStrip(
                dataValue: 'thing',
                dataKey: 'blah',
                isPercent: false,
              ),

              const PyramidsHorizon(),

            ],
          ),
        ),
      ),
    );
  }
}

/*



 */