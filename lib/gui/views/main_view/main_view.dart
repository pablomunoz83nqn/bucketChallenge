import 'package:bucket_challenge/gui/views/widgets/params_input_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MainView());

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buckets challenge Pablo'),
      ),
      body: const ParamsWidget(),
    );
  }
}
