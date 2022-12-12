import 'package:flutter/material.dart';
import 'package:sayakaya_test/const/colors.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  CustomSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        cursorHeight: 22,
        cursorColor: kBlueColor,
        controller: searchController,
        style: const TextStyle(
          color: kWhiteColor,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Search Country Here, Empty to Search All',
          hintStyle: TextStyle(
            color: kWhiteColor,
          ),
          icon: Icon(
            Icons.search,
            color: kWhiteColor,
          ),
        ),
        onFieldSubmitted: (value) {
          // cityFilter = '';
          // context.read<UserBloc>().add(
          //       UserEventFetching(
          //         nameSearch: value,
          //         sortByName: sortByName,
          //       ),
          //     );
        },
        onChanged: (value) {
          if (value.isEmpty) {
            // context.read<UserBloc>().add(
            //       UserEventFetching(
            //         nameSearch: '',
            //         sortByName: sortByName,
            //       ),
            //     );
          }
        },
      ),
    );
  }
}
