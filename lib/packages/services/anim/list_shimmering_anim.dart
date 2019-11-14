import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:org_contact/packages/services/anim/list_animator.dart';
import 'package:org_contact/packages/services/common/colors.dart';
import 'package:shimmer/shimmer.dart';


  Widget shimmerList(String titleText) {
    return Container(
      color: listBgColor,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 30,bottom: 5,top: 25),
            alignment: Alignment.bottomLeft,
            child: Text(
              titleText,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: appBarColor,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 30,right: 30),
              child: ListView.builder(
                      itemCount: 12,
                      itemBuilder: (context,index){
                        return WidgetANimator(
                          Card(
                                color: Colors.white,
                                margin: EdgeInsets.only(bottom: 15),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 12.0,bottom: 12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Image(
                                            image:AssetImage('assets/icons/title.png'),
                                            height: 16,
                                          ),
                                          SizedBox(width: 5,),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Shimmer.fromColors(
                                                  baseColor: Colors.grey,
                                                  highlightColor: Colors.white,
                                                  period: Duration(milliseconds: 3000),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(3),
                                                      color: Colors.white30,
                                                    ),
                                                    height: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 8.0,),
                                      Container(
                                          child: Row(
                                            children: <Widget>[
                                              Image(
                                                image:AssetImage('assets/icons/time_date.png'),
                                                height: 16,
                                              ),
                                              SizedBox(width: 5,),
                                              Shimmer.fromColors(
                                                baseColor: Colors.grey,
                                                highlightColor: Colors.white,
                                                period: Duration(milliseconds: 3000),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(3),
                                                    color: Colors.white30,
                                                  ),
                                                  height: 12,
                                                  width: 180,
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                      SizedBox(height: 10,),
                                      Stack(
                                        children: <Widget>[
                                          Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Image(
                                                    image:AssetImage('assets/icons/status.png'),
                                                    height: 16,
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Shimmer.fromColors(
                                                    baseColor: Colors.grey,
                                                    highlightColor: Colors.white,
                                                    period: Duration(milliseconds: 3000),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(3),
                                                        color: Colors.white30,
                                                      ),
                                                      height: 12,
                                                      width: 100,
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                          titleText=="Response"?
                                          Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Image(
                                                      image:AssetImage('assets/icons/time.png'),
                                                      height: 10,
                                                    ),
                                                    SizedBox(width: 3,),
                                                    Shimmer.fromColors(
                                                      baseColor: timeAgoColor,
                                                      highlightColor: Colors.white,
                                                      period: Duration(milliseconds: 3000),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(3),
                                                          color: Colors.white30,
                                                        ),
                                                        height: 12,
                                                        width: 70,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                          ):Container(),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                          ),
                        );
                      }
                  ),
            ),
          )
        ],
      ),
    );
  }

