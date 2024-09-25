import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:round_1b/feature/comments/model/comment.dart';
import 'package:round_1b/feature/comments/provider/comments_provider.dart';
import 'package:round_1b/widget/common_appbar.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade50,
        appBar: CommonAppBar(
          title: 'Comments',
          titleStyle: TextStyle(
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
                  return const CircularProgressIndicator();
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
                        );
                      });
                }

                return const Text('No data available');
              },
            ),
          );
        }));
  }
}

class UserCard extends StatelessWidget {
  final String name;
  final String email;
  final String description;

  const UserCard({
    super.key,
    required this.name,
    required this.email,
    required this.description,
  });
  @override
  Widget build(BuildContext context) {
    return Card.filled(
      margin: const EdgeInsets.all(10),
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              radius: 25.0,
              child: Text(
                email[0],
                style: const TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name : ',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email : ',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          email,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    description,
                    style: const TextStyle(
                        fontSize: 14.0, overflow: TextOverflow.ellipsis),
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
