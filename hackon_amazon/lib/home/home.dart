import 'package:flutter/material.dart';
import 'package:hackon_amazon/home/product_detail.dart';
import 'package:hackon_amazon/model/product.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> products = [
    Product(
        id: 1,
        name: 'Nike Shoes',
        subtext:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        imgUrl: ['https://m.media-amazon.com/images/I/71UYWAQk9yL._UX575_.jpg'],
        price: '5,999',
        liked: false,
        discount: "25%",
        oldPrice: "15,999",
        verify: 'Positive',
        authenticated: true,
        itemCount: 1),
    Product(
      id: 2,
      name: 'Nike Men\'s Flex 2018 Rn Running Shoes',
      subtext:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      imgUrl: ['https://m.media-amazon.com/images/I/51Q62V2hzqL._UY575_.jpg'],
      price: '18,999',
      liked: false,
      discount: "50%",
      oldPrice: "35,999",
      verify: 'Neutral',
      authenticated: false,
      itemCount: 2,
    ),
    Product(
      id: 3,
      name: 'Adidas Men\'s Ub19 Td Running Shoe',
      subtext:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      imgUrl: ['https://m.media-amazon.com/images/I/61Pn-0S3lML._UY575_.jpg'],
      price: '13,999',
      liked: true,
      discount: "50%",
      oldPrice: "27,999",
      verify: 'Negative',
      authenticated: false,
      itemCount: 0,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Nitish'),
        backgroundColor: Colors.orange,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: products.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.18,
                      child: StorePageProductCard(
                        product: products[index],
                      ));
                })
          ],
        ),
      ),
    );
  }
}

class StorePageProductCard extends StatefulWidget {
  final Product product;
  const StorePageProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<StorePageProductCard> createState() => _StorePageProductCardState();
}

class _StorePageProductCardState extends State<StorePageProductCard> {
  Map<String, bool> isCart = {};
  Map<String, bool> isWishListed = {};
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) =>
                ProductDetailPage(productDetail: widget.product),
          ),
        );
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 0,
          child: Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, bottom: 12, top: 12),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.21,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(widget.product.imgUrl[0]),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(widget.product.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                              GestureDetector(
                                  onTap: () async {},
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                          Text(widget.product.subtext,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                // color: ColorConstants.healthPageTextColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              )),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('Rs. ${widget.product.price} /- ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                              // check if cart has id of product
                              SizedBox(
                                  height: 30,
                                  child: TextButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0))),
                                          alignment: Alignment.center,
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.orange)),
                                      child: Text(' Add to Cart ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                          )),
                                      onPressed: () async {})),
                            ],
                          ),
                        ],
                      ),
                    )
                  ]))),
    );
  }
}
