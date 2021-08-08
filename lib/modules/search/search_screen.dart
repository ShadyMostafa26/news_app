import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/components/components.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/layout/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) return 'search must not be empty';
                      return null;
                    },
                    onChanged: (value) {
                      NewsCubit.get(context).getSearch(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: state is! NewsGetSearchLoadingState,
                    builder: (context) => ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildArticleItem(list[index],context),
                      separatorBuilder: (context, index) => Divider(
                        height: 10,
                        thickness: 2,
                        color: Colors.grey,
                      ),
                      itemCount: list.length,
                    ),
                    fallback: (context) => Center(child: LinearProgressIndicator()),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
