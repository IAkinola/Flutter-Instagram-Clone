import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/models/post.dart';
import 'package:flutter_instagram_clone/models/user.dart';
import 'package:flutter_instagram_clone/models/comment.dart';
import 'package:flutter_instagram_clone/models/global.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Column(children: <Widget>[
            Container(
              height: 85,
              child: getStories(),
            ),
            Column(
              children: getPosts(),
            ),
          ])
        ],
      ),
    );
  }

  Widget getStories() {
    return ListView(
        scrollDirection: Axis.horizontal, children: getUserStories());
  }

  List<Widget> getUserStories() {
    List<Widget> stories = [];
    for (User follower in user.following) {
      stories.add(getStory(follower));
    }
    return stories;
  }

  Widget getStory(User follower) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(children: <Widget>[
        Container(
          height: 50,
          width: 50,
          child: Stack(alignment: Alignment(0, 0), children: <Widget>[
            Container(
              height: 50,
              width: 50,
              child: CircleAvatar(
                backgroundColor: follower.hasStory ? Colors.red : Colors.grey,
              ),
            ),
            Container(
              height: 47,
              width: 47,
              child: CircleAvatar(
                backgroundColor: Colors.white,
              ),
            ),
            Container(
              height: 45,
              width: 45,
              child: CircleAvatar(
                backgroundImage: follower.profilePicture,
              ),
            ),
            FloatingActionButton(
              onPressed: () {},
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
          ]),
        ),
      ]),
    );
  }

  List<Widget> getPosts() {
    List<Widget> posts = [];
    for (Post post in userPosts) {
      posts.add(getPost(post));
    }
    return posts;
  }

  Widget getPost(Post post) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                        backgroundImage: post.user.profilePicture,
                      ),
                    ),
                    Text(
                      post.user.username,
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints(maxHeight: 285),
            decoration: BoxDecoration(
              image: DecorationImage(image: post.image),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Stack(
                    alignment: Alignment(0, 0),
                    children: <Widget>[
                      Icon(
                        Icons.favorite,
                        size: 30,
                        color: post.isLiked ? Colors.red : Colors.black,
                      ),
                      IconButton(
                        icon: Icon(Icons.favorite),
                        color: post.isLiked ? Colors.red : Colors.white,
                        onPressed: () {
                          setState(() {
                            userPosts[0].isLiked = post.isLiked ? false : true;
                            if (!post.isLiked) {
                              post.likes.remove(user);
                            } else {
                              post.likes.add(user);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment(0, 0),
                    children: <Widget>[
                      Icon(
                        Icons.mode_comment,
                        size: 30,
                        color: Colors.black,
                      ),
                      IconButton(
                        icon: Icon(Icons.mode_comment),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment(0, 0),
                    children: <Widget>[
                      Icon(
                        Icons.send,
                        size: 30,
                        color: Colors.black,
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              Stack(
                alignment: Alignment(0, 0),
                children: <Widget>[
                  Icon(
                    Icons.bookmark,
                    size: 30,
                    color: Colors.black,
                  ),
                  IconButton(
                    icon: Icon(Icons.bookmark),
                    color: post.isSaved ? Colors.black : Colors.white,
                    onPressed: () {
                      setState(() {
                        userPosts[0].isSaved = post.isSaved ? false : true;
                        if (!post.isSaved) {
                          user.savedPosts.remove(post);
                        } else {
                          user.savedPosts.add(post);
                        }
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          FlatButton(
            onPressed: () {},
            child: Text(
              post.likes.length.toString() + " likes",
              style: textStyleBold,
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 15, right: 10),
                child: Text(
                  post.user.username,
                  style: textStyleBold,
                ),
              ),
              Text(post.description)
            ],
          ),
          FlatButton(
            onPressed: () {},
            child: Text(
                "View all " + post.comments.length.toString() + " comments"),
          ),
        ],
      ),
    );
  }
}
