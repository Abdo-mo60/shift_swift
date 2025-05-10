import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../core/app_colors.dart';
import '../../../home/data/models/home_model/job_model.dart';
import '../../../home/presentation/manager/home_view_cubit.dart';
import '../../../home/presentation/view/job_description_view.dart';
import 'filter_view.dart';
import 'widgets/search_app_bar.dart';
import 'widgets/search_history_list.dart';
import 'widgets/search_text_field.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchView> {
  List<JobModel> searchHistory = [];
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.main,
      appBar: SearchAppBar(onBackButtonPressed: () => Navigator.pop(context)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchTextField(
              controller: searchController,
              onFilterPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FilterView()),
                );
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<HomeViewCubit, HomeViewState>(
                builder: (context, state) {
                  if (state is HomeViewSuccess) {
                    final jobs = state.jobs;
                  
                    if (jobs.isEmpty) {
                      return const Center(child: Text('No Job Found'));
                    }
                    return searchController.text.isEmpty
                        ? SearchHistoryList(
                          searchHistory: searchHistory,
                          onRemoveItem: (index) {
                            setState(() {
                              searchHistory.removeAt(index);
                            });
                          },
                        )
                        : ListView.separated(
                          itemCount: jobs.length,
                          itemBuilder:
                              (context, index) => Card(
                                child: ListTile(
                                  title: Text(jobs[index].jobDataModel.title),
                                  subtitle: Text(
                                    jobs[index].jobDataModel.companyName!,
                                  ),
                                  onTap: () {
                                    searchHistory.add(jobs[index]);
                                    
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return JobDescriptionView(
                                            job: jobs[index].jobDataModel,
                                            rating: jobs[index].ratingModel,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                          separatorBuilder: (context, index) => const Divider(),
                        );
                  } else if (state is HomeViewFailure) {
                    return Center(child: Text(state.errorMessage));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
