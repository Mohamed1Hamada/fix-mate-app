import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/features/chat/models/chat_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'my_chats_state.dart';

class MyChatsCubit extends Cubit<MyChatsState> {
  MyChatsCubit() : super(MyChatsInitial()) {
    getMyChats();
  }
// --> list of my chats
  List<ChatModel> myChats = [];
  List<ChatModel> filterMyChats = [];
  final supabase = getIt<SupabaseClient>();
// --> get my chats
  getMyChats() async {
    try {
      log("cahst");
      emit(GetMyChatsLoading());
      final response = await supabase
          .from('chats')
          .select(
              '*, chatWithUser:users!fk_chats_technician(id, full_name, username, image)')
          .eq('customer_id', getIt<SupabaseClient>().auth.currentUser!.id);
      log("cahst" + response.toString());
      myChats = response.map((e) => ChatModel.fromJson(e)).toList();
      myChats.sort((a, b) =>
          b.messages!.last.createdAt.compareTo(a.messages!.last.createdAt));
      filterMyChats = myChats;
      emit(GetMyChatsSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetMyChatsError(error: e.toString()));
    }
  }

// --> search for chats
  void searchChats(String value) {
    if (value.isEmpty) {
      filterMyChats = myChats;
    }
    filterMyChats = myChats
        .where((element) =>
            element.messages!.last.message.toLowerCase().contains(value))
        .toList();
    emit(GetMyChatsSuccess());
  }
}
