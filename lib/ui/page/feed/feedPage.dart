import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_twitter_clone/helper/enum.dart';
import 'package:flutter_twitter_clone/model/feedModel.dart';
import 'package:flutter_twitter_clone/state/authState.dart';
import 'package:flutter_twitter_clone/state/feedState.dart';
import 'package:flutter_twitter_clone/ui/theme/theme.dart';
import 'package:flutter_twitter_clone/widgets/customWidgets.dart';
import 'package:flutter_twitter_clone/widgets/newWidget/customLoader.dart';
import 'package:flutter_twitter_clone/widgets/newWidget/emptyList.dart';
import 'package:flutter_twitter_clone/widgets/tweet/tweet.dart';
import 'package:flutter_twitter_clone/widgets/tweet/widgets/tweetBottomSheet.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatelessWidget {
  const FeedPage(
      {Key? key, required this.scaffoldKey, this.refreshIndicatorKey})
      : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  final GlobalKey<RefreshIndicatorState>? refreshIndicatorKey;

  Widget _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/CreateFeedPage/tweet');
      },
      child: customIcon(
        context,
        icon: AppIcon.fabTweet,
        isTwitterIcon: true,
        iconColor: Theme.of(context).colorScheme.onPrimary,
        size: 25,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Set the gradient for the status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:  Colors.transparent,// Make the status bar transparent
      statusBarIconBrightness: Brightness.dark, // Use light icons for the gradient
    ));

    return Scaffold(
      floatingActionButton: _floatingActionButton(context),
      body: Container(
        color: Color(0xff0898af).withOpacity(0.4),
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [Color(0xff0898af), Color(0xff7bd859)],
        //     begin: Alignment.centerLeft,
        //     end: Alignment.centerRight,
        //   ),
        // ),
        height: context.height,
        width: context.width,
        child: RefreshIndicator(
          key: refreshIndicatorKey,
          onRefresh: () async {
            var feedState = Provider.of<FeedState>(context, listen: false);
            feedState.getDataFromDatabase();
            return Future.value(true);
          },
          child: _FeedPageBody(
            refreshIndicatorKey: refreshIndicatorKey,
            scaffoldKey: scaffoldKey,
          ),
        ),
      ),
    );
  }

}

class _FeedPageBody extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  final GlobalKey<RefreshIndicatorState>? refreshIndicatorKey;

  const _FeedPageBody(
      {Key? key, required this.scaffoldKey, this.refreshIndicatorKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authState = Provider.of<AuthState>(context, listen: false);
    return Consumer<FeedState>(
      builder: (context, state, child) {
        final List<FeedModel>? list = state.getTweetList(authState.userModel);
        state.handleLocationPermission(authState.userModel.userId.toString());
        return CustomScrollView(
          slivers: <Widget>[
            child!,
            state.isBusy && list == null
                ? SliverToBoxAdapter(
                    child: Container(
                      color:  Color(0xff0898af).withOpacity(0.4),
                      // decoration: BoxDecoration(
                      //   gradient: LinearGradient(
                      //     colors: [Color(0xff0898af), Color(0xff7bd859)],
                      //     begin: Alignment.centerLeft,
                      //     end: Alignment.centerRight,
                      //   ),
                      // ),
                      height: context.height - 135,
                      child: CustomScreenLoader(
                        height: double.infinity,
                        width: double.infinity,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  )
                : !state.isBusy && list == null
                    ?  SliverToBoxAdapter(
                        child: Container(
                          color:  Color(0xff0898af).withOpacity(0.4),
                          // decoration: BoxDecoration(
                          //   gradient: LinearGradient(
                          //     colors: [Color(0xff0898af), Color(0xff7bd859)],
                          //     begin: Alignment.centerLeft,
                          //     end: Alignment.centerRight,
                          //   ),
                          // ),
                          child: EmptyList(
                            'No Tweet added yet',
                            subTitle:
                                'When new Tweet added, they\'ll show up here \n Tap tweet button to add new',
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildListDelegate(
                          list!.map(
                            (model) {
                              return Container(

                                color: Color(0xff0898af).withOpacity(0.4),
                                  // decoration: BoxDecoration(
                                  //   gradient: LinearGradient(
                                  //     colors: [Color(0xff0898af), Color(0xff7bd859)],
                                  //     begin: Alignment.centerLeft,
                                  //     end: Alignment.centerRight,
                                  //   ),
                                  // ),

                                child: Tweet(
                                  model: model,
                                  trailing: TweetBottomSheet().tweetOptionIcon(
                                      context,
                                      model: model,
                                      type: TweetType.Tweet,
                                      scaffoldKey: scaffoldKey),
                                  scaffoldKey: scaffoldKey,
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      )
          ],
        );
      },
      child: SliverAppBar(
        floating: true,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
              },
            );
          },
        ),
        title: Image.asset('assets/images/icon-480.png', height: 85),
        centerTitle: true,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.transparent, // Transparent AppBar
        flexibleSpace: Container(
          color:  Color(0xff0898af).withOpacity(0.4),
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: [Color(0xff0898af), Color(0xff7bd859)],
          //     begin: Alignment.centerLeft,
          //     end: Alignment.centerRight,
          //   ),
          // ),
        ),
        bottom: PreferredSize(
          child: Container(
            color: Colors.grey.shade200,
            height: 0.0,
          ),
          preferredSize: const Size.fromHeight(0.0),
        ),
      ),

    );
  }
}
