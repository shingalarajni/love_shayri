import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:love_shayri/myShayri.dart';
import 'package:love_shayri/second.dart';

void main()
{
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: First(),));
}

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
 List title=[];
 List temp=[];
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title=myshayri.title;
    temp=List.filled(title.length, false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Hindi Shayri"),backgroundColor: Colors.green,
    actions: [
      Icon(Icons.share),
      PopupMenuButton(itemBuilder: (context) => [
        PopupMenuItem(child: Icon(Icons.share,color: Colors.green,)),
        PopupMenuItem(child: Icon(Icons.share)),
        PopupMenuItem(child: Icon(Icons.share)),
        PopupMenuItem(child: Icon(Icons.share)),
      ],)
    ],
    ),
     body:ListView.separated(itemCount: title.length,itemBuilder: (context, index) {
       return ListTile(onTap: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) {
           return Second(index);
         },));
       },leading: Image.asset('assets/${myshayri.img[index]}'),title: Text(title[index]),);
     }, separatorBuilder: (BuildContext context, int index) { return Divider(height: 5,); },)
    );
  }
}
