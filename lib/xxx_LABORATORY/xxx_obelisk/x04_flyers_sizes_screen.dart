import 'package:bldrs/controllers/drafters/streamerz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/flyer/aflyer.dart';
import 'package:bldrs/views/widgets/flyer/tiny_flyer_widget.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlyersSizesScreen extends StatelessWidget {
  final double flyerSizeFactor;
  final TinyFlyer tinyFlyer;

  FlyersSizesScreen({
    this.flyerSizeFactor,
    this.tinyFlyer,
});

  @override
  Widget build(BuildContext context) {
    String _flyerID = 'f001';//'JeLtoYclzeDFNZ5VJ9PA';
    final FlyersProvider _pro = Provider.of<FlyersProvider>(context, listen: false);

    // final List<FlyerModel> _allFlyers = _pro.getAllFlyers;
    // final List<TinyFlyer> _allTinyFlyers = _pro.getAllTinyFlyers;
    // List<String> _flyerIDs = getListOfFlyerIDsFromFlyers(_allFlyers);
    final FlyerModel _flyer = _pro.getFlyerByFlyerID(_flyerID);
    final TinyFlyer _tinyFlyer = getTinyFlyerFromFlyerModel(_flyer);
    final BzModel _bz = _pro.getBzByBzID(_flyer.tinyBz.bzID);

    double _flyerSizeFactor = flyerSizeFactor ?? 0.5;

    return MainLayout(
      pageTitle: 'FlyerSizes Screen',
      appBarBackButton: true,
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidsYellow,
      tappingRageh: (){
        // print(_flyerIDs);

        },
      layoutWidget: ListView(
        children: <Widget>[

          Stratosphere(),

          TinyFlyerWidget(
            flyerSizeFactor: _flyerSizeFactor,
            tinyFlyer: _tinyFlyer,
          ),

          SizedBox(height: 10,),

          flyerModelBuilder(
            context: context,
            flyerID: 'Z6mmaU5ETompAIsW5hau',//_tinyFlyer.flyerID,
            builder: (ctx, flyerModel){
              return
                bzModelBuilder(
                    context: context,
                    bzID: flyerModel.tinyBz.bzID,
                    builder: (xxx, bzModel){
                      return
                        AFlyer(
                            flyer: flyerModel,
                            bz: bzModel,
                            flyerSizeFactor: 0.78
                        );
                    }
                );
            }
          ),


          PyramidsHorizon(heightFactor: 5,),

        ],
      ),
    );
  }
}



