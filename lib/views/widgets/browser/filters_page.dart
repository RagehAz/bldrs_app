import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/keys_set.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:flutter/material.dart';

class FiltersPage extends StatelessWidget {
  final List<KeysSet> filtersModels;
  final Function onTap;
  final KeysSet selectedFilter;

  FiltersPage({
    Key key,
    @required this.filtersModels,
    @required this.onTap,
    @required this.selectedFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 20,
      // height: 20,
      // color: _colors[pageIndex],
      child: ListView.builder(
          itemCount: filtersModels.length,
          padding: const EdgeInsets.all(Ratioz.appBarMargin),
          itemBuilder: (context, keyIndex){

            KeysSet _filterModel = filtersModels[keyIndex];

            Color _color = selectedFilter?.titleID == _filterModel.titleID ? Colorz.Yellow255 : Colorz.Nothing;

            return
              DreamBox(
                height: 70,
                // width: 120,
                color: _color,
                margins: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
                verse: _filterModel.titleID,
                onTap: () => onTap(_filterModel),
              );
          }
      ),
    );
  }
}
