import 'package:flutter/material.dart';
class BubbleMessage extends StatelessWidget {
  const BubbleMessage({
    Key? key,
    required this.msg,
    required this.username,
    required this.key1,
    required this.isMe,
  }) : super(key: key);

  final String msg;
  final String username;
  final Key key1;
  final bool isMe;
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: isMe? MainAxisAlignment.end:MainAxisAlignment.start,
      children: [
          Container(
            decoration: BoxDecoration(
              color: isMe? Colors.grey[300]:Colors.blueAccent,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(14),
                topRight: const Radius.circular(14),
                bottomLeft: isMe? const Radius.circular(0): const Radius.circular(14),
                bottomRight: isMe? const Radius.circular(0): const Radius.circular(14)
              )
            ),
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                child: Column(
                  crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
                  children: [
                    Text(
                      msg,style: TextStyle(
                      color: isMe? Colors.black:Colors.white,
                    ),
                      textAlign: isMe? TextAlign.end:TextAlign.start
                      ),
                  ],
              ),
          )
      ],
    );
  }
}
