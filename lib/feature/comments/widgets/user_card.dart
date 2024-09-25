import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  final String name;
  final String email;
  final String description;
  final bool maskEmail;

  const UserCard(
      {super.key,
      required this.name,
      required this.email,
      required this.description,
      required this.maskEmail});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  void initState() {
    super.initState();
  }

  String _maskEmail(String email) {
    if (widget.maskEmail) {
      final parts = email.split('@');
      final localPart = parts[0];
      final domainPart = parts[1];

      if (localPart.length > 3) {
        return '${localPart.substring(0, 3)}****@$domainPart';
      }
      return email;
    }
    return email;
  }

  @override
  Widget build(BuildContext context) {
    final maskedEmail = _maskEmail(widget.email); 

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
                maskedEmail[0], 
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
                          widget.name,
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
                          maskedEmail, 
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
                    widget.description,
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
