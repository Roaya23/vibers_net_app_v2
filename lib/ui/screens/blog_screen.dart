import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';
import '/common/apipath.dart';
import '/providers/app_config.dart';
import 'package:provider/provider.dart';

class BlogScreen extends StatefulWidget {
  BlogScreen(this.index);

  final index;

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    var blogList =
        Provider.of<AppConfig>(context, listen: false).appModel!.blogs!;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 30),
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                "${APIData.blogImageUri}${blogList[widget.index].image}",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/placeholder_cover.jpg",
                    height: 170,
                    width: 120.0,
                    fit: BoxFit.cover,
                  );
                },
              )),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              // surfaceTintColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 25.0,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.2,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                bottom: 15.0,
                                top: 40.0,
                              ),
                              child: Text(
                                '${blogList[widget.index].title}',
                                softWrap: true,
                                style:
                                    TextStyles.bold24(color: kWhiteTextColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                              ),
                              child: Text(
                                translate('by_Admin'),
                                softWrap: false,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.semiBold14(color: kMainLight),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                              ),
                              child: Text(
                                DateFormat.yMd()
                                    .format(blogList[widget.index].updatedAt!),
                                softWrap: true,
                                style: TextStyles.semiBold12(),
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: Text(
                                '${blogList[widget.index].detail}',
                                style: TextStyles.regular14(
                                  color: kWhiteTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
