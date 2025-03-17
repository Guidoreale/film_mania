import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
      bottom: false,
      child: Container(
        decoration: BoxDecoration(
            color: colors.primaryContainer,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            )),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Icon(Icons.movie_outlined, color: colors.primary),
                  SizedBox(width: 10),
                  Text('Film Mania', style: titleStyle),
                  const Spacer(),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.search_outlined))
                ],
              )),
        ),
      ),
    );
  }
}
