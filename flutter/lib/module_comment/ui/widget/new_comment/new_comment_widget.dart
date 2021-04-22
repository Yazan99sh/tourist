import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';

class NewCommentWidget extends StatelessWidget {
  final Function(String) onCommentAdded;
  final bool active;

  final TextEditingController commentController = TextEditingController();

  NewCommentWidget({
    @required this.onCommentAdded,
    this.active = true,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: commentController,
              decoration: InputDecoration(hintText: '${S.of(context).commentHere}'),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              createComment();
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                  color: active ? Colors.greenAccent : Colors.grey),
            ),
          ),
        )
      ],
    );
  }

  void createComment() {
    if (!active) {
      return;
    }
    if (commentController.text == null) return;
    if (commentController.text.isNotEmpty) {
      onCommentAdded(commentController.text);
    }

    commentController.clear();
  }
}
