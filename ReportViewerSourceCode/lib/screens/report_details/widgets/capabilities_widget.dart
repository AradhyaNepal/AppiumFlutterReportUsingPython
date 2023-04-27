import 'package:appium_report/screens/report_details/widgets/top_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/capabilities.dart';

class CapabilitiesWidget extends StatefulWidget {
  final bool forSmallDevice;
  final Capabilities capabilities;

  const CapabilitiesWidget({
    required this.capabilities,
    required this.forSmallDevice,
    Key? key,
  }) : super(key: key);

  @override
  State<CapabilitiesWidget> createState() => _CapabilitiesWidgetState();
}

class _CapabilitiesWidgetState extends State<CapabilitiesWidget> {
  bool isExpanded = false;

  @override
  void initState() {
    isExpanded = !widget.forSmallDevice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TopBoxWidget(
      topBoxDataList: [
        TopBoxWidgetData(
            heading: "Automation", value: widget.capabilities.automationName),
        TopBoxWidgetData(
            heading: "Platform", value: widget.capabilities.platformName),
        TopBoxWidgetData(
            heading: "Device", value: widget.capabilities.deviceName),
        TopBoxWidgetData(
            heading: "Package", value: widget.capabilities.appPackage),
        TopBoxWidgetData(
            heading: "Activity", value: widget.capabilities.appActivity),
      ],
      forSmallDevice: widget.forSmallDevice,
      heading: 'Capabilities',
    );
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
                heading: "Capabilities",
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
                  children: [],
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
