import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class MarqueeWidget extends StatefulWidget {
  final int flex;
  final String text;
  final Color color;
  final double velocity;
  const MarqueeWidget({
    required this.text,
    required this.flex,
    required this.color,
    super.key,
    required this.velocity,
  });

  @override
  State<MarqueeWidget> createState() => MarqueeWidgetAppState();
}

class MarqueeWidgetAppState extends State<MarqueeWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: Container(
          height: 45,
          decoration: BoxDecoration(
              border: const Border(
                  right: BorderSide(color: cWhite, width: 5),
                  bottom: BorderSide(color: cWhite)),
              color: widget.color),
          child: InkWell(
            onTap: () {
              // Handle tap event if needed
            },
            onHover: (isHovered) {
              setState(() {
                this.isHovered = isHovered;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 200, // Specify the width of your container
                height: 50, // Specify the height of your container
                // color: Colors.grey[300], // Container color
                child: Center(
                  child: isHovered
                      ? Marquee(
                          text: widget.text,
                          style: const TextStyle(fontSize: 16),
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          blankSpace: 20.0,
                          velocity: widget.velocity,
                          pauseAfterRound: const Duration(seconds: 1),
                          startPadding: 10.0,
                          accelerationDuration: const Duration(seconds: 1),
                          accelerationCurve: Curves.linear,
                          decelerationDuration:
                              const Duration(milliseconds: 500),
                          decelerationCurve: Curves.easeOut,
                        )
                      : Center(
                          child: Text(
                          widget.text,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis),
                        )),
                ),
              ),
            ),
          )
          //  Center(child:
          // GooglePoppinsWidgets(text: text, fontsize: 13,fontWeight: FontWeight.w500,)),
          ),
    );
  }
}
