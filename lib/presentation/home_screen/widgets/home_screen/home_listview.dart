import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_bloc.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_state.dart';
import 'package:totalx/presentation/common/firebase_constants.dart';
import 'package:totalx/presentation/home_screen/widgets/list%20view/list_view_image.dart';
import 'package:totalx/presentation/home_screen/widgets/list%20view/list_view_name.dart';

class HomeListView extends StatelessWidget {
  const HomeListView({super.key});

  @override
  Widget build(BuildContext context) {
    final homec = BlocProvider.of<HomeScreenBloc>(context);
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
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
              return Lottie.asset("assets/lottie/No data.json", height: 250);
            } else {
              final List<QueryDocumentSnapshot> filteredDocs =
                  snapshot.data!.docs.where((doc) {
                final Map<String, dynamic> data = doc.data();
                final fieldValue = homec.isSort
                    ? data["age"]
                    : data['name'].toString().toLowerCase();
                if (homec.isSort) {
                  if (homec.sortingIndex == 0) {
                    return true;
                  } else if (homec.sortingIndex == 1) {
                    return fieldValue >= 60;
                  } else if (homec.sortingIndex == 2) {
                    return fieldValue < 60;
                  }
                }
                return fieldValue.contains(homec.searchcont.text.toLowerCase());
              }).toList();
              return BlocBuilder<HomeScreenBloc, HomeScreenState>(
                builder: (context, state) {
                  return filteredDocs.isNotEmpty
                      ? Expanded(
                          child: SizedBox(
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return Material(
                                    elevation: 8,
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .1,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          ListViewImage(
                                              image: filteredDocs[index]
                                                  ["image"]),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          ListViewName(
                                            name: filteredDocs[index]["name"],
                                            age: filteredDocs[index]["age"],
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
                                itemCount: filteredDocs.length),
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
      },
    );
  }
}
