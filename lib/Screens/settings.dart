import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('General'),
        Container(
          child: Card(
            child: Column(
              children: [
                TextButton(
                  onPressed: null,
                  child: Text('Edit Profile'),
                ),
                TextButton(
                  onPressed: null,
                  child: Text('Change Location'),
                ),
                TextButton(
                  onPressed: null,
                  child: Text('Change Language'),
                ),
              ],
            ),
          ),
        ),
        Text('Privacy'),
        Container(
          child: Card(
            child: Column(
              children: [
                TextButton(
                  onPressed: null,
                  child: Text('Change Password'),
                ),
                TextButton(
                  onPressed: null,
                  child: Text('Change Account'),
                ),
              ],
            ),
          ),
        ),
        Text('Terms And Support'),
        Container(
          child: Card(
            child: Column(
              children: [
                TextButton(
                  onPressed: null,
                  child: Text('Terms and condition'),
                ),
                TextButton(
                  onPressed: null,
                  child: Text('Privacy policy'),
                ),
                TextButton(
                  onPressed: null,
                  child: Text('Support'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
