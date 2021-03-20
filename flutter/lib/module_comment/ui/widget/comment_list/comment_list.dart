import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_auth/authorization_routes.dart';
import 'package:tourists/module_comment/response/comment/comment_response.dart';
import 'package:tourists/module_comment/ui/widget/comment_item/comment_item.dart';
import 'package:tourists/module_comment/ui/widget/new_comment/new_comment_widget.dart';

class CommentListWidget extends StatefulWidget {
  final List<CommentModel> comments;
  final int pageSize;
  final Function(String) onCommentPosted;
  final bool isLoggedIn;

  CommentListWidget({
    @required this.comments,
    this.pageSize = 10,
    this.onCommentPosted,
    this.isLoggedIn = false,
  });

  @override
  State<StatefulWidget> createState() => _CommentListWidgetState(this.comments);
}

class _CommentListWidgetState extends State<CommentListWidget> {
  List<CommentModel> allComments = <CommentModel>[];

  List<CommentModel> displayedComments;
  int currentPage = 0;
  bool canShowMore = false;

  _CommentListWidgetState(List<CommentModel> comments) {
    if (comments == null) {
      allComments = [];
      displayedComments = [];
      return;
    }
    comments.reversed.forEach((element) {
      if (element.userName != null && element.comment != null) {
        allComments.add(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (allComments == null) return Container();

    if (allComments.length > widget.pageSize) {
      canShowMore = true;
    }

    try {
      displayedComments =
          allComments.sublist(0, widget.pageSize * (1 + currentPage));
    } catch (e) {
      displayedComments = allComments;
      canShowMore = false;
    }

    List<Widget> comments = [];

    if (widget.isLoggedIn) {
      comments.add(
        NewCommentWidget(
          onCommentAdded: (comment) {
            widget.onCommentPosted(comment);
          },
        ),
      );
    } else {
      comments.add(RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed(
            AuthorizationRoutes.LOGIN_SCREEN,
          );
        },
        child: Text('Please Login!'),
      ));
    }

    displayedComments?.forEach((element) {
      if (element.comment == null || element.userName == null) {
        return;
      }
      comments.add(CommentItemWidget(
        comment: element.comment,
        userName: element.userName,
        commentDate:
            DateTime.fromMillisecondsSinceEpoch(element.date.timestamp * 1000),
      ));
    });

    if (comments.length == 1) {
      comments.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Be the First to comment'),
      ));
    }

    if (canShowMore) {
      comments.add(RaisedButton(
        onPressed: () {
          currentPage++;
          if (mounted) setState(() {});
        },
        child: Text(S.of(context).show_more),
      ));
    }

    return Flex(
      direction: Axis.vertical,
      children: comments,
    );
  }
}
