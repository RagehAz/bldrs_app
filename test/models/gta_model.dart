import 'package:bldrs/a_models/f_flyer/draft/gta_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('GtaModel', () {

    test('getPriceFromScrappedString', () {

      const String _text = 'AED1,785.00';
      final double? _value = GtaModel.getPriceFromScrappedString(_text);
      expect(_value, 1785.00);

    });

  });

}
