import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_bloc.dart';
import 'package:totalx/presentation/common/custom_text_field.dart';
import 'package:totalx/presentation/common/font_theme.dart';
import 'package:totalx/presentation/home_screen/widgets/home_screen/home_sort_modal.dart';

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final homec = BlocProvider.of<HomeScreenBloc>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 8, left: 8),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              hint: "Search By Name",
              prefix: const Icon(Icons.search),
              hintStyle: FontTheme.hint,
              onChanged: (p0) {
                homec.onSearchChanged();
              },
              cont: homec.searchcont,
              isSearch: true,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () {
                homeSortModal(context);
              },
              style: IconButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              icon: const Icon(
                Icons.filter_list,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
