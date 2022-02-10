import 'package:flutter/material.dart';

import 'AudioPlayer.dart';

class MediaWidget extends StatefulWidget {
  String? url;
  String? title;
  String? date;
  String? text;
  String? status;

  MediaWidget(
      {Key? key,
      required this.url,
      required this.text,
      required this.title,
      required this.status,
       this.date});

  @override
  _MediaWidgetState createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: mediaPlayer(widget.url!),
    );
  }

  Widget mediaPlayer(String url) {
    print('url_media_is: $url');
    return AudioPlayerUrl(
      url: url,
      status:widget.status ??'' ,
      text:widget.text ?? '' ,
      title: widget.title ?? '',
      date:  widget.date ?? '',
    );

    return Container();
  }

  String extension(String path) {
    return path.split('.').last;
  }
}
