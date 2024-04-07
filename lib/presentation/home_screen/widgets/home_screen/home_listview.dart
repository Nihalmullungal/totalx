import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_bloc.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_event.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_state.dart';
import 'package:totalx/presentation/common/firebase_constants.dart';
import 'package:totalx/presentation/home_screen/widgets/list%20view/list_view_image.dart';
import 'package:totalx/presentation/home_screen/widgets/list%20view/list_view_name.dart';

class HomeListView extends StatelessWidget {
  const HomeListView({super.key});

  @override
  Widget build(BuildContext context) {
    final homec = BlocProvider.of<HomeScreenBloc>(context);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(FirebaseConstants.user)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Text("No data");
        } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
          return Center(
              child: Lottie.asset("assets/lottie/No data.json", height: 250));
        } else {
          homec.add(ShowUserEvent(val: snapshot.data!.docs));
          return BlocBuilder<HomeScreenBloc, HomeScreenState>(
            builder: (context, state) {
              state is ShowUserState || state is ModalLoadingState
                  ? log("state is $state")
                  : homec.add(ShowUserEvent(val: snapshot.data!.docs));
              return homec.userList.isNotEmpty
                  ? Expanded(
                      child: SizedBox(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return Material(
                                elevation: 8,
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * .1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      ListViewImage(
                                          image: homec.userList[index]
                                              ["image"]),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      ListViewName(
                                        name: homec.userList[index]["name"],
                                        age: homec.userList[index]["age"],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 10,
                                ),
                            itemCount: homec.userList.length),
                      ),
                    )
                  : Center(
                      child: Lottie.asset("assets/lottie/No data.json",
                          height: 150));
            },
          );
        }
      },
    );
  }
}
