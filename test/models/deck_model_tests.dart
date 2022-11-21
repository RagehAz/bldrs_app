

import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/deck_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  const DeckModel dummyDeck = DeckModel(
      all: [
        'properties1', 'properties2',
        'designs1', 'designs2',
        'undertakings1', 'undertakings2',
        'trades1', 'trades2',
        'products1', 'products2',
        'equipment1', 'equipment2'
      ],
      general: [],
      properties: ['properties1', 'properties2'],
      designs: ['designs1', 'designs2'],
      undertakings: ['undertakings1', 'undertakings2'],
      trades: ['trades1', 'trades2'],
      products: ['products1', 'products2'],
      equipment: ['equipment1', 'equipment2'],
  );

  final FlyerModel _flyer1 = FlyerModel.dummyFlyer().copyWith(
    flyerType: FlyerType.property,
    id: 'properties1',
    authorID: 'x'
  );

  // final FlyerModel _flyer2 = FlyerModel.dummyFlyer().copyWith(
  //   flyerType: FlyerType.design,
  //   id: 'designs2',
  //     authorID: 'x'
  // );

  final FlyerModel _flyerNew = FlyerModel.dummyFlyer().copyWith(
    flyerType: FlyerType.property,
    id: 'properties3',
      authorID: 'x'
  );

  final FlyerModel _flyerNew2 = FlyerModel.dummyFlyer().copyWith(
      flyerType: FlyerType.property,
      id: 'properties4',
      authorID: 'x'
  );

// -----------------------------------------------------------------------------
  test('dummyDeck.toMap()', () {

    final Map<String, dynamic> _ciphered = dummyDeck.toMap();

    final Map<String, dynamic> _result = {
      'all': [
    'properties1', 'properties2',
    'designs1', 'designs2',
    'undertakings1', 'undertakings2',
    'trades1', 'trades2',
    'products1', 'products2',
    'equipment1', 'equipment2'
    ],
      'properties': ['properties1', 'properties2'],
      'designs': ['designs1', 'designs2'],
      'undertakings': ['undertakings1', 'undertakings2'],
      'trades': ['trades1', 'trades2'],
      'products': ['products1', 'products2'],
      'equipment': ['equipment1', 'equipment2'],
    };

    expect(_ciphered, _result);
  });
// -----------------------------------------------------------------------------
  test('DeckModel.decipher(dummyDeck.toMap())', () {

    final Map<String, dynamic> _ciphered = dummyDeck.toMap();
    final DeckModel _deciphered = DeckModel.decipher(_ciphered);

    expect(dummyDeck, _deciphered);
  });
// -----------------------------------------------------------------------------
  test('addFlyer', () {

    final DeckModel _modified = DeckModel.addFlyer(
        flyer: _flyerNew,
        oldDeck: dummyDeck
    );

    const DeckModel _expected = DeckModel(
      all: [
        'properties1', 'properties2',
        'designs1', 'designs2',
        'undertakings1', 'undertakings2',
        'trades1', 'trades2',
        'products1', 'products2',
        'equipment1', 'equipment2', 'properties3',
      ],
      general: [],
      properties: ['properties1', 'properties2', 'properties3'],
      designs: ['designs1', 'designs2'],
      undertakings: ['undertakings1', 'undertakings2'],
      trades: ['trades1', 'trades2'],
      products: ['products1', 'products2'],
      equipment: ['equipment1', 'equipment2'],
    );

    expect(_modified, _expected);
  });
// -----------------------------------------------------------------------------
  test('addFlyers', () {

    final DeckModel _modified = DeckModel.addFlyers(
        deckModel: dummyDeck,
        flyers: [
      _flyerNew, _flyerNew2,
      ],
    );

    const DeckModel _expected = DeckModel(
      all: [
        'properties1', 'properties2',
        'designs1', 'designs2',
        'undertakings1', 'undertakings2',
        'trades1', 'trades2',
        'products1', 'products2',
        'equipment1', 'equipment2', 'properties3', 'properties4',
      ],
      general: [],
      properties: ['properties1', 'properties2', 'properties3', 'properties4',],
      designs: ['designs1', 'designs2'],
      undertakings: ['undertakings1', 'undertakings2'],
      trades: ['trades1', 'trades2'],
      products: ['products1', 'products2'],
      equipment: ['equipment1', 'equipment2'],
    );

    expect(_modified, _expected);
  });
