import 'package:bldrs/a_models/c_chain/b_city_phids_model.dart';
import 'package:bldrs/b_views/z_components/pyramids/pyramid_floating_button.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:flutter/material.dart';
import 'package:clock_rebuilder/clock_rebuilder.dart';
import 'package:numeric/numeric.dart';
import 'package:super_box/super_box.dart';

class NewSectionButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const NewSectionButton({
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final CityPhidsModel _phidsModels = ChainsProvider.proGetCityPhids(context: context, listen: true);
    final List<String> _phids = CityPhidsModel.getPhidsFromCityPhidsModel(cityPhidsModel: _phidsModels);

    return ClockRebuilder(
      startTime: DateTime.now(),
      duration: const Duration(milliseconds: 300),
      builder: (int timeDifference, Widget child){

        final int _index = Numeric.createRandomIndex(listLength: _phids.length);

        return SuperBox(
          height: PyramidFloatingButton.size,
          width: PyramidFloatingButton.size,
          icon: ChainsProvider.proGetPhidIcon(context: context, son: _phids[_index]),
          corners: PyramidFloatingButton.size/2,
          bubble: false,

        );
        },
    );

  }
  // -----------------------------------------------------------------------------
}
