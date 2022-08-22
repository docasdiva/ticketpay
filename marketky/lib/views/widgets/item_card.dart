import 'package:flutter/material.dart';
//import 'package:marketky/core/model/Event.dart';
//import 'package:marketky/constant/app_color.dart';
//import 'package:marketky/core/model/Product.dart';
import 'package:marketky/models/my_event.dart';
import 'package:marketky/views/screens/product_detail.dart';

//import 'rating_tag.dart';
//import 'package:marketky/views/widgets/rating_tag.dart';
//import 'package:pecahan_rupiah/pecahan_rupiah.dart';

class EvItemCard extends StatelessWidget {
  final MyEvent myEvent;
  EvItemCard({@required this.myEvent});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetail(ev_ev: myEvent)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 16 - 8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // item image
            // Container(
            //   width: MediaQuery.of(context).size.width / 2 - 16 - 8,
            //   height: MediaQuery.of(context).size.width / 2 - 16 - 8,
            //   padding: EdgeInsets.all(10),
            //   alignment: Alignment.topLeft,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(16),
            //     image: DecorationImage(
            //         image: AssetImage(myEvent.photo), fit: BoxFit.cover),
            //   ),
            //  child: RatingTag(value: myEvent.rating),
            // ),

            // item details
            Container(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(myEvent.nom,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2, bottom: 8),
                    child: Text(
                      '${myEvent.desc}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Text(
                    '${myEvent.nbPlace}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
