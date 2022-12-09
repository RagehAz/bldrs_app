import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  const Staging _zoneLevel = Staging(
    id: 'id',
    emptyStageIDs: ['1', '2', '3'],
    bzzStageIDs: ['4', '5', '6'],
    flyersStageIDs: ['7', '8', '9'],
    publicStageIDs: ['10', '11', '12'],
  );

  // -----------------------------------------------------------------------------
  test('copyListWith', () {

      final Staging _new = _zoneLevel.copyListWith(
        newList: ['1', '2', '3', '4'],
        type: StageType.emptyStage,
      );

      const Staging _shouldBe =  Staging(
        id: 'id',
        emptyStageIDs: ['1', '2', '3', '4'],
        bzzStageIDs: ['4', '5', '6'],
        flyersStageIDs: ['7', '8', '9'],
        publicStageIDs: ['10', '11', '12'],
      );

      expect(_new, _shouldBe);


    });
  // ---------------------------
  test('copyListWith 2', () {

    Staging _new = _zoneLevel.copyListWith(
      newList: ['xxx'],
      type: StageType.emptyStage,
    );

    _new = _new.copyListWith(
      newList: null,
      type: StageType.flyersStage,
    );

    _new = _new.copyListWith(
      newList: [],
      type: StageType.publicStage,
    );

    const Staging _shouldBe =  Staging(
      id: 'id',
      emptyStageIDs: ['xxx'],
      bzzStageIDs: ['4', '5', '6'],
      flyersStageIDs: ['7', '8', '9'],
      publicStageIDs: [],
    );

    expect(_new, _shouldBe);


  });
  // ---------------------------
  test('getIDsByLevel', () {

    const StageType _type = StageType.emptyStage;

    final List<String> _list = _zoneLevel.getIDsByType(_type);

    const List<String> _shouldBe = ['1', '2', '3'];

    expect(_list, _shouldBe);

    final List<String> _list2 = _zoneLevel.getIDsByType(null);
    final List<String> _shouldBe2 = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];
    expect(_list2, _shouldBe2);

  });
  // ---------------------------
  test('getLevelTypeByID', () {

    final StageType _type = _zoneLevel.getTypeByID('11');
    expect(_type, StageType.publicStage);

    final StageType _type2 = _zoneLevel.getTypeByID(null);
    expect(_type2, null);

    final StageType _type3 = _zoneLevel.getTypeByID('13');
    expect(_type3, null);

    final StageType _type4 = _zoneLevel.getTypeByID('2');
    expect(_type4, StageType.emptyStage);

  });
  // ---------------------------
  test('checkHasID', () {

    final bool _has1 = _zoneLevel.checkHasID(
      id: '1',
    );
    final bool _has1InHidden = _zoneLevel.checkHasID(
      id: '1',
      zoneStageType: StageType.emptyStage,
    );
    final bool _has1InActive = _zoneLevel.checkHasID(
      id: '1',
      zoneStageType: StageType.flyersStage,
    );

    final bool _has15 = _zoneLevel.checkHasID(
      id: '15'
    );
    final bool _has15InHidden = _zoneLevel.checkHasID(
      id: '15',
      zoneStageType: StageType.emptyStage,
    );

    expect(_has1, true);
    expect(_has1InHidden, true);
    expect(_has1InActive, false);

    expect(_has15, false);
    expect(_has15InHidden, false);


  });
  // -----------------------------------------------------------------------------
  test('removeIDFromZoneLevel', () {

    final Staging _new = Staging.removeIDFromStaging(
      id: 'XX',
      staging: _zoneLevel,
    );
    const Staging _shouldBe = Staging(
      id: 'id',
      emptyStageIDs: ['1', '2', '3'],
      bzzStageIDs: ['4', '5', '6'],
      flyersStageIDs: ['7', '8', '9'],
      publicStageIDs: ['10', '11', '12'],
    );
    expect(_new, _shouldBe);

    Staging _new2 = Staging.removeIDFromStaging(
      id: '1',
      staging: _zoneLevel,
    );

    _new2 = Staging.removeIDFromStaging(
      id: '8',
      staging: _new2,
    );

    const Staging _shouldBe2 = Staging(
      id: 'id',
      emptyStageIDs: ['2', '3'],
      bzzStageIDs: ['4', '5', '6'],
      flyersStageIDs: ['7', '9'],
      publicStageIDs: ['10', '11', '12'],
    );
    expect(_new2, _shouldBe2);

  });
  // ---------------------------
  test('addIDToZoneLevel', () {

    final Staging _new = Staging.insertIDToStaging(
      id: 'XX',
      newType: StageType.flyersStage,
      staging: _zoneLevel,
    );

    const Staging _shouldBe = Staging(
      id: 'id',
      emptyStageIDs: ['1', '2', '3'],
      bzzStageIDs: ['4', '5', '6'],
      flyersStageIDs: ['7', '8', '9', 'XX'],
      publicStageIDs: ['10', '11', '12'],
    );

    expect(_new, _shouldBe);


  });
  // ---------------------------
  test('addIDToZoneLevel2', () {

    final Staging _new = Staging.insertIDToStaging(
      id: '9',
      newType: StageType.flyersStage,
      staging: _zoneLevel,
    );

    const Staging _shouldBe = Staging(
      id: 'id',
      emptyStageIDs: ['1', '2', '3'],
      bzzStageIDs: ['4', '5', '6'],
      flyersStageIDs: ['7', '8', '9',],
      publicStageIDs: ['10', '11', '12'],
    );

    expect(_new, _shouldBe);


  });
  // ---------------------------
  test('addIDToZoneLevel3', () {

    final Staging _new = Staging.insertIDToStaging(
      id: '9',
      newType: StageType.bzzStage,
      staging: _zoneLevel,
    );

    const Staging _shouldBe = Staging(
      id: 'id',
      emptyStageIDs: ['1', '2', '3'],
      bzzStageIDs: ['4', '5', '6', '9'],
      flyersStageIDs: ['7', '8',],
      publicStageIDs: ['10', '11', '12'],
    );

    expect(_new, _shouldBe);


  });
  // -----------------------------------------------------------------------------
}
