import 'package:flutter/material.dart';
import 'package:test_task/DetailedQuotePage/DetailedQuoteScreen.dart';
import 'package:test_task/assets/Constants.dart';

class QuoteListPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: buildCityList(listCity),
    );
  }

  Widget buildCityList(listCity) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ListView.builder(
          itemCount: listCity.length,
          itemBuilder: (ctx, pos) {
            var pos1 = pos + 1;
            return InkWell(
              child: Container(
                height: 131,
                padding: EdgeInsets.only(left: 13.0, right: 9.0, bottom: 16.0),
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: colorMain,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          pos1.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        flex: 1,
                      ),
                      VerticalDivider(
                        color: Color(0xFFC2C2C2),
                        indent: 25,
                        endIndent: 18,
                        thickness: 0.5,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 14, left: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                listCity[pos + 1][0],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 20,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Text(
                                  listCity[pos + 1][1],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        flex: 7,
                      )
                    ],
                  ),
                ),
              ),
              onTap: () {
                navigateToDetailPage(ctx, listCity[pos + 1][0]);
              },
            );
          }),
    );
  }

  var listCity = {
    1: ['Moscow', 'Russia'],
    2: ['Helsinki', 'Finland'],
    3: ['Murino', 'Russia'],
    4: ['Kirov', 'Russia'],
    5: ['Ulyanovsk', 'Russia'],
  };

  void navigateToDetailPage(BuildContext context, String city) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailedQuotePage(
        city: city,
      );
    }));
  }
}
