import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopBoxWidgetData {
  String heading;
  String value;

  TopBoxWidgetData({
    required this.heading,
    required this.value,
  });
}

class TopBoxWidget extends StatefulWidget {
  final bool forSmallDevice;
  final List<TopBoxWidgetData> topBoxDataList;
  final String heading;

  const TopBoxWidget({
    required this.topBoxDataList,
    required this.forSmallDevice,
    required this.heading,
    Key? key,
  }) : super(key: key);

  @override
  State<TopBoxWidget> createState() => _TopBoxWidgetState();
}

class _TopBoxWidgetState extends State<TopBoxWidget> {
  bool isExpanded = false;

  @override
  void initState() {
    isExpanded = !widget.forSmallDevice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: Alignment.topCenter,
      duration: const Duration(milliseconds: 500),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: HeadingWidget(
                heading: widget.heading,
                isExpanded: isExpanded,
                isSmallScreen: widget.forSmallDevice,
              ),
            ),
            if (isExpanded || !widget.forSmallDevice)
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 5.h,
                  horizontal: 5.w,
                ),
                child: Column(
                  children: [
                    for (TopBoxWidgetData value in widget.topBoxDataList)
                      SingleDetailItem(
                        heading: value.heading,
                        value: value.value,
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SingleDetailItem extends StatelessWidget {
  final String heading;
  final String value;

  const SingleDetailItem({
    required this.heading,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 7.5.h,
      ),
      child: Row(
        children: [
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Theme.of(context).primaryColor,
          ),
          Flexible(
            flex: 2,
            child: Text(
              "$heading ",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeadingWidget extends StatelessWidget {
  final String heading;
  final bool isExpanded;
  final bool isSmallScreen;

  const HeadingWidget({
    required this.heading,
    required this.isExpanded,
    required this.isSmallScreen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
          bottomLeft: isExpanded ? Radius.zero : Radius.circular(10.r),
          bottomRight: isExpanded ? Radius.zero : Radius.circular(10.r),
        ),
        color: Theme.of(context).primaryColor.withOpacity(0.8),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 5.w,
          ),
          Text(
            heading,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          if (isSmallScreen) ...[
            const Spacer(),
            Icon(
              isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              color: Colors.white,
            ),
            SizedBox(
              width: 5.w,
            ),
          ]
        ],
      ),
    );
  }
}
