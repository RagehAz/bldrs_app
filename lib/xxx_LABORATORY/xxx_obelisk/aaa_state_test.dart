import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:flutter/material.dart';


class Bolbol{
  final int length;
  final String name;
  final List<Totta> tots;

  Bolbol({
    this.length,
    this.name,
    this.tots,
});

  Bolbol clone(){
    return
      Bolbol(
          name: name,
          length: length,
          tots: Totta.cloneTots(tots),
        );
  }
}

class Totta{
  final String name;
  final int times;

  Totta({
    this.name,
    this.times,
});

  Totta clone(){
    return Totta(
      name: name,
      times: times,
    );
  }

  static List<Totta> cloneTots(List<Totta> tots){
    List<Totta> _newTots = new List();

    for (var tot in tots){
      _newTots.add(tot.clone());
    }

    return _newTots;
  }

}

class StateTest extends StatefulWidget {
  final Bolbol bolbol;

  StateTest({
    @required this.bolbol,
});

  @override
  _StateTestState createState() => _StateTestState();
}

class _StateTestState extends State<StateTest> {
  Bolbol originalBolbol;
  Bolbol modifiableBolbol;
  List<Totta> _tots;

  @override
  void initState() {
    modifiableBolbol = widget.bolbol;
    originalBolbol = widget.bolbol.clone();
    _tots = modifiableBolbol.tots;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
        child: Column(
          children: <Widget>[

            GestureDetector(
              onTap: (){
                setState(() {
                  // it should add new values only to this list
                  _tots.add(Totta(
                    name: 'tot ${_tots.length + 1}',
                    times: 4,
                  ));
                });
              },
              child: Container(
                width: 200,
                height: 50,
                color: Colors.amber,
                margin: EdgeInsets.only(top: 40),
                alignment: Alignment.center,
                child: Text(
                  'Fuck',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),

            ...List.generate(_tots.length, (index){
              return
                Text(_tots[index].name);
            }),

            Expanded(child: Container(),),

            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    color: Colors.brown,
                    child: Text('_tots.length = ${_tots.length}'),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    color: Colors.deepOrangeAccent,
                    child: Text('modifiableBolbol.tots.length = ${modifiableBolbol.tots.length}'),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    color: Colors.redAccent,
                    child: Text('originalBolbol.tots.length = ${originalBolbol.tots.length}'),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    color: Colors.orangeAccent,
                    child: Text('widget.bolbol.tots.length = ${widget.bolbol.tots.length}'),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
