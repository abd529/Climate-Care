import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    void nothing() {
      print('Does not do anything'); // Remove this useless
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      width: 200,
                      height: 80,
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('assets/cli-mate.png'),
                      ),
                    ),
                    const Text(
                      'Ali Raza',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ),
            ),
            const Text(
              'General',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 20),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.black),
                            onPressed: nothing,
                            child: const Text('Edit Profile'),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.black),
                            onPressed: nothing,
                            child: const Text('Change Location'),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.black),
                            onPressed: nothing,
                            child: const Text('Change Language'),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Text(
              'Privacy',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 20),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.black),
                            onPressed: nothing,
                            child: const Text('Change Password'),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.black),
                            onPressed: nothing,
                            child: const Text('Change Account'),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Text(
              'Terms And Support',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 10),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.black),
                            onPressed: nothing,
                            child: const Text('Terms and conditions'),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.black),
                            onPressed: nothing,
                            child: const Text('Privacy policy'),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.black),
                            onPressed: nothing,
                            child: const Text('Support'),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 35,
                width: 115,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: nothing,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.logout_rounded,
                          color: Colors.black,
                        ),
                        Text(
                          'Log out',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
