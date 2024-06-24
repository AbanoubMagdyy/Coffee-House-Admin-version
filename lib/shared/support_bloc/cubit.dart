import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_house_admin_version/shared/support_bloc/states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../components/constants.dart';
import '../../models/massage_model.dart';
import '../../models/user_model.dart';

class SupportCubit extends Cubit<SupportStates> {
  SupportCubit() : super(InitialState());

  static SupportCubit get(context) => BlocProvider.of(context);


List<String> thePeopleWhoSentTheirComplaints = [];
  void getThePeopleWhoSentTheirComplaints()  {
    emit(LoadingGetThePeopleWhoSentTheirComplaints());
     FirebaseFirestore.instance
        .collection('Support')
        .snapshots()
        .listen((value) {
          thePeopleWhoSentTheirComplaints = [];
       thePeopleWhoSentTheirComplaints = value.docs.map((doc) => doc.id).toList();
      emit(SuccessGetThePeopleWhoSentTheirComplaints());
    });
  }

 UserModel? userModel;
  Future<void> getUserInformation(String email) async {
    emit(LoadingGetUserInformation());
    await FirebaseFirestore.instance
        .collection('Users')
    .doc(email)
        .get()
        .then((value) {
          userModel = UserModel.fromJson(value.data()!);
      emit(SuccessGetUserInformation());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorGetUserInformation());
    });
  }

  List<MessageModel> messages = [];
  void getMessages(String email)  {
    FirebaseFirestore.instance
        .collection('Support')
        .doc(email)
    .collection('Chat')
        .orderBy('datetime')
        .snapshots()
        .listen((value) {
          messages = [];
          for(var message in value.docs){
            messages.add(MessageModel.fromJson(message.data()));
          }
      emit(SuccessGetMessages());
    });
  }

  void sendMessage({
    required String message,
    required String userEmail,
  }) {
    DateTime now = DateTime.now();
    String time = DateFormat.jm().format(now);
    MessageModel model = MessageModel(
        email: email,
        dateTime: now,
        message: message,
        time: time,
    );
    FirebaseFirestore.instance
        .collection('Support')
        .doc(userEmail)
        .collection('Chat')
        .add(model.toMap())
        .then((value) {
      emit(SuccessSendMessage());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorSendMessage());
    });
  }


  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(userEmail) {
    return FirebaseFirestore.instance
        .collection('Support')
    .doc(userEmail)
    .collection('Chat')
        .orderBy('datetime', descending: true)
        .limit(1)
        .snapshots();
  }




}
