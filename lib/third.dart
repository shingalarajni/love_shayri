import 'dart:math';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:love_shayri/fourth.dart';
import 'package:love_shayri/myShayri.dart';
import 'package:share_plus/share_plus.dart';

class Third extends StatefulWidget {
  List shayri = [];
  int cur_ind;

  Third(this.shayri, this.cur_ind);

  @override
  _ThirdState createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
  int cur_index = 0;
  List l = [];
  bool color_bool = false;
  int g_cur_ind = 0;
  List<List<Color>> g_color = [
    [Colors.red, Colors.yellow, Colors.blue],
    [Color(0xffCD5C5C), Color(0xff6495ED)],
    [Colors.red, Colors.yellow, Colors.blue],
    [Colors.red, Colors.yellow, Colors.blue],
    [Colors.greenAccent, Colors.indigo, Colors.amberAccent],
    [Colors.red, Colors.yellow, Colors.blue],
    [Colors.red, Colors.yellow, Colors.blue],
    [Colors.greenAccent, Colors.indigo, Colors.amberAccent],
    [Colors.red, Colors.yellow, Colors.blue],
    [Colors.red, Colors.yellow, Colors.blue],
    [Colors.greenAccent, Colors.indigo, Colors.amberAccent],
    [Colors.red, Colors.yellow, Colors.blue],
  ];
  PageController controller = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cur_index = widget.cur_ind;
    l = widget.shayri;
    controller = PageController(initialPage: cur_index);
  }

  @override
  Widget build(BuildContext context) {
    double tot_height = MediaQuery.of(context).size.height;
    double app_bar_hight = kToolbarHeight;
    double st_hight = MediaQuery.of(context).padding.top;
    double body_height = tot_height - app_bar_hight - st_hight;
    return Scaffold(
      appBar: AppBar(title: Text("Hello")),
      body: Column(
        children: [
          Flexible(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    barrierColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Container(
                        height: body_height,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5),
                          itemCount: g_color.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  g_cur_ind = index;
                                  color_bool = true;
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient:
                                        LinearGradient(colors: g_color[index])),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/expand.png"))),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                width: 60,
                height: 30,
                child: Text("${cur_index} / ${l.length}"),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    g_cur_ind = Random().nextInt(g_color.length);
                    color_bool = true;
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/reload.png"))),
                ),
              )
            ],
          )),
          Container(
            height: 200,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  cur_index = value;
                });
              },
              controller: controller,
              itemCount: l.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Text("${l[index]}"),
                  decoration: BoxDecoration(
                      gradient: (color_bool == true)
                          ? LinearGradient(colors: g_color[g_cur_ind])
                          : null,
                      color: (color_bool == false) ? Colors.pinkAccent : null),
                );
              },
            ),
          ),
          Spacer(),
          Row(
            children: [
              Expanded(
                  child: IconButton(onPressed: () {
                    FlutterClipboard.copy("${l[cur_index]}").then(( value ) => print('copied'));
                  },
                icon: Icon(Icons.copy),
              )),
              Expanded(
                  child: InkWell(
                child: Text("<<"),
                onTap: () {
                  setState(() {
                    cur_index--;
                    controller.jumpToPage(cur_index);
                  });
                },
              )),
              Expanded(
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Fourth(l[cur_index]);
                      },));
                    },
                icon: Icon(Icons.edit),
              )),
              Expanded(
                  child: InkWell(
                onTap: () {
                  setState(() {
                    cur_index++;
                    controller.jumpToPage(cur_index);
                  });
                },
                child: Container(
                  child: Text(">>"),
                ),
              )),
              Expanded(
                  child: IconButton(onPressed: () {
                    Share.share("${l[cur_index]}");
                  },
                icon: Icon(Icons.copy),
              )),
            ],
          )
        ],
      ),
    );
  }
}
