import 'package:bucket_challenge/controller/main_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_js/flutter_js.dart';

class ParamsWidget extends StatefulWidget {
  const ParamsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ParamsWidget> createState() => _ParamsWidgetState();
}

class _ParamsWidgetState extends State<ParamsWidget> {
  late MainViewControllerView controller;

  @override
  void initState() {
    controller = MainViewControllerView();

    super.initState();
  }

  final JavascriptRuntime jsRuntime = getJavascriptRuntime();
  @override
  Widget build(BuildContext context) {
    return interactiveSpace();
  }

  Center interactiveSpace() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('X 1st Bucket capacity'),
              inputX(),
              const SizedBox(
                height: 20,
              ),
              const Text('Y 2nd Bucket capacity'),
              inputY(),
              const SizedBox(
                height: 20,
              ),
              const Text('Z Expected Volume'),
              inputZ(),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextButton(
                  child: const Text('CALCULATE'),
                  onPressed: () async {
                    if ((controller.firtsBucket + controller.secondBucket) <
                        controller.expected) {
                      showAlertDialog(context);
                    } else {
                      await controller.addFromJs(
                          jsRuntime,
                          controller.firtsBucket,
                          controller.secondBucket,
                          controller.expected);

                      setState(() {});
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text('Bucket X'),
                      Text('Bucket Y'),
                      Text('Explanation'),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(border: Border.all()),
                    child: ListView.builder(
                      itemCount: controller.listXandY.isEmpty
                          ? 0
                          : controller.listXandY.last.length,
                      itemBuilder: (context, index) {
                        try {
                          controller.listXandY.last[index]
                              .removeWhere((item) => item == '');
                          final item = controller.listXandY.last[index];

                          return table(item);
                        } catch (e) {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Error"),
      content: const Text("No Solution"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Container inputZ() {
    return Container(
        width: 100,
        decoration: BoxDecoration(border: Border.all()),
        child: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          onChanged: (value) {
            controller.expected = int.parse(value);
          },
        ));
  }

  Container inputY() {
    return Container(
        width: 100,
        decoration: BoxDecoration(border: Border.all()),
        child: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          onChanged: (value) {
            controller.secondBucket = int.parse(value);
          },
        ));
  }

  Container inputX() {
    return Container(
        width: 100,
        decoration: BoxDecoration(border: Border.all()),
        child: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          onChanged: (value) {
            controller.firtsBucket = int.parse(value);
          },
        ));
  }

  Widget table(item) {
    return Center(
        child: Column(children: <Widget>[
      Container(
        margin: const EdgeInsets.all(5),
        child: Table(
          defaultColumnWidth: const FixedColumnWidth(120.0),
          children: [
            TableRow(children: [
              Column(children: [
                Text(item[0]),
              ]),
              Column(children: [
                Text(item[1].toString()),
              ]),
              Column(children: [Text(checkAction(item, controller))]),
            ]),
          ],
        ),
      ),
    ]));
  }
}

String checkAction(dynamic item, MainViewControllerView controller) {
  int bucketX = int.parse(item[0]);
  int bucketY = int.parse(item[1]);
  int capacityX = controller.firtsBucket;
  int capacityY = controller.secondBucket;

  if (bucketX == 0 && bucketY == 0) {
    return 'Start calculation';
  } else if (bucketX == controller.expected || bucketY == controller.expected) {
    return 'Solved';
  }

// Calculating X < Y
  else if (capacityX < capacityY &&
      bucketX == 0 &&
      bucketY < controller.secondBucket) {
    return 'Empty bucket X';
  } else if (capacityX < capacityY &&
      bucketY == 0 &&
      bucketX < controller.firtsBucket) {
    return 'Transfer Y to X';
  } else if (capacityX < capacityY &&
      (bucketX == 0 && bucketY == controller.secondBucket ||
          bucketX > 0 && bucketY == controller.secondBucket)) {
    return 'Fill Bucket Y';
  } else if (capacityX < capacityY &&
      bucketY == 0 &&
      bucketX == controller.firtsBucket) {
    return 'Fill Bucket X';
  } else if (capacityX < capacityY &&
      bucketX == controller.firtsBucket &&
      bucketY < controller.secondBucket) {
    return 'Transfer Y to X';
  }
//Same for Bucket X  > to Y
  else if (capacityX > capacityY && bucketX < capacityX && bucketY == 0) {
    return 'Empty bucket Y';
  } else if (capacityX > capacityY && bucketX == capacityX && bucketY == 0) {
    return 'Fill Bucket X';
  } else if (capacityX > capacityY && bucketX == 0 && bucketY < capacityY) {
    return 'Transfer X to Y';
  } else if (capacityX > capacityY && bucketX == 0 && bucketY == capacityY) {
    return 'Fill Bucket Y';
  } else if (capacityX > capacityY &&
      bucketX == capacityX &&
      bucketY < capacityY) {
    return 'Fill Bucket X';
  } else if (capacityX > capacityY &&
      bucketY == capacityY &&
      bucketX < capacityX) {
    return 'Transfer X to Y';
  } else {
    return '';
  }
}
