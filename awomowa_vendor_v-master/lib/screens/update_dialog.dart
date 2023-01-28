import 'package:awomowa_vendor/reponse_models/update_list_response.dart';
import 'package:flutter/material.dart';

class UpdateDialog extends StatelessWidget {
  final Histories update;

  const UpdateDialog({this.update});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Material(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.close))),
                    Text(
                      'Update',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Image.network(
                      update.imageUrl,
                      width: 200.0,
                      height: 200.0,
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Published On',
                        style: TextStyle(color: Colors.grey, fontSize: 14.0),
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${update.createdAt}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    Divider(
                      height: 36.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Description',
                        style: TextStyle(color: Colors.grey, fontSize: 14.0),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${update.comments}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
