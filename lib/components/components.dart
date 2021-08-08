import 'package:flutter/material.dart';
import 'package:newsapp/modules/web_view/webview_screen.dart';

Widget buildArticleItem(article, context) => InkWell(
  onTap: (){
    Navigator.push(context, MaterialPageRoute(builder: (_){
      return WebViewScreen(article['url']);
    }));
  },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                    "${article['urlToImage']}",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "${article['title']}",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Text(
                      "${article['publishedAt']}",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
