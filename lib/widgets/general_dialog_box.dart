import 'package:flutter/material.dart';

class GeneralDialogBox{
  customLoadingDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 10,),
          Text('Loading'),
          
        ],
      ),
    ));
  }
}