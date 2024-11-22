import 'package:flutter/material.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 20,
            width: 20,
            child: LinearProgressIndicator(
              color: Colors.pink,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.pink),
          ),
        ],
      ),
    );
  }
}
