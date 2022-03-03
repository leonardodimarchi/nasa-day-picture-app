import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:nasa_picture_of_the_day/features/domain/entities/space_media_entity.dart';
import 'package:nasa_picture_of_the_day/features/presenter/controllers/home_store.dart';
import 'package:nasa_picture_of_the_day/features/presenter/pages/picture_page.dart';
import 'package:nasa_picture_of_the_day/features/presenter/widgets/custom_app_bar.dart';
import 'package:nasa_picture_of_the_day/features/presenter/widgets/round_button.dart';
import 'package:nasa_picture_of_the_day/features/presenter/widgets/show_media_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  void initState() {
    super.initState();
    store.getSpaceMediaByDate(DateTime.now());
  }

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
                ScopedBuilder(
                  store: store,
                  onLoading: (context) => const Center(child: CircularProgressIndicator()),
                  onError: (context, error) => Center(
                    child: Text(
                      'An error occurred, try again later.',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  onState: (context, SpaceMediaEntity spaceMedia) {
                    return ShowMediaCard(
                      spaceMedia: spaceMedia,
                      title: 'Today\'s ' + spaceMedia.type
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: RoundButton(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
