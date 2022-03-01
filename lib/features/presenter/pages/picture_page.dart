import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:nasa_picture_of_the_day/features/domain/entities/space_media_entity.dart';
import 'package:nasa_picture_of_the_day/features/presenter/controllers/home_store.dart';
import 'package:nasa_picture_of_the_day/features/presenter/widgets/custom_video_player.dart';
import 'package:nasa_picture_of_the_day/features/presenter/widgets/description_bottom_sheet.dart';
import 'package:nasa_picture_of_the_day/features/presenter/widgets/image_network_with_loader.dart';
import 'package:nasa_picture_of_the_day/features/presenter/widgets/page_slider_up.dart';

class PicturePage extends StatefulWidget {
  late final DateTime? dateSelected;

  PicturePage({
    Key? key,
    required this.dateSelected,
  }) : super(key: key);

  PicturePage.fromArgs(dynamic arguments, {Key? key}) : super(key: key) {
    dateSelected = arguments['dateSelected'];
  }

  static void navigate(DateTime? dateSelected) {
    Modular.to.pushNamed(
      '/picture',
      arguments: {'dateSelected': dateSelected},
    );
  }

  @override
  _PicturePageState createState() => _PicturePageState();
}

class _PicturePageState extends ModularState<PicturePage, HomeStore> {
  @override
  void initState() {
    super.initState();
    store.getSpaceMediaByDate(widget.dateSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ScopedBuilder(
        store: store,
        onLoading: (context) => const Center(child: CircularProgressIndicator()),
        onError: (context, error) => Center(
          child: Text(
            'An error occurred, try again later.',
            style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.white),
          ),
        ),
        onState: (context, SpaceMediaEntity spaceMedia) {
          return PageSliderUp(
            onSlideUp: () => showDescriptionBottomSheet(
              context: context,
              title: spaceMedia.title,
              description: spaceMedia.description,
            ),
            child: spaceMedia.type == 'video'
                ? CustomVideoPlayer(spaceMedia)
                : spaceMedia.type == 'image' 
                    ? ImageNetworkWithLoader(spaceMedia.url)
                    : Container(),
          );
        },
      ),
    );
  }
}