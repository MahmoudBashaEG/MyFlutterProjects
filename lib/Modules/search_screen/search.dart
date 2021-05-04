import 'package:flutter/material.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Search extends StatelessWidget {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            defaultTextField(
              label: 'Search',
              controller: search,
              prefixIcon: FontAwesomeIcons.search,
            )
          ],
        ),
      ),
    );
  }
}
