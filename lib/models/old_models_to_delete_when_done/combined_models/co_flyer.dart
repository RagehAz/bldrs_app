import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/old_models_to_delete_when_done/location_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import './co_bz.dart';
import './co_slide.dart';

class CoFlyer with ChangeNotifier{
  final FlyerModel flyer;
  final LocationModel flyerLocation;
  final List<CoSlide> coSlides;
  final CoBz coBz;
  bool ankhIsOn;
  bool followIsOn;

  CoFlyer({
    @required this.flyer,
    @required this.flyerLocation,
    @required this.coSlides,
    @required this.coBz,
    this.ankhIsOn = false,
    this.followIsOn = false,
  });

  void toggleAnkh(){
    ankhIsOn = !ankhIsOn;
    notifyListeners();
  }

  void toggleFollow(){
    followIsOn = !followIsOn;
    notifyListeners();
  }
  }
