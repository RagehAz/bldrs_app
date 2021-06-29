import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';

class TempClass{
  final String a;
  final double b;
  final String c;
  final String d;

  TempClass({
    @required this.a,
    @required this.b,
    @required this.c,
    @required this.d,
});
}

class TestFormScreen extends StatefulWidget {
  @override
  _TestFormScreenState createState() => _TestFormScreenState();
}

class _TestFormScreenState extends State<TestFormScreen> {
  final _focusNode = FocusNode();
  final _bolbolFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = TempClass(
    a: '',
    b: 0,
    c: '',
    d: '',
  );


  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose(){
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _focusNode.dispose();
    _bolbolFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
          !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm(){
    final isValid = _form.currentState.validate();
    if (!isValid){
      return;
    }

    _form.currentState.save();
    print(_editedProduct.a);
    print(_editedProduct.b);
    print(_editedProduct.c);
    print(_editedProduct.d);

  }


  @override
  Widget build(BuildContext context) {

    // https://www.youtube.com/playlist?list=PL55RiY5tL51ryV3MhCbH8bLl7O_RZGUUE
  // var urlPattern = r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
  // var result = new RegExp(urlPattern, caseSensitive: false).firstMatch('https://www.google.com');


    return MainLayout(
      appBarRowWidgets: <Widget>[
        DreamBox(
          height: 40,
          boxMargins: const EdgeInsets.symmetric(horizontal: 10),
          verse: 'save the shit',
          verseScaleFactor: 0.5,
          boxFunction: (){
            _saveForm();
            print('save shit');
          },
        ),
      ],
      layoutWidget: Padding(
          padding: const EdgeInsets.only(top:70, left: 10, right: 10),
          child: Form(
            key: _form,
            // autovalidateMode: ,
            // onChanged: ,
            // onWillPop: ,
            child: ListView(
              children: <Widget>[

                TextFormField(
                  validator: (value){
                    if (value.isEmpty){return 'write something';}
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Entry a',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_){FocusScope.of(context).requestFocus(_bolbolFocusNode);},
                  onSaved: (value){_editedProduct = TempClass(a: value, b: _editedProduct.b, c: _editedProduct.c, d: _editedProduct.d);},
                ),

                Divider(
                  height: 10,
                ),

                SuperTextField(
                  fieldIsFormField: true,
                  validator: (value) => value.isEmpty ? 'noooo' : 'ok',
                  hintText: 'b is here',
                  onSaved: (value){
                    _editedProduct = TempClass(a: _editedProduct.a, b: _editedProduct.b, c: value, d: _editedProduct.d);
                    },
                  maxLength: 50,
                  maxLines: 2,
                  obscured: false,
                  counterIsOn: true,
                ),

                Divider(
                  height: 10,
                ),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Entry b',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _bolbolFocusNode,
                  onFieldSubmitted: (_){FocusScope.of(context).requestFocus(_focusNode);},

                  // some validators
                  // !value.startsWith, !value.isEmpty, !value.EndsWith
                  validator: (value){
                    if(value.isEmpty){return 'Enter number';}
                    if(double.tryParse(value) == null){return 'Enter a Valid number';}
                    if(double.parse(value) <= 0){return 'Enter a good number';}
                    return null;
                  },
                  onSaved: (value){_editedProduct = TempClass(a: _editedProduct.a, b: double.tryParse(value), c: _editedProduct.c, d: _editedProduct.d);},
                ),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Entry c',
                  ),
                  textInputAction: TextInputAction.next,
                  focusNode: _focusNode,
                  onFieldSubmitted: (_){FocusScope.of(context).requestFocus(_imageUrlFocusNode);},
                  onSaved: (value){_editedProduct = TempClass(a: _editedProduct.a, b: _editedProduct.b, c: value, d: _editedProduct.d);},

                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    DreamBox(
                      // width: 100,
                      height: 100,
                      boxMargins: const EdgeInsets.all(10),
                      verse: _imageUrlController.text.isEmpty ?
                      'Picture goes here': null,

                      dreamChild: _imageUrlController.text.isEmpty ? null :
                      Image.network(
                        _imageUrlController.text,
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),

                    ),
                  ],
                ),

                TextFormField(
                  decoration: InputDecoration(labelText: 'image url'),
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.done,
                  controller: _imageUrlController,
                  focusNode: _imageUrlFocusNode,
                  onSaved: (value){_editedProduct = TempClass(a: _editedProduct.a, b: _editedProduct.b, c: _editedProduct.c, d: value);},
                  onEditingComplete: (){
                    setState(() {

                    });
                  },
                  onFieldSubmitted: (_){
                    _saveForm(); // to be put like this because onFieldSubmitted takes a String as an argument
                  },
                ),

              ],
            ),
          ),
        ),
    );
  }
}
