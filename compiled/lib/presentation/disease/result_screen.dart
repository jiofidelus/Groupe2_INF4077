import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class CheckerResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Consultation Results".text.make(),
      ),
      body: Stack(
        overflow: Overflow.visible,
        fit: StackFit.expand,
        children: [

          Positioned.fill(top:101,child: ResultContent()),
          ImageHeader(),
        ],
      ),
    );
  }
}

class ImageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Image(image: AssetImage("assets/img/results.png"), height: 100,).p16(),
          ),

          Positioned(top: 50,child: "Results:  Patient Name".text.xl2.bold.gray700.make().px8())

        ],
      ),
    ).backgroundColor(Colors.transparent).h24(context);
  }
}

class ResultContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      //color: context.accentColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12,),
          "This is your result Overview".text.bold.xl2.make(),
          SizedBox(height: 8,),
          "This is the description of your situation it can be as long as you wish".text.make(),

        ],
      ).p8(),
    );
  }
}
