import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';



class ImageViewer extends StatefulWidget {

  final List<String> imageLinks;
  final int initialIndex;

  ImageViewer({required this.imageLinks, this.initialIndex = 0});

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {

  late int currentIndex;
  late PageController page;


  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    page = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            color: Colors.black, // Background color
            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              allowImplicitScrolling: true,
              itemCount: widget.imageLinks.length,
              loadingBuilder: (context, event) {
                return Center(
                  child: CircularProgressIndicator(
                    value: event == null
                        ? null
                        : event.cumulativeBytesLoaded /
                        event.expectedTotalBytes!,
                  ),
                );
              },
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  tightMode: true,
                  imageProvider: CachedNetworkImageProvider(
                    widget.imageLinks[index],
                  ),
                  initialScale: PhotoViewComputedScale.contained,
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                );
              },
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              pageController: page,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    if (currentIndex == 0) {
                      setState(() {
                        currentIndex = widget.imageLinks.length - 1;
                        page.jumpToPage(currentIndex);
                      });
                      return;
                    } else if (currentIndex > 0) {
                      setState(() {
                        currentIndex--;
                        page.jumpToPage(currentIndex);
                      });
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    if (currentIndex == widget.imageLinks.length - 1) {
                      setState(() {
                        currentIndex = 0;
                        page.jumpToPage(currentIndex);
                      });
                      return;
                    } else if (currentIndex < widget.imageLinks.length - 1) {
                      setState(() {
                        currentIndex++;
                        page.jumpToPage(currentIndex);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
