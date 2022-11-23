import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final String url;
  const ImagePreview({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showLargePreview(context, url);
      },
      child: SizedBox(
        height: 120,
        width: 120,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            // imageUrl: "https://cdn.pixabay.com/photo/2022/11/18/01/40/tropical-flower-7599292_960_720.jpg",
            imageUrl: url,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                SizedBox(height: 40, width: 40, child: CircularProgressIndicator(value: downloadProgress.progress),),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  showLargePreview(BuildContext context, String url){
    showDialog(context: context, builder: (context){
      return InteractiveViewer(child: CachedNetworkImage(imageUrl: url,));
    });
  }
}