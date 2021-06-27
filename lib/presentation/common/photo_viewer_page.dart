import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewerPage extends StatelessWidget {
  final bool isAssetImage;
  final String imagePathOrUrl;
  const PhotoViewerPage(
      {Key key, this.isAssetImage = true, @required this.imagePathOrUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
        imageProvider: isAssetImage
            ? AssetImage(imagePathOrUrl)
            : NetworkImage(imagePathOrUrl),
      ),
    );
  }
}
