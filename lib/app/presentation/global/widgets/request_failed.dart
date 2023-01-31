import 'package:flutter/material.dart';

import '../../../generated/assets.gen.dart';

class RequestFailed extends StatelessWidget {
  const RequestFailed({
    super.key,
    required this.onRetry,
    this.message,
  });
  final VoidCallback onRetry;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black26,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Expanded(child: Image.asset(Assets.images.error404.path)), for png/jpg
          Expanded(child: Assets.svg.error404.svg()),
          Text(message ?? 'Request failed'),
          MaterialButton(
            color: Colors.blue,
            onPressed: onRetry,
            child: const Text(
              'Retry',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
