
import 'package:flutter/material.dart';
import 'package:nasa_picture_of_the_day/features/presenter/pages/picture_page.dart';
import 'package:nasa_picture_of_the_day/features/presenter/widgets/custom_app_bar.dart';
import 'package:nasa_picture_of_the_day/features/presenter/widgets/round_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Astronomy Picture of the Day', 
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Start by choosing a day",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(
                  height: 150,
                ),
                RoundButton(
                  label: "Select a day",
                  onTap: () async {
                    var datePicked = await showDatePicker(
                      helpText: "Select a datetime",
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1995, 06, 16),
                      lastDate: DateTime.now(),
                    );
                    if (datePicked != null) {
                      PicturePage.navigate(datePicked);
                    }
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}