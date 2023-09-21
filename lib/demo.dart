import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp(home: Demo(),));
}

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Hello")),
    body: Container(width: double.infinity,height: 200,color: Colors.greenAccent,
    child: Row(
    //  mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(width: 50, height: 50, color: Colors.red,),
        Container(width: 50, height: 50, color: Colors.blue,),
        Container(width: 50, height: 50, color: Colors.red,),
      ],),),);
  }
}
