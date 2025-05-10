import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../../home/data/models/home_model/job_model.dart';
import '../../../../home/presentation/view/job_description_view.dart';


class SearchHistoryList extends StatelessWidget {
  final List<JobModel> searchHistory;
  final Function(int) onRemoveItem;

  const SearchHistoryList({
    super.key,
    required this.searchHistory,
    required this.onRemoveItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: searchHistory.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return JobDescriptionView(
                    job: searchHistory[index].jobDataModel,
                    rating: searchHistory[index].ratingModel,
                  );
                },
              ),
            );
          },
          leading: Icon(Icons.history_rounded, color: AppColors.borderColor),
          title: Text(
            searchHistory[index].jobDataModel.title,
            style: TextStyle(color: AppColors.borderColor),
          ),
          trailing: IconButton(
            icon: Icon(Icons.close, color: AppColors.borderColor),
            onPressed: () => onRemoveItem(index),
          ),
        );
      },
    );
  }
}
