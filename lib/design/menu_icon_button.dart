import 'package:flutter/material.dart';

class MenuIconButton extends StatelessWidget {
  MenuIconButton({
    @required this.iconData,
    @required this.buttonText,
    @required this.avatarColor,
    @required this.iconColor,
    @required this.textColor,
  });
  final IconData iconData;
  final String buttonText;
  final Color avatarColor;
  final Color iconColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: avatarColor,
          child: Icon(
            iconData,
            color: iconColor,
          ),
        ),
        Text(
          buttonText,
          style: TextStyle(
            color: textColor,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class MenuImageButton extends StatelessWidget {
  MenuImageButton({@required this.image, @required this.imageText, @required this.onPress});
  final ImageProvider image;
  final String imageText;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           Image(image: image,
             width: 100,
             height: 100,
           ),
            Text(imageText,textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}
