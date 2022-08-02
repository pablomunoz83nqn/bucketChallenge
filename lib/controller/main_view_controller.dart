import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js/javascript_runtime.dart';

class MainViewControllerView extends ChangeNotifier {
  List<dynamic> listXandY = [];
  int firtsBucket = 0;
  int secondBucket = 0;
  int expected = 0;

  Future<List> addFromJs(JavascriptRuntime jsRuntime, int firtsBucket,
      int secondBucket, int expected) async {
    String blocJs = await rootBundle.loadString('assets/bucket.js');
    final jsResult = jsRuntime.evaluate(
        """${blocJs}playGame($firtsBucket, $secondBucket, $expected)""");

    final jsStringResult = jsResult.stringResult;
    var result = jsStringResult.split(',');
    var chunks = [];
    int chunkSize = 2;
    for (var i = 0; i < result.length; i += chunkSize) {
      chunks.add(result.sublist(
          i, i + chunkSize > result.length ? result.length : i + chunkSize));
    }
    listXandY.add(chunks);

    return chunks;
  }
}
