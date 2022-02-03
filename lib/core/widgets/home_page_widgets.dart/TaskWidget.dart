import 'package:flutter/material.dart';

enum Status { Done, NotDone }

class Task extends StatelessWidget {
  final Status status;
  final int index;
  final String text;
  const Task(
      {Key? key, required this.status, required this.index, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: double.infinity,
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: status == Status.NotDone ? Colors.black : Colors.black87,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(
            color: status == Status.NotDone
                ? Color.fromARGB(255, 91, 91, 91)
                : Color.fromARGB(168, 91, 91, 91)),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            SizedBox(
              width: 12,
            ),
            Text(
              '$index',
              style: TextStyle(
                color: status == Status.NotDone
                    ? Colors.white70
                    : Color.fromARGB(255, 127, 120, 120),
                fontSize: 19,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Container(
              width: 0.3,
              color: status == Status.NotDone
                  ? Colors.white
                  : Color.fromARGB(255, 127, 120, 120),
              margin: EdgeInsets.symmetric(vertical: 5),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(
                  text,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: TextStyle(
                      color: status == Status.NotDone
                          ? Colors.white
                          : Color.fromARGB(255, 127, 120, 120),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5),
                  maxLines: 4,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
