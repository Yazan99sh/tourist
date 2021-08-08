import 'package:flutter/material.dart';

class CommentItemWidget extends StatelessWidget {
  final String userName;
  final String userImage;
  final DateTime commentDate;
  final String comment;
  final String role;

  CommentItemWidget({
    Key key,
    this.comment,
    this.commentDate,
    this.userImage,
    this.userName,
    this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 36,
              width: 36,
              child: userImage.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        userImage,
                        fit: BoxFit.cover,
                        errorBuilder: (_, v, c) {
                          return Stack(
                            children: [
                              role != 'guid'
                                  ? Container(
                                      height: 36,
                                      width: 36,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                    )
                                  : Icon(
                                      Icons.security,
                                      color: Theme.of(context).primaryColor,
                                    ),
                              Center(
                                  child: Text(
                                userName == null
                                    ? ' '
                                    : userName.substring(0, 1).toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              )),
                            ],
                          );
                        },
                      ),
                    )
                  : Stack(
                      children: [
                        role != 'guid'
                            ? Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle,
                                ),
                              )
                            : Icon(
                                Icons.security,
                                color: Theme.of(context).primaryColor,
                              ),
                        Center(
                            child: Text(
                          userName == null
                              ? ' '
                              : userName.substring(0, 1).toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )),
                      ],
                    ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    comment,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
          Text(this.commentDate.toIso8601String().substring(0, 10))
        ],
      ),
    );
  }
}
