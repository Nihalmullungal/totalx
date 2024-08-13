import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_event.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_state.dart';
import 'package:totalx/domain/functions/firebase_operation.dart';
import 'package:totalx/domain/modals/user_modal/user_modal.dart';
import 'package:totalx/presentation/common/appconstants.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitialState()) {
    //////////////////// to logout  ////////////////////////

    on<LogoutClickedEvent>((event, emit) async {
      await AppConstants.logout();
      emit(LogoutClickedState());
    });

    //////////////////// to select a image of user ////////////////////////

    on<ImageSelectedEvent>((event, emit) {
      emit(ImageSelectedState());
    });

    //////////////////// to add a user ////////////////////////

    on<SaveClickedEvent>((event, emit) async {
      emit(ModalLoadingState());
      final image = await imageUpload(selectedImage.toString());
      final obj = UserModal(
          name: namecont.text.trim(),
          age: int.parse(agecont.text),
          image: image);
      await addUser(obj);
      clearAllField();
      isSearch = false;
      emit(UploadDoneState());
    });

    //////////////////// to handle error while adding a user ////////////////////////

    on<NameFieldErrorEvent>((event, emit) => emit(NameFieldErrorState()));
    on<AgeFieldErrorEvent>((event, emit) => emit(AgeFieldErrorState()));
    on<ImageNotAddedEvent>((event, emit) => emit(ImageNotAddedState()));

    //////////////////// to show users ////////////////////////
    on<ShowUserEvent>((event, emit) {
      showUserList(event.val);
      emit(ShowUserState());
    });

    //////////////////// to search a user ////////////////////////

    on<SearchEvent>((event, emit) {
      isSort = false;
      emit(SearchState());
    });

    //////////////////// to sort a user ////////////////////////

    on<SortClickedEvent>((event, emit) {
      isSort = true;
      searchcont.clear();
      sortingIndex = event.index;
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
  List<QueryDocumentSnapshot> userList = [];
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

  //////////////////// to image selector ////////////////////////

  Future<void> imageSelector() async {
    final ImagePicker picker = ImagePicker();
    final _image = await picker.pickImage(source: ImageSource.gallery);
    selectedImage = _image?.path;
    add(ImageSelectedEvent());
  }

  //////////////////// to clear all field ////////////////////////

  clearAllField() {
    selectedImage = null;
    agecont.clear();
    namecont.clear();
    searchcont.clear();
  }

  //////////////////// function to search a user ////////////////////////

  onSearchChanged() {
    isSearch = true;
    if (debouncer?.isActive ?? false) debouncer?.cancel();
    debouncer = Timer(const Duration(milliseconds: 500), () {
      add(SearchEvent());
    });
  }

  /////////////////
  showUserList(List<QueryDocumentSnapshot<Map<String, dynamic>>> val) async {
    //  final List<QueryDocumentSnapshot> filteredDocs =
    userList = val.where((doc) {
      final Map<String, dynamic> data = doc.data();
      final fieldValue =
          isSort ? data["age"] : data['name'].toString().toLowerCase();
      if (isSort) {
        if (sortingIndex == 0) {
          return true;
        } else if (sortingIndex == 1) {
          return fieldValue >= 60;
        } else if (sortingIndex == 2) {
          return fieldValue < 60;
        }
      }
      return fieldValue.contains(searchcont.text.toLowerCase());
    }).toList();
  }
}
