import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: () {},
          child: Text(
            'Dùng số điện thoại khác',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
        ),
      ),
    );
  }
}
