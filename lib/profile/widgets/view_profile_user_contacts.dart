import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shiftswift/profile/Cubits/user%20info%20cubit/user_info_cubit.dart';
import 'package:shiftswift/profile/Models/user_info_model.dart';

class ViewProfileUserContacts extends StatelessWidget {
  const ViewProfileUserContacts({super.key});

  @override
  Widget build(BuildContext context) {
    UserInfoModel usermodel =
        BlocProvider.of<UserInfoCubit>(context).userModel!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(FontAwesomeIcons.phone),
            const Text(
              ' Phone Number',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(
          usermodel.phone,
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 16),
        ),
        Divider(height: 15),
        Row(
          children: [
            Icon(FontAwesomeIcons.paperPlane),
            const Text(
              ' Email',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(
          usermodel.email,
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
