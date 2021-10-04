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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  late List<int?> lt;
  int index = 0;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 550));
    animation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    controller.forward();
    lt = List.generate(9, (index) => M.Random().nextInt(100));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Container(
              height: size.height,
              width: size.width,
              color: Colors.transparent,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Center(
                child: Container(
                    constraints: BoxConstraints(
                        maxHeight: size.width, maxWidth: size.width),
                    child: GridView.builder(
                        itemCount: lt.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 30,
                            crossAxisSpacing: 30),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: buildCardWid(context,
                                isActive: this.index == index ? true : false,
                                animation: animation,
                                number: lt[index]),
                            onTap: () {
                              if (animation.isCompleted) {
                                controller.reverse();
                              } else {
                                controller.forward();
                              }
                              setState(() {
                                this.index = index;
                              });
                            },
                          );
                        })),
              ))),
    );
  }

  Widget buildCardWid(BuildContext context,
      {bool isActive = false,
      required Animation animation,
      required int? number}) {
    final Size size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Stack(
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(M.pi * (isActive ? animation.value : 0.0)),
            child: AnimatedContainer(
              height: size.width * 0.3,
              width: size.width * 0.3,
              duration: Duration(milliseconds: 550),
              curve: Curves.easeIn,
              decoration: BoxDecoration(
                  color: isActive ? Colors.red : Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 8),
                        blurRadius: 10,
                        color: Colors.grey[700]!),
                  ]),
            ),
          ),
          isActive
              ? AnimatedOpacity(
                  opacity: isActive ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 550),
                  child: Center(
                    child: Text(
                      number!.toString(),
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
