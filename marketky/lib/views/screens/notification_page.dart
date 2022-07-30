import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketky/constant/app_color.dart';
import 'package:marketky/core/model/Notification.dart';
import 'package:marketky/core/services/NotificationService.dart';
import 'package:marketky/views/screens/event_org_page.dart';
import 'package:marketky/views/widgets/main_app_bar_widget.dart';
import 'package:marketky/views/widgets/menu_tile_widget.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<UserNotification> listNotification = NotificationService.listNotification;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        cartValue: 2,
        chatValue: 2,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          // Section 1 - Menu
          MenuTileWidget(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventOrgPage()));
            },
            icon: SvgPicture.asset(
              'assets/icons/Discount.svg',
              color: AppColor.secondary.withOpacity(0.5),
            ),
            title: 'Evènements',
            subtitle: '',
          ),
          MenuTileWidget(
            onTap: () {},
            icon: SvgPicture.asset(
              'assets/icons/Info Square.svg',
              color: AppColor.secondary.withOpacity(0.5),
            ),
            title: 'Informations',
            subtitle: '',
          ),
          // Section 2 - Status ( LIST )
        ],
      ),
    );
  }
}
