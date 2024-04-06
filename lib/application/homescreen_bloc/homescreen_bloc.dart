import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_event.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_state.dart';
import 'package:totalx/domain/functions/firebase_operation.dart';
import 'package:totalx/domain/user_modal.dart';
import 'package:totalx/presentation/common/appconstants.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitialState()) {
    on<LogoutClickedEvent>((event, emit) async {
      await AppConstants.logout();
      emit(LogoutClickedState());
    });
    on<ImageSelectedEvent>((event, emit) {
      emit(ImageSelectedState());
    });
    on<SaveClickedEvent>((event, emit) async {
      emit(ModalLoadingState());
      final _image = await imageUpload(selectedImage.toString());
      final obj = UserModal(
          name: namecont.text.trim(),
          age: int.parse(agecont.text),
          image: _image);
      await addUser(obj);
      clearAllField();
      isSearch = false;
      emit(UploadDoneState());
    });
    on<NameFieldErrorEvent>((event, emit) => emit(NameFieldErrorState()));
    on<AgeFieldErrorEvent>((event, emit) => emit(AgeFieldErrorState()));
    on<ImageNotAddedEvent>((event, emit) => emit(ImageNotAddedState()));
    on<SearchEvent>((event, emit) => emit(SearchState()));
    on<SortClickedEvent>((event, emit) {
      isSort = true;
      sortingIndex = event.index;
      // toSort();
      emit(SortClickedState());
    });
  }

//////////////////////// variables //////////////////////

  String? selectedImage;
  Timer? debouncer;
  String? searchText;
  TextEditingController namecont = TextEditingController();
  TextEditingController agecont = TextEditingController();
  TextEditingController searchcont = TextEditingController();
  bool isSearch = false;
  bool isSort = false;
  List<dynamic> allUserList = [];
  List<dynamic> searchUserList = [];
  int sortingIndex = 0;
  checking() async {
    if (namecont.text.isEmpty) {
      add(NameFieldErrorEvent());
      return false;
    } else if (agecont.text.isEmpty ||
        agecont.text.length > 2 ||
        int.parse(agecont.text) < 0) {
      add(AgeFieldErrorEvent());
      return false;
    } else if (selectedImage == null) {
      add(ImageNotAddedEvent());
      return false;
    } else {
      return true;
    }
  }

  Future<void> imageSelector() async {
    final ImagePicker picker = ImagePicker();
    final _image = await picker.pickImage(source: ImageSource.gallery);
    selectedImage = _image?.path;
    add(ImageSelectedEvent());
  }

  clearAllField() {
    selectedImage = null;
    agecont.clear();
    namecont.clear();
    searchcont.clear();
  }

  onSearchChanged() {
    isSearch = true;
    // toAdd();
    if (debouncer?.isActive ?? false) debouncer?.cancel();
    debouncer = Timer(const Duration(milliseconds: 500), () {
      // searchUser();
      add(SearchEvent());
    });
  }

  // toAdd() async {
  //   searchUserList.clear();
  //   for (var ele in allUserList) {
  //     searchUserList.add(ele);
  //   }
  // }

  // searchUser() async {
  //   searchUserList.clear();
  //   for (var ele in allUserList) {
  //     if (ele["name"]
  //         .toString()
  //         .toLowerCase()
  //         .contains(searchcont.text.toLowerCase())) {
  //       searchUserList.add(ele);
  //     }
  //   }
  // }

  // toSort() async {
  //   searchUserList.clear();
  //   for (var ele in allUserList) {
  //     if (sortingIndex == 0) {
  //       searchUserList.add(ele);
  //     } else if (sortingIndex == 1) {
  //       if (ele["age"] >= 60) {
  //         searchUserList.add(ele);
  //       } else if (sortingIndex == 2) {
  //         if (ele["age"] < 60) {
  //           searchUserList.add(ele);
  //         }
  //       } else {
  //         searchUserList.clear();
  //       }
  //     }
  //   }
  // }
}
