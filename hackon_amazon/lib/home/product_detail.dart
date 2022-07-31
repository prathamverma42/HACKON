import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hackon_amazon/home/rating_review.dart';
import 'package:hackon_amazon/model/product.dart';
import 'package:hackon_amazon/order/order_page.dart';
import 'package:super_tooltip/super_tooltip.dart';

class ProductDetailPage extends StatefulWidget {
  final Product productDetail;
  const ProductDetailPage({Key? key, required this.productDetail})
      : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  final CarouselController _carouselController = CarouselController();

  int _currentSlide = 0;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();
  SuperTooltip? tooltip;

  Future<bool> _willPopCallback() async {
    // If the tooltip is open we don't pop the page on a backbutton press
    // but close the ToolTip
    if (tooltip!.isOpen) {
      tooltip!.close();
      return false;
    }
    return true;
  }

  void onTap() {
    if (tooltip != null && tooltip!.isOpen) {
      tooltip!.close();
      return;
    }

    var renderBox = context.findRenderObject() as RenderBox;
    final overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox?;

    var targetGlobalCenter = renderBox
        .localToGlobal(renderBox.size.center(Offset.zero), ancestor: overlay);

    // We create the tooltip on the first use
    tooltip = SuperTooltip(
      popupDirection: TooltipDirection.down,
      backgroundColor: Colors.orange,
      borderColor: Colors.orange,
      right: 15.0,
      left: 90.0,
      hasShadow: false,
      content: new Material(
          color: Colors.orange,
          child: Text(
            'Verified by our model',
            softWrap: true,
            style: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
                fontWeight: FontWeight.w600),
          )),
    );

    tooltip!.show(context);
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(h * 0.02),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: h * 0.065),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(
                                        Icons.keyboard_arrow_left,
                                        color: Colors.orange,
                                        size: 32,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.productDetail.name,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.3,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(width: w * 0.018),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    SizedBox(width: w * 0.018),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Stack(children: [
                                        Icon(
                                          Icons.shopping_cart_outlined,
                                          color: Colors.orange,
                                        ),
                                        Positioned(
                                          top: 0,
                                          //bottom: 5,
                                          right: 0,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.03),
                                            ),
                                            child: Text(5.toString(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: -0.3,
                                                )),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ]),
                            ])),
                    SizedBox(height: h * 0.02),
                    CarouselSlider(
                      carouselController: _carouselController,
                      options: CarouselOptions(
                        height: h * 0.3,
                        enlargeCenterPage: true,
                        viewportFraction: 0.6,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentSlide = index;
                          });
                        },
                        enableInfiniteScroll: true,
                      ),
                      items: widget.productDetail.imgUrl
                          .map(
                            (item) => Container(
                              child: Container(
                                // margin: EdgeInsets.symmetric(horizontal: 4),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  child: Image.network(
                                    item,
                                    fit: BoxFit.contain,
                                    width: w * 0.5,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: h * 0.01),
                    (widget.productDetail.imgUrl.length == 0 ||
                            widget.productDetail.imgUrl.length == 1)
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                widget.productDetail.imgUrl.asMap().entries.map(
                              (entry) {
                                return GestureDetector(
                                  onTap: () => _carouselController
                                      .animateToPage(entry.key),
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 4.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.orange
                                              : Colors.orange)
                                          .withOpacity(
                                              _currentSlide == entry.key
                                                  ? 0.9
                                                  : 0.4),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                      child: Text(
                        widget.productDetail.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                      child: Row(
                        children: [
                          Text(
                            'Rs./- ${widget.productDetail.price}',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: w * 0.02),
                          Text(
                            'Rs. ${widget.productDetail.oldPrice} /-',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          SizedBox(width: w * 0.02),
                          widget.productDetail.discount != null
                              ? Text('${widget.productDetail.discount} off',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ))
                              : Container(),
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    SizedBox(height: h * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              widget.productDetail.authenticated
                                  ? Text('Authenticated')
                                  : Text('Not Authenticated'),
                              widget.productDetail.authenticated
                                  ? Icon(
                                      Icons.verified,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                              WillPopScope(
                                  onWillPop: _willPopCallback,
                                  child: IconButton(
                                    onPressed: onTap,
                                    icon: Icon(Icons.info),
                                  ))
                            ],
                          ),
                          Row(
                            children: [
                              Text(widget.productDetail.verify),
                              Icon(
                                widget.productDetail.verify == 'Positive'
                                    ? Icons.emoji_emotions
                                    : Icons.emoji_emotions_rounded,
                                color: Colors.orangeAccent,
                              ),
                              WillPopScope(
                                  onWillPop: _willPopCallback,
                                  child: IconButton(
                                    onPressed: onTap,
                                    icon: Icon(Icons.info),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: h * 0.06,
                              child: TextButton(
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OrderPage()));
                                },
                                style: ButtonStyle(
                                  alignment: Alignment.center,
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.orange,
                                  ),
                                ),
                                child: Text(
                                  'Buy Now',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: w * 0.03),
                          Expanded(
                            child: SizedBox(
                              height: h * 0.06,
                              child: TextButton(
                                onPressed: () async {},
                                style: ButtonStyle(
                                  alignment: Alignment.center,
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      side: BorderSide(
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Add to cart',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.orange,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                      child: Center(
                        child: Text(
                          'About the Item',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    Text(
                      widget.productDetail.subtext,
                      //   overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                      child: Center(
                        child: Text(
                          'Ratings and Reviews',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    RatingReview(),
                    SizedBox(
                      height: 50,
                    ),
                  ]),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.orange,
          onPressed: () {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
            );
          },
          label: Row(
            children: [
              Text(
                'Add Review',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  // color: ColorConstants.buttonBackgroundColor,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                padding: const EdgeInsets.all(8.0),
                // child: Icon(FontAwesomeIcons.comment),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
