import 'package:compiled/domain/disease/disease-model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CheckerResultScreen extends StatelessWidget {
  final int points;

  const CheckerResultScreen({Key key, this.points}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var result = Result.all.firstWhere(
        (element) => element.start <= points && element.end > points);
    return Scaffold(
      appBar: AppBar(
        title: "Consultation Results".text.make(),
      ),
      body: Stack(
        //overflow: Overflow.visible,
        fit: StackFit.expand,
        children: [
          Positioned(
              top: 101,
              bottom: 0,
              left: 0,
              right: 0,
              child: ResultContent(
                result: result,
              )),
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
            child: Image(
              image: AssetImage("assets/img/results.png"),
              height: 100,
            ).p16(),
          ),
          Positioned(
              top: 50,
              child: "Results:  Patient Name".text.xl.bold.gray700.make().px8())
        ],
      ),
    ).backgroundColor(Colors.transparent).h24(context);
  }
}

class ResultContent extends StatelessWidget {
  final Result result;

  const ResultContent({Key key, this.result}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      //color: context.accentColor,
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 12,
          ),
          result.overview.text.bold.xl.make(),
          SizedBox(
            height: 8,
          ),
          result.description.text.sm.gray700.make(),
          SizedBox(
            height: 16,
          ),
          "We advise you to :".text.bold.xl.make(),
          SizedBox(
            height: 8,
          ),
          ...result.advices.mapIndexed(
            (advice, index) => ListTile(
              isThreeLine: true,
              leading: CircleAvatar(
                child: "${index + 1}".text.make(),
              ),
              title: "What you must do".text.semiBold.make(),
              subtitle:
                  "How you must do it is a description for how to do the feature thata is noted on the top of the feature"
                      .text
                      .sm
                      .make(),
            ).py4(),
          )
        ],
      ).p8(),
    );
  }
}
