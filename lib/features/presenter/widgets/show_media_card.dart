import 'package:flutter/material.dart';
import 'package:nasa_picture_of_the_day/features/domain/entities/space_media_entity.dart';
import 'package:nasa_picture_of_the_day/features/presenter/widgets/custom_video_player.dart';
import 'package:nasa_picture_of_the_day/features/presenter/widgets/image_network_with_loader.dart';

class ShowMediaCard extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final SpaceMediaEntity spaceMedia;
  final String title;

  ShowMediaCard({
    Key? key,
    required this.title,
    required this.spaceMedia,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  Widget getContentWidget() {
    if (spaceMedia.type == 'video') {
      return CustomVideoPlayer(spaceMedia);
    } else if (spaceMedia.type == 'image') {
      return ImageNetworkWithLoader(spaceMedia.url);
    } else {
      return const SizedBox(
        child: Text('Unsupported Media'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Center(
            child: Text(title),
          ),
        ),
        SizedBox(
          height: 200,
          child: getContentWidget(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.purple, Colors.transparent, Colors.transparent, Colors.purple],
              stops: [0.0, 0.1, 0.9, 1.0], // 10% purple, 80% transparent, 10% purple
            ).createShader(bounds);
            },
            child: SizedBox(
              height: 200,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Text(spaceMedia.description, overflow: TextOverflow.fade),
                )
              ),
            ),
            blendMode: BlendMode.dstOut,
          ),
        ),
      ],
    );
  }
}
