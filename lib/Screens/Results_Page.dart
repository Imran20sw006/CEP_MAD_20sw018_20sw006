import 'package:calculator/Components/BottomContainer_Button.dart';
import 'package:calculator/constants.dart';
import 'package:calculator/database.dart';
import 'package:calculator/datamodel.dart';
import 'package:flutter/material.dart';
import '../Components/Reusable_Bg.dart';

class ResultPage extends StatefulWidget {
  final String resultText;
  final String bmi;
  final String advise;
  final Color textColor;
  final int weight;
  final int height;

  const ResultPage(
      {super.key,
      required this.textColor,
      required this.resultText,
      required this.bmi,
      required this.advise,
      required this.weight,
      required this.height});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  //making the database instance to save the data into the database
  Helper? dbhelper;

  late Future<List<BMiMODEL>> noteslist;

  @override
  void initState() {
    super.initState();
    dbhelper = Helper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('BMI CALCULATOR'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.bottomCenter,
              child: Text(
                'Your Result',
                style: ktitleTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ReusableBg(
              colour: kactiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.resultText,
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.bmi,
                    style: kBMITextStyle,
                  ),
                  Text(
                    'Normal BMI range:',
                    style: klabelTextStyle,
                  ),
                  Text(
                    '18.5 - 25 kg/m2',
                    style: kBodyTextStyle,
                  ),
                  Text(
                    widget.advise,
                    textAlign: TextAlign.center,
                    style: kBodyTextStyle,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  RawMaterialButton(
                    onPressed: () async{
                      //also saving the data to the database
                      dbhelper?.insert(BMiMODEL(
                        height: widget.height,
                        weight: widget.weight,
                        bmi: widget.resultText, 
                      )).then((value) {
                        print("data has been saved");
                        print("this is height ${widget.height}");
                        print("this is weight ${widget.weight}");
                        print("this is bmi "+ widget.resultText);
                        setState(() {});
                      }).onError((error, stackTrace) {
                        print(stackTrace);
                        print(error.toString());
                      });
                    },

                    constraints: BoxConstraints.tightFor(
                      width: 200.0,
                      height: 56.0,
                    ),
                    fillColor: Color(0xFF4C4F5E),
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      'SAVE RESULT',
                      style: kBodyTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomContainer(
              text: 'RE-CALCULATE',
              onTap: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
