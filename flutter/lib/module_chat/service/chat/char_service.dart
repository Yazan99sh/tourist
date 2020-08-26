import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/module_chat/manager/chat/chat_manager.dart';
import 'package:tourists/module_chat/model/chat/chat_model.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';

@provide
class ChatService {
  final ChatManager _chatManager;
  SharedPreferencesHelper _preferencesHelper;

  ChatService(this._chatManager, this._preferencesHelper);

  // This is Real Time, That is Why I went this way
  final PublishSubject<List<ChatModel>> _chatPublishSubject =
      new PublishSubject();

  Stream<List<ChatModel>> get chatMessagesStream => _chatPublishSubject.stream;

  void requestMessages(String chatRoomID) async {
    _chatManager.getMessages(chatRoomID).listen((event) {
      List<ChatModel> chatMessagesList = [];
      event.documents.forEach((element) {
        chatMessagesList.add(new ChatModel.fromJson(element.data));
      });

      _chatPublishSubject.add(chatMessagesList);
    });
  }

  void sendMessage(String chatRoomID, String msg) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    ChatModel model = new ChatModel(
        msg: msg, sender: user.uid, sentDate: DateTime.now().toIso8601String());
    _chatManager.sendMessage(chatRoomID, model);
  }

  void dispose() {
    _chatPublishSubject.close();
  }
}
