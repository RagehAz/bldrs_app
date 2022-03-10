// import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
// import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
// import 'package:bldrs/b_views/z_components/texting/unfinished_super_text_field.dart';
// import 'package:bldrs/f_helpers/drafters/tracers.dart';
// import 'package:flutter/material.dart';
//
// class TempClass {
//   /// --------------------------------------------------------------------------
//   TempClass({
//     @required this.a,
//     @required this.b,
//     @required this.c,
//     @required this.d,
//   });
//
//   /// --------------------------------------------------------------------------
//   final String a;
//   final double b;
//   final String c;
//   final String d;
//
//   /// --------------------------------------------------------------------------
// }
//
// class TestFormScreen extends StatefulWidget {
//   const TestFormScreen({Key key}) : super(key: key);
//
//   @override
//   _TestFormScreenState createState() => _TestFormScreenState();
// }
//
// class _TestFormScreenState extends State<TestFormScreen> {
//   final FocusNode _focusNode = FocusNode();
//   final FocusNode _bolbolFocusNode = FocusNode();
//   final TextEditingController _imageUrlController = TextEditingController();
//   final FocusNode _imageUrlFocusNode = FocusNode();
//   final GlobalKey<FormState> _form = GlobalKey<FormState>();
//   TempClass _editedProduct = TempClass(
//     a: '',
//     b: 0,
//     c: '',
//     d: '',
//   );
//
//   @override
//   void initState() {
//     _imageUrlFocusNode.addListener(_updateImageUrl);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _imageUrlFocusNode.removeListener(_updateImageUrl);
//     _focusNode.dispose();
//     _bolbolFocusNode.dispose();
//     _imageUrlController.dispose();
//     _imageUrlFocusNode.dispose();
//     super.dispose();
//   }
//
//   void _updateImageUrl() {
//     if (!_imageUrlFocusNode.hasFocus) {
//       if ((!_imageUrlController.text.startsWith('http') &&
//               !_imageUrlController.text.startsWith('https')) ||
//           (!_imageUrlController.text.endsWith('.png') &&
//               !_imageUrlController.text.endsWith('.jpg') &&
//               !_imageUrlController.text.endsWith('.jpeg'))) {
//         return;
//       }
//       setState(() {});
//     }
//   }
//
//   void _saveForm() {
//     final bool isValid = _form.currentState.validate();
//     if (!isValid) {
//       return;
//     }
//
//     _form.currentState.save();
//     blog(_editedProduct.a);
//     blog(_editedProduct.b);
//     blog(_editedProduct.c);
//     blog(_editedProduct.d);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // https://www.youtube.com/playlist?list=PL55RiY5tL51ryV3MhCbH8bLl7O_RZGUUE
//     // var urlPattern = r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
//     // var result = new RegExp(urlPattern, caseSensitive: false).firstMatch('https://www.google.com');
//
//     return MainLayout(
//       appBarRowWidgets: <Widget>[
//         DreamBox(
//           height: 40,
//           margins: const EdgeInsets.symmetric(horizontal: 10),
//           verse: 'save the shit',
//           verseScaleFactor: 0.5,
//           onTap: () {
//             _saveForm();
//             blog('save shit');
//           },
//         ),
//       ],
//       layoutWidget: Padding(
//         padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
//         child: Form(
//           key: _form,
//           // autovalidateMode: ,
//           // onChanged: ,
//           // onWillPop: ,
//           child: ListView(
//             children: <Widget>[
//               TextFormField(
//                 validator: (String value) {
//                   if (value.isEmpty) {
//                     return 'write something';
//                   } else {
//                     return null;
//                   }
//                 },
//                 decoration: const InputDecoration(
//                   labelText: 'Entry a',
//                 ),
//                 textInputAction: TextInputAction.next,
//                 onFieldSubmitted: (_) {
//                   FocusScope.of(context).requestFocus(_bolbolFocusNode);
//                 },
//                 onSaved: (String value) {
//                   _editedProduct = TempClass(
//                       a: value,
//                       b: _editedProduct.b,
//                       c: _editedProduct.c,
//                       d: _editedProduct.d);
//                 },
//               ),
//               const Divider(
//                 height: 10,
//               ),
//               SuperTextField(
//                 fieldIsFormField: true,
//                 validator: (String value) => value.isEmpty ? 'noooo' : 'ok',
//                 hintText: 'b is here',
//                 textController: TextEditingController(),
//                 onSaved: (String value) {
//                   _editedProduct = TempClass(
//                       a: _editedProduct.a,
//                       b: _editedProduct.b,
//                       c: value,
//                       d: _editedProduct.d);
//                 },
//                 maxLines: 2,
//               ),
//               const Divider(
//                 height: 10,
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Entry b',
//                 ),
//                 textInputAction: TextInputAction.next,
//                 keyboardType: TextInputType.number,
//                 focusNode: _bolbolFocusNode,
//                 onFieldSubmitted: (_) {
//                   FocusScope.of(context).requestFocus(_focusNode);
//                 },
//
//                 // some validators
//                 // !value.startsWith, !value.isEmpty, !value.EndsWith
//                 validator: (String value) {
//                   if (value.isEmpty) {
//                     return 'Enter number';
//                   }
//
//                   if (double.tryParse(value) == null) {
//                     return 'Enter a Valid number';
//                   }
//
//                   if (double.parse(value) <= 0) {
//                     return 'Enter a good number';
//                   }
//
//                   return null;
//                 },
//
//                 onSaved: (String value) {
//                   _editedProduct = TempClass(
//                       a: _editedProduct.a,
//                       b: double.tryParse(value),
//                       c: _editedProduct.c,
//                       d: _editedProduct.d);
//                 },
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Entry c',
//                 ),
//                 textInputAction: TextInputAction.next,
//                 focusNode: _focusNode,
//                 onFieldSubmitted: (_) {
//                   FocusScope.of(context).requestFocus(_imageUrlFocusNode);
//                 },
//                 onSaved: (String value) {
//                   _editedProduct = TempClass(
//                       a: _editedProduct.a,
//                       b: _editedProduct.b,
//                       c: value,
//                       d: _editedProduct.d);
//                 },
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   DreamBox(
//                     // width: 100,
//                     height: 100,
//                     margins: const EdgeInsets.all(10),
//                     verse: _imageUrlController.text.isEmpty
//                         ? 'Picture goes here'
//                         : null,
//
//                     subChild: _imageUrlController.text.isEmpty
//                         ? null
//                         : Image.network(
//                             _imageUrlController.text,
//                             width: 100,
//                             height: 100,
//                             fit: BoxFit.contain,
//                           ),
//                   ),
//                 ],
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'image url'),
//                 keyboardType: TextInputType.url,
//                 textInputAction: TextInputAction.done,
//                 controller: _imageUrlController,
//                 focusNode: _imageUrlFocusNode,
//                 onSaved: (String value) {
//                   _editedProduct = TempClass(
//                       a: _editedProduct.a,
//                       b: _editedProduct.b,
//                       c: _editedProduct.c,
//                       d: value);
//                 },
//                 onEditingComplete: () {
//                   setState(() {});
//                 },
//                 onFieldSubmitted: (_) {
//                   _saveForm(); // to be put like this because onFieldSubmitted takes a String as an argument
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }