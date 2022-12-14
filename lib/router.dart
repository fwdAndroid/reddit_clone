// loggedOut
// loggedIn

import 'package:flutter/material.dart';
import 'package:reddit_clone/screen/screen/add_moddarator_screen.dart';
import 'package:reddit_clone/screen/screen/bottombarpages/add_post_screen.dart';
import 'package:reddit_clone/screen/screen/bottombarpages/add_post_type_screen.dart';
import 'package:reddit_clone/screen/screen/comment_screen.dart';
import 'package:reddit_clone/screen/screen/community_profile_screen.dart';
import 'package:reddit_clone/screen/screen/create_community_screen.dart';
import 'package:reddit_clone/screen/screen/edit_community_screen.dart';
import 'package:reddit_clone/screen/screen/edit_profile_screen.dart';
import 'package:reddit_clone/screen/screen/home_screen.dart';
import 'package:reddit_clone/screen/screen/login_screen.dart';
import 'package:reddit_clone/screen/screen/mod_tools_screen.dart';
import 'package:reddit_clone/screen/screen/user_profile_screen.dart';

import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/create-community': (_) =>
      const MaterialPage(child: CreateCommunityScreen()),
  '/r/:name': (route) => MaterialPage(
        child: CommunityScreen(
          name: route.pathParameters['name']!,
        ),
      ),
  '/mod-tools/:name': (routeData) => MaterialPage(
        child: ModToolsScreen(
          name: routeData.pathParameters['name']!,
        ),
      ),
  '/edit-community/:name': (routeData) => MaterialPage(
        child: EditCommunityScreen(
          name: routeData.pathParameters['name']!,
        ),
      ),
  '/add-mods/:name': (routeData) => MaterialPage(
        child: AddModsScreen(
          name: routeData.pathParameters['name']!,
        ),
      ),
  '/u/:uid': (routeData) => MaterialPage(
        child: UserProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
  '/edit-profile/:uid': (routeData) => MaterialPage(
        child: EditProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
  '/add-post/:type': (routeData) => MaterialPage(
        child: AddPostTypeScreen(
          type: routeData.pathParameters['type']!,
        ),
      ),
  '/post/:postId/comments': (route) => MaterialPage(
        child: CommentsScreen(
          postId: route.pathParameters['postId']!,
        ),
      ),
  '/add-post': (routeData) => const MaterialPage(
        child: AddPostScreen(),
      ),
});
