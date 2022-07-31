import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackon_amazon/model/review.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingReview extends StatefulWidget {
  const RatingReview({Key? key}) : super(key: key);

  @override
  State<RatingReview> createState() => _RatingReviewState();
}

class _RatingReviewState extends State<RatingReview> {
  List<Review> review = [
    Review(
        reviewer: 'Pratham',
        rating: '4.5',
        dateTime: DateTime.now(),
        text: 'Good Product',
        imgUrl: 'https://cdn-icons-png.flaticon.com/512/1946/1946429.png'),
    Review(
        reviewer: 'Riya',
        rating: '4.5',
        dateTime: DateTime.now(),
        text: 'Good Product and worth the price',
        imgUrl: 'https://cdn-icons-png.flaticon.com/512/1946/1946429.png'),
    Review(
        reviewer: 'Kabir',
        rating: '2.5',
        dateTime: DateTime.now(),
        text: 'Not good came damaged',
        imgUrl: 'https://cdn-icons-png.flaticon.com/512/1946/1946429.png'),
    Review(
        reviewer: 'Nitish',
        rating: '3.5',
        dateTime: DateTime.now(),
        text: 'Good Product and worth the price',
        imgUrl: 'https://cdn-icons-png.flaticon.com/512/1946/1946429.png'),
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return ListView.builder(
        itemCount: review.length,
        shrinkWrap: true,
        itemBuilder: ((context, index) => ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(review[index].imgUrl),
                backgroundColor: Colors.transparent,
              ),
              title: Text(review[index].reviewer),
              trailing: RatingBarIndicator(
                rating: double.parse(review[index].rating),
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.orange,
                ),
                itemCount: 5,
                itemSize: height * 0.015,
                unratedColor: Colors.grey,
                direction: Axis.horizontal,
              ),
              subtitle: Text(review[index].text),
            )));
  }
}
