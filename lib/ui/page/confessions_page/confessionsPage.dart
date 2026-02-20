import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/helper/utility.dart';
import 'package:flutter_twitter_clone/model/confession_model.dart';
import 'package:flutter_twitter_clone/model/user.dart';
import 'package:flutter_twitter_clone/state/searchState.dart';
import 'package:flutter_twitter_clone/ui/page/profile/profilePage.dart';
import 'package:flutter_twitter_clone/ui/page/profile/widgets/circular_image.dart';
import 'package:flutter_twitter_clone/ui/theme/theme.dart';
import 'package:flutter_twitter_clone/widgets/customAppBar.dart';
import 'package:flutter_twitter_clone/widgets/customWidgets.dart';
import 'package:flutter_twitter_clone/widgets/newWidget/title_text.dart';
import 'package:provider/provider.dart';


class ConfessionsPage extends StatefulWidget {
  const ConfessionsPage({Key? key, this.scaffoldKey}) : super(key: key);

  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  State<StatefulWidget> createState() => _ConfessionsPage();
}

class _ConfessionsPage extends State<ConfessionsPage> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('UOL Confessions.', style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black, // Text color
        ),),
      ),
      body: RefreshIndicator(
        onRefresh: () async {

        },
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FirestoreListView<ConfessionModel>(
                    query: FirebaseFirestore.instance.collection('confessions')
                        .withConverter<ConfessionModel>(
                        fromFirestore: (snapshot, _) => ConfessionModel.fromDocumentSnapshot(snapshot),
                        toFirestore: (data, _) => data.toJson()
                    ),
                    pageSize: 10,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, snapshot) {
                      final post = snapshot.data();
                      return  confWidget(context,
                          title: post.title,
                          des: post.description,
                          date: post.date
                      );
                    }),
              ),




            ],
          ),
        )
      ),
    );
  }

  Padding confWidget(BuildContext context,{String? title, String? des, String? date}) {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff0898af), Color(0xff7bd859)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(5), // Rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0), // Adjust the border thickness
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white, // Background color inside the border
                      // alignment: Alignment.,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Text color
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            des.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black, // Text color
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                date.toString(),
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green, // Text color
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
  }
}

