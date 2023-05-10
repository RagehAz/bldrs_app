import 'package:bldrs/a_models/c_chain/b_city_phids_model.dart';
import 'package:bldrs/b_views/z_components/pyramids/pyramid_floating_button.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:clock_rebuilder/clock_rebuilder.dart';
import 'package:mapper/mapper.dart';
import 'package:numeric/numeric.dart';
import 'package:super_box/super_box.dart';

class NewSectionButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const NewSectionButton({
    Key key
  }) : super(key: key);
  // --------------------
  List<String> getPhids({
    @required BuildContext context,
  }){
    final CityPhidsModel _phidsModels = ChainsProvider.proGetCityPhids(context: context, listen: true);
    return CityPhidsModel.getPhidsFromCityPhidsModel(cityPhidsModel: _phidsModels);
  }
  // --------------------
  String getIcon({
    @required BuildContext context,
    @required List<String> phids,
  }){

    final bool _canRenderImages = Mapper.checkCanLoopList(phids);

    if (_canRenderImages == true){
      final int _index = Numeric.createRandomIndex(listLength: phids.length);
      return ChainsProvider.proGetPhidIcon(context: context, son: phids[_index]);
    }

    else {
      return Iconz.keywords;
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final List<String> _phids = getPhids(context: context);
    // --------------------
    return ClockRebuilder(
      startTime: DateTime.now(),
      duration: const Duration(milliseconds: 300),
      builder: (int timeDifference, Widget child){

        return SuperBox(
          height: PyramidFloatingButton.size,
          width: PyramidFloatingButton.size,
          icon: getIcon(
            context: context,
            phids: _phids,
          ),
          iconSizeFactor: 0.7,
          color: Colorz.white255,
          corners: PyramidFloatingButton.size/2,
          bubble: false,

        );
        },
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
