import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_chat/model/chat/chat_model.dart';

@provide
class ChatRepository {
  Firestore _firestore = Firestore.instance;

  Stream<QuerySnapshot> requestMessages(String chatRoomID) {
    return _firestore
        .collection('chat_rooms')
        .document(chatRoomID)
        .collection('messages')
        .snapshots();
  }

  void sendMessage(String chatRoomID, ChatModel chatMessage) {
    _firestore
        .collection('chat_rooms')
        .document(chatRoomID)
        .collection('messages')
        .add(chatMessage.toJson());
  }
}