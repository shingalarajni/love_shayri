import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:love_shayri/myShayri.dart';
import 'package:love_shayri/third.dart';
class Second extends StatefulWidget {

  int shayri_ind;
  Second(this.shayri_ind);

  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  List shayri=[];
  int t=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    t=widget.shayri_ind;
    if(t==0)
      {
        shayri=myshayri.armanshayri;
      }else if(t==1)
    {
      shayri=myshayri.atitudeshayri;
    }else if(t==2)
    {
      shayri=myshayri.sundarvakya;
    }else if(t==3)
    {
      shayri=myshayri.bewfashayri;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.green,title: Text("${myshayri.title[t]}")),
    body: ListView.separated(itemBuilder: (context, index) {
      return ListTile(onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Third(shayri,index);
        },));
      },leading: Image.asset("assets/${myshayri.img[t]}"),title: Text("${myshayri.emoji[t]}${shayri[index].toString().substring(0,20)}..."),);
    }, separatorBuilder: (context, index) {
      return Divider(height: 5,);
    }, itemCount: shayri.length),

    );
  }
}
