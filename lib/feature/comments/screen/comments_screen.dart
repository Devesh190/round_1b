import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:round_1b/feature/comments/model/comment.dart';
import 'package:round_1b/feature/comments/provider/comments_provider.dart';
import 'package:round_1b/feature/comments/widgets/user_card.dart';
import 'package:round_1b/widget/common_appbar.dart';
import 'package:shimmer/shimmer.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  bool maskEmail = false;
  @override
  void initState() {
    super.initState();
    setupRemoteConfig();
  }

  Future<void> setupRemoteConfig() async {
    final provider = Provider.of<CommentsProvider>(context, listen: false);
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(seconds: 10),
    ));
    await remoteConfig.fetchAndActivate();
    remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.activate();
      maskEmail = remoteConfig.getBool("mask_email");
      provider.setMaskEmail(maskEmail);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: CommonAppBar(
        title: 'Comments',
        titleStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
        showIcon: true,
        color: Colors.blue.shade800,
      ),
      body: Consumer<CommentsProvider>(
        builder: (context, commentsProvider, child) {
          return Center(
            child: FutureBuilder<List<Comment>>(
              future: commentsProvider.fetchComments(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return buildShimmerLoading();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.hasData) {
                  final commentsData = snapshot.data!;
                  return ListView.builder(
                    itemCount: commentsData.length,
                    itemBuilder: (context, item) {
                      return UserCard(
                        name: commentsData[item].name,
                        email: commentsData[item].email,
                        description: commentsData[item].body,
                        maskEmail: commentsProvider.maskEmail,
                      );
                    },
                  );
                }
                return const Text('No data available');
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildShimmerLoading() {
    return ListView.builder(
      itemCount: 10, // Number of shimmer cards
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: const UserCard(
            name: 'Loading..',
            email: 'Loading...',
            description: 'loading..',
            maskEmail: false,
          ),
        );
      },
    );
  }
}
