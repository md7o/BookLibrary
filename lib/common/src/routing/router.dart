import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/features/book_content/book_details.dart';
import 'package:book_library/splash.dart';
import 'package:book_library/wrapper/bnb.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final goRouterProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                }

                if (snapshot.hasError) {
                  return const BNB();
                }
                return const BNB();
              },
            );
          },
        ),
        GoRoute(
          path: '/ss',
          builder: (context, state) {
            Object? cnt = state.extra;
            Object? index = state.extra;
            return BookDetails(
              index: index as int,
              cnt: cnt as BooksModel,
            );
          },
        ),
      ],
    );
  },
);