// -----------------------------------------------------------------------------
  test('addNull', () {

    final DeckModel _modified = DeckModel.addFlyer(
        flyer: null,
        oldDeck: dummyDeck
    );

    const DeckModel _expected = DeckModel(
      all: [
        'properties1', 'properties2',
        'designs1', 'designs2',
        'undertakings1', 'undertakings2',
        'trades1', 'trades2',
        'products1', 'products2',
        'equipment1', 'equipment2',
      ],
      general: [],
      properties: ['properties1', 'properties2'],
      designs: ['designs1', 'designs2'],
      undertakings: ['undertakings1', 'undertakings2'],
      trades: ['trades1', 'trades2'],
      products: ['products1', 'products2'],
      equipment: ['equipment1', 'equipment2'],
    );

    expect(_modified, _expected);
  });
// -----------------------------------------------------------------------------
  test('addOrRemove ( should remove )', () {

    final DeckModel _modified = DeckModel.addOrRemoveFlyer(
        oldDeck: dummyDeck,
        flyer: _flyer1,
    );

    const DeckModel _expected = DeckModel(
      all: [
        'properties2',
        'designs1', 'designs2',
        'undertakings1', 'undertakings2',
        'trades1', 'trades2',
        'products1', 'products2',
        'equipment1', 'equipment2',
      ],
      general: [],
      properties: ['properties2'],
      designs: ['designs1', 'designs2'],
      undertakings: ['undertakings1', 'undertakings2'],
      trades: ['trades1', 'trades2'],
      products: ['products1', 'products2'],
      equipment: ['equipment1', 'equipment2'],
    );

    expect(_modified, _expected);
  });
// -----------------------------------------------------------------------------
  test('addOrRemove ( should add )', () {

    final DeckModel _modified = DeckModel.addOrRemoveFlyer(
        oldDeck: dummyDeck,
        flyer: _flyerNew,
    );

    const DeckModel _expected = DeckModel(
      all: [
        'properties1', 'properties2',
        'designs1', 'designs2',
        'undertakings1', 'undertakings2',
        'trades1', 'trades2',
        'products1', 'products2',
        'equipment1', 'equipment2', 'properties3',
      ],
      general: [],
      properties: ['properties1', 'properties2', 'properties3'],
      designs: ['designs1', 'designs2'],
      undertakings: ['undertakings1', 'undertakings2'],
      trades: ['trades1', 'trades2'],
      products: ['products1', 'products2'],
      equipment: ['equipment1', 'equipment2'],
    );

    expect(_modified, _expected);
  });
// -----------------------------------------------------------------------------
  test('remove Flyer', () {

    final DeckModel _modified = DeckModel.removeFlyer(
      oldDeck: dummyDeck,
      flyer: _flyer1,
    );

    const DeckModel _expected = DeckModel(
      all: [
        'properties2',
        'designs1', 'designs2',
        'undertakings1', 'undertakings2',
        'trades1', 'trades2',
        'products1', 'products2',
        'equipment1', 'equipment2',
      ],
      general: [],
      properties: ['properties2'],
      designs: ['designs1', 'designs2'],
      undertakings: ['undertakings1', 'undertakings2'],
      trades: ['trades1', 'trades2'],
      products: ['products1', 'products2'],
      equipment: ['equipment1', 'equipment2'],
    );

    expect(_modified, _expected);
  });
// -----------------------------------------------------------------------------
  test('remove Flyer by ID', () {

    final DeckModel _modified = DeckModel.removeFlyerByID(
      oldDeck: dummyDeck,
      flyerID: _flyer1.id,
    );

    const DeckModel _expected = DeckModel(
      all: [
        'properties2',
        'designs1', 'designs2',
        'undertakings1', 'undertakings2',
        'trades1', 'trades2',
        'products1', 'products2',
        'equipment1', 'equipment2',
      ],
      general: [],
      properties: ['properties2'],
      designs: ['designs1', 'designs2'],
      undertakings: ['undertakings1', 'undertakings2'],
      trades: ['trades1', 'trades2'],
      products: ['products1', 'products2'],
      equipment: ['equipment1', 'equipment2'],
    );

    expect(_modified, _expected);
  });
// -----------------------------------------------------------------------------
  test('equality', () {

    final DeckModel _modified = dummyDeck.copyWith(
      equipment: ['equipment1', 'equipment2', 'x'],
    );

    final bool _identical1 = dummyDeck != _modified;

    expect(_identical1, true);

    const DeckModel _someDeck = DeckModel(
      all: [
        'properties1', 'properties2',
        'designs1', 'designs2',
        'undertakings1', 'undertakings2',
        'trades1', 'trades2',
        'products1', 'products2',
        'equipment1', 'equipment2'
      ],
      general: [],
      properties: ['properties1', 'properties2'],
      designs: ['designs1', 'designs2'],
      undertakings: ['undertakings1', 'undertakings2'],
      trades: ['trades1', 'trades2'],
      products: ['products1', 'products2'],
      equipment: ['equipment1', 'equipment2'],
    );

    expect(_someDeck == dummyDeck, true);

  });
// -----------------------------------------------------------------------------
}
