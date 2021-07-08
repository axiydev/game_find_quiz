import 'package:flutter/material.dart';
import 'dart:math' as M;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index=0;
  @override Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
       body: SafeArea(
         child: Container(
           height: size.height,
           width: size.width,
           color: Colors.transparent,
           padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
               child:Center(
                 child: Container(
                   constraints: BoxConstraints(maxHeight: size.width,maxWidth: size.width),
                   child: GridView.builder(
                       gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 3,
                         mainAxisSpacing: 30,
                         crossAxisSpacing: 30
                       ),
                       itemBuilder: (context,index)=>GestureDetector(
                         child: buildCardWid(context,isActive: this.index==index?true:false),
                         onTap: (){
                             setState(() {
                               this.index=index;
                             });
                         },
                       )
                   )
                 ),
               )
             )
       ),
    );
  }

  Widget buildCardWid(BuildContext context,{bool isActive=false}){
    final Size size=MediaQuery.of(context).size;
    return AnimatedContainer(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeIn,
        transform: Matrix4.identity()..setEntry(3, 2,0.001)..rotateX(M.pi*(isActive?1.0:0.0)),
        child:Container(
          height: size.width*0.3,
          width: size.width*0.3,
          decoration: BoxDecoration(
              color: isActive?Colors.red:Colors.blue,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0,8),
                    blurRadius: 10,
                    color: Colors.grey[700]!
                ),
              ]
          ),
        ));
  }
}


