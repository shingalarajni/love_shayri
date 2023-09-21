import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class Fourth extends StatefulWidget {

  String str;
  Fourth(this.str);

  @override
  State<Fourth> createState() => _FourthState();
}

class _FourthState extends State<Fourth> {
  List<Color> color_list=[Colors.red,Colors.green,Colors.yellow,Colors.black,Colors.black26,Colors.greenAccent,Colors.redAccent,Colors.amber,
  Colors.blueGrey,Colors.blue,Colors.pink,Colors.purple,Colors.purpleAccent,Colors.red,Colors.green,Colors.yellow,Colors.black,Colors.black26,Colors.greenAccent,Colors.redAccent,Colors.amber,
    Colors.blueGrey,Colors.blue,Colors.pink,Colors.purple,Colors.purpleAccent];
 Color mycolor=Colors.pink;
 Color text_color=Colors.white;
 String cur_font="myfont1";
 List font_list=["myfont1","myfont2","myfont3","myfont4","myfont5","myfont6","myfont7"];
 double font_size=20;
 String folder_path="";
 String file_path="";
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_per();
  }
  check_per()
  async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      await [Permission.storage,].request();
      if(status.isGranted){
        create_folder();
      }
    }
    else{
      create_folder();
    }

  }
  create_folder()
  async {
    var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)+"/cdmi";
      Directory dic=Directory(path);
      if(!await dic.exists())
        {
          await dic.create();
          folder_path=dic.path;
          print("create");
        }
      else
        {
          print("available");
          folder_path=dic.path;
        }


  }
  @override
  Widget build(BuildContext context) {
    GlobalKey _globalKey = new GlobalKey();
    Future<Uint8List> _capturePng() async {
      var pngBytes;
      try {
        print('inside');
        RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
        ui.Image image = await boundary.toImage(pixelRatio: 3.0);
        ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
         pngBytes = byteData!.buffer.asUint8List();
        var bs64 = base64Encode(pngBytes);
        print(pngBytes);
        print(bs64);
        setState(() {});
        return pngBytes;
      } catch (e) {
        print(e);
        return pngBytes;
      }
    }

    return Scaffold(appBar: AppBar(title: Text("Hello"),),
    body: Column(children: [
      RepaintBoundary(key: _globalKey,child: Expanded(flex: 3,child: Container(color: mycolor,child: Text(widget.str,style: TextStyle(fontSize: font_size,fontFamily: cur_font,color: text_color),),)),
          ),
      Spacer(),
      Container(color: Colors.blueGrey,child:
        Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            IconButton(onPressed: () {

            }, icon: Icon(Icons.refresh)),
            IconButton(onPressed: () {

            }, icon: Icon(Icons.shuffle_on)),
          ],),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly
          ,children: [
            ElevatedButton(onPressed: () {
              showModalBottomSheet(isDismissible: false,barrierColor: Colors.transparent,context: context, builder: (context) {
                return Container(height: 150,width: double.infinity, child:
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Expanded(child: Container(child: GridView.builder(itemCount: color_list.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:(color_list.length/3).toInt(),crossAxisSpacing: 10,mainAxisSpacing: 10 ) , itemBuilder: (context, index) {
                      return InkWell(onTap: () {
                        setState(() {
                          mycolor=color_list[index];
                        });
                      },child: Container(color: color_list[index],),);
                    },),)),
                  IconButton(onPressed: () {
                      Navigator.pop(context);
                  }, icon: Icon(Icons.close))
                ],),

                );
              },);
            }, child: Text("Background")),
            ElevatedButton(onPressed: () {
                _capturePng().then((value) async {
                  int ranom=Random().nextInt(1000);
                  File file=File(folder_path+"/img${ranom}.jpg");
                  if(!await file.exists())
                  {
                  await file.create();
                  await file.writeAsBytes(value);
                  file_path=file.path;
                  Share.shareFiles([file_path], text: 'Great picture');
                  }
                });
            }, child: Text("Share")),
            ElevatedButton(onPressed: () {
              showModalBottomSheet(context: context, builder: (context) {
                return Container(child: SingleChildScrollView(
                  child:  ColorPicker(
                    pickerColor: Colors.black,
                    onColorChanged: (value) {
                      setState(() {
                        text_color=value;
                      });
                    },
                  ),
                ),);
              },);
            }, child: Text("TextColor")),
          ],),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            ElevatedButton(onPressed: () {
            showModalBottomSheet(barrierColor: Colors.transparent,context: context, builder: (context) {
              return Container(margin: EdgeInsets.symmetric(vertical: 20),height: 40,child:
                ListView.builder(itemCount: font_list.length,scrollDirection: Axis.horizontal,itemBuilder: (context, index) {
                  return InkWell(onTap: () {
                    setState(() {
                      cur_font=font_list[index];
                    });
                  },child: Container(color: Colors.red, margin: EdgeInsets.all(5),child: Text("Hello",style: TextStyle(fontFamily: font_list[index]),),),);
                },),);
            },);
            }, child: Text("Font")),
            ElevatedButton(onPressed: () {

            }, child: Text("Emoji")),
            ElevatedButton(onPressed: () {
              showModalBottomSheet(context: context, builder: (context) {
                return Container(height: 100,child:
                  StatefulBuilder(builder: (context, setState1) {
                    return Slider(value: font_size,min: 10,max: 100,onChanged: (value) {
                      setState(() {
                        setState1(() {
                          font_size=value;
                        });
                      });
                    },);
                  },)
                  ,);
              },);
            }, child: Text("TextSize")),
          ],),
        ],),)
    ],),
    );
  }


}
