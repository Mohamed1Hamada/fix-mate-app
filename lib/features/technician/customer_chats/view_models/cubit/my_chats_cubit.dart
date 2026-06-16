import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/features/chat/models/chat_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'my_chats_state.dart';

class CustomerChatsCubit extends Cubit<CustomerChatsState> {
  CustomerChatsCubit() : super(CustomerChatsInitial()) {
    getCustomerChats();
  }
// --> list of my chats
  List<ChatModel> myChats = [];
  List<ChatModel> filterCustomerChats = [];
  final supabase = getIt<SupabaseClient>();
// --> get my chats
  getCustomerChats() async {
    try {
      log("cahst");
      emit(GetCustomerChatsLoading());
      final response = await supabase
          .from('chats')
          .select(
              '*, chatWithUser:users!fk_chats_customer(id, full_name, username, image)')
          .eq('technician_id', getIt<SupabaseClient>().auth.currentUser!.id);
      myChats = response.map((e) => ChatModel.fromJson(e)).toList();
      myChats.sort((a, b) =>
          b.messages!.last.createdAt.compareTo(a.messages!.last.createdAt));
      filterCustomerChats = myChats;
      emit(GetCustomerChatsSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetCustomerChatsError(error: e.toString()));
    }
  }

// --> search for chats
  void searchChats(String value) {
    if (value.isEmpty) {
      filterCustomerChats = myChats;
    }
    filterCustomerChats = myChats
        .where((element) =>
            element.messages!.last.message.toLowerCase().contains(value))
        .toList();
    emit(GetCustomerChatsSuccess());
  }
}
