import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:http/http.dart';
import 'package:marketky/constant/app_color.dart';
//import 'package:marketky/core/model/Product.dart';
import 'package:marketky/models/my_event.dart';
//import 'package:marketky/views/screens/image_viewer.dart';
import 'package:marketky/views/widgets/custom_app_bar.dart';
import 'package:marketky/views/widgets/modals/add_to_cart_modal.dart';
//import 'package:marketky/views/widgets/rating_tag.dart';
//import 'package:marketky/views/widgets/selectable_circle_color.dart';
//import 'package:marketky/views/widgets/selectable_circle_size.dart';
//import 'package:pecahan_rupiah/pecahan_rupiah.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'image_viewer.dart';

class ProductDetail extends StatefulWidget {
  final MyEvent ev_ev;
  ProductDetail({@required this.ev_ev});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  PageController productImageSlider = PageController();
  @override
  Widget build(BuildContext context) {
    MyEvent event_ee = widget.ev_ev;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: AppColor.border, width: 1),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              margin: EdgeInsets.only(right: 14),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColor.secondary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                onPressed: () {},
                child: SvgPicture.asset('assets/icons/Chat.svg',
                    color: Colors.white),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 64,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColor.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return AddToCartModal();
                      },
                    );
                  },
                  child: Text(
                    'Ajouter au panier',
                    style: TextStyle(
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          // Section 1 - appbar & product image
          Stack(
            alignment: Alignment.topCenter,
            children: [
              // product image
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        // builder: (context) => ImageViewer(imageUrl:"/" ),
                        ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 310,
                  color: Colors.white,
                  child: PageView(
                    physics: BouncingScrollPhysics(),
                    controller: productImageSlider,
                    children: List.generate(
                      event_ee.photo.length,
                      (index) => Image.asset(
                        event_ee.photo[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              // appbar
              CustomAppBar(
                title: '${event_ee.desc}',
                leftIcon: SvgPicture.asset('assets/icons/Arrow-left.svg'),
                rightIcon: SvgPicture.asset(
                  'assets/icons/Bookmark.svg',
                  color: Colors.black.withOpacity(0.5),
                ),
                leftOnTap: () {
                  Navigator.of(context).pop();
                },
                rightOnTap: () {},
              ),
              // indicator
              Positioned(
                bottom: 16,
                child: SmoothPageIndicator(
                  controller: productImageSlider,
                  count: event_ee.photo.length,
                  effect: ExpandingDotsEffect(
                    dotColor: AppColor.primary.withOpacity(0.2),
                    activeDotColor: AppColor.primary.withOpacity(0.2),
                    dotHeight: 8,
                  ),
                ),
              ),
            ],
          ),
          // Section 2 - product info
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          event_ee.nom,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'poppins',
                              color: AppColor.secondary),
                        ),
                      ),
                      /*  RatingTag(
                        margin: EdgeInsets.only(left: 10),
                        value: event.rating,
                      ),*/
                    ],
                  ),
                ),
                /*Container(
                  margin: EdgeInsets.only(bottom: 14),
                  child: Text(
                    '${Pecahan.rupiah(value: MyEvent.price, withRp: true)}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'poppins', color: AppColor.primary),
                  ),
                ),*/
                Expanded(
                  child: Text(
                    event_ee.desc,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'poppins',
                        color: AppColor.secondary),
                  ),
                ),
              ],
            ),
          ),
          // Section 3 - Color Picker
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16),
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Type',
                  style: TextStyle(
                    color: AppColor.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'poppins',
                  ),
                ),
                /*SelectableCircleColor(
                  colorWay: event.colors,
                  margin: EdgeInsets.only(top: 12),
                ),*/
              ],
            ),
          ),

          // Section 4 - Size Picker
          /* Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16),
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Size',
                  style: TextStyle(
                    color: AppColor.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'poppins',
                  ),
                ),
                SelectableCircleSize(
                  productSize: product.sizes,
                  margin: EdgeInsets.only(top: 12),
                ),
              ],
            ),
          ),
*/
          // Section 5 - Reviews
        ],
      ),
    );
  }
}
