import 'package:flutter/material.dart';

import 'all_tasks.dart';

class NotificationScreen extends StatefulWidget {

  final String? payload;

  NotificationScreen({Key? key, required  this.payload}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _paload ='';

  @override
  void initState() {

    super.initState();
    _paload = widget.payload!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>AllTasksScreen(),
            icon: Icon(Icons.arrow_back_ios)
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          _paload.toString(),
          style: TextStyle(color: Colors.black ),
        ),
      ),
      body:SafeArea(
        child:Column(
          children: [
            SizedBox(height: 20,),
            Text('Hello',
              style:TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color:Colors.black
              ) ,
            ),
            SizedBox(height: 10,),
            Text('You have new reminder ',
              style:TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[100]
              ) ,
            ),
            SizedBox(height: 10,),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.teal
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.text_format,size: 30,color: Colors.white,),
                          SizedBox(width: 20,),
                          Text('Title',
                            style:TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ) ,
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text(
                        _paload.toString().split('|')[0],
                        style: TextStyle(color: Colors.white ,fontSize: 20),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Icon(Icons.description,size: 30,color: Colors.white,),
                          SizedBox(width: 20,),
                          Text('Describtion',
                            style:TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ) ,
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text(
                        _paload.toString().split('|')[1],
                        style: TextStyle(color: Colors.white ,fontSize: 20),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_outlined,size: 30,color: Colors.white,),
                          SizedBox(width: 20,),
                          Text('Date',
                            style:TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ) ,
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text(
                        _paload.toString().split('|')[2],
                        style: TextStyle(color: Colors.white ,fontSize: 20),

                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
          ],
        ) ,

      ),
    );
  }
}
