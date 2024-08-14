import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_bloc.dart';
import 'package:totalx/application/homescreen_bloc/homescreen_state.dart';
import 'package:totalx/presentation/common/font_theme.dart';
import 'package:totalx/presentation/home_screen/widgets/custom_dialog.dart';
import 'package:totalx/presentation/login_screen/login_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      color: Colors.black,
      child: SafeArea(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        Text(
                          "Nilambur",
                          style: FontTheme.location,
                        ),
                      ],
                    ),
                    const Spacer(),
                    BlocListener<HomeScreenBloc, HomeScreenState>(
                      listener: (context, state) {
                        if (state is LogoutClickedState) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Logout succesfully",
                              style: FontTheme.subHeading,
                            ),
                            backgroundColor: Colors.green,
                          ));
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => false);
                        }
                      },
                      child: IconButton(
                          onPressed: () {
                            customDialog(context);
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(150, 80);
}
