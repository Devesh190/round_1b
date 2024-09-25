import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class customWidgets {
  static showCustomSnackbar(
      bool isSuccess, String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        padding: const EdgeInsets.all(8),
        height: 80,
        decoration: BoxDecoration(
            color: isSuccess ? Colors.green : Colors.red,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.clear,
              color: Colors.white,
              size: 40,
            ),
            SizedBox(width: 20),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isSuccess ? "Success" : "Oops",
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }
}
