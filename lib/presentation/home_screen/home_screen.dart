import 'package:flutter/material.dart';
import 'package:totalx/presentation/common/font_theme.dart';
import 'package:totalx/presentation/home_screen/widgets/home_screen/home_listview.dart';
import 'package:totalx/presentation/home_screen/widgets/home_screen/home_search_field.dart';
import 'package:totalx/presentation/home_screen/widgets/modal_sheet/custom_app_bar.dart';
import 'package:totalx/presentation/home_screen/widgets/modal_sheet/custom_modal_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          customModalSheet(
            context,
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const HomeSearchField(),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Users Lists",
              style: FontTheme.headingUser,
            ),
            const SizedBox(
              height: 10,
            ),
            const HomeListView()
          ],
        ),
      ),
    );
  }
}
