import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shiftswift/constant.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/styles.dart';
import '../../../../home/presentation/view/widgets/home_view_item_top.dart';
import '../../../model/last_work_model.dart';
import '../../manager/lastwork_cubit.dart';
import 'custom_my_job_button.dart';
import 'custom_text_field_last_work_view.dart';

class LastWorkViewItem extends StatefulWidget {
  const LastWorkViewItem({super.key, required this.lastWorkModel});
  final LastWorkModel lastWorkModel;

  @override
  State<LastWorkViewItem> createState() => _LastWorkViewItemState();
}

class _LastWorkViewItemState extends State<LastWorkViewItem> {
  int _rating = 0;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 0.5, color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          HomeViewItemTop(
            imageUrl: widget.lastWorkModel.companyPictureUrl??'',
            title: widget.lastWorkModel.title!,
            companyName:
                '${widget.lastWorkModel.firstName} ${widget.lastWorkModel.lastName}',
          ),
          const Divider(
            color: Color(0xff95948F),
            indent: 10,
            endIndent: 10,
            height: 20,
          ),
          Text(
            'Rate your Last experience with us!',
            style: GoogleFonts.lato(textStyle: AppStyles.medium18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  Icons.star,
                  color: index < _rating ? Colors.amber : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _rating = index + 1;
                  });
                },
              );
            }),
          ),
          const SizedBox(height: 20),
          CustomTextFieldLastWorkView(controller: _commentController),
          const SizedBox(height: 20),
          BlocConsumer<LastworkCubit, LastworkState>(
            listener: (context, state) {
              if (state is AddRatingSuccessful) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.check, size: 30, color: Colors.white),
                      ),
                      content: Text(
                        state.message,
                        style: GoogleFonts.lato(textStyle: AppStyles.bold14),
                        textAlign: TextAlign.center,
                      ),
                      actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF2D5C88),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Done",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else if (state is AddRatingFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
            },
            builder: (context, state) {
              return CustomMyJobButton(
                text: state is AddRatingLoading ? 'Submitting...' : 'Submit',
                onTap:
                    state is AddRatingLoading
                        ? null // Disable button while loading
                        : () {
                          final comment = _commentController.text.trim();

                          if (_rating == 0 || comment.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please provide both a rating and a comment",
                                ),
                              ),
                            );
                            return;
                          }

                          context.read<LastworkCubit>().addRating(
                            body: {'score': _rating, 'comment': comment},
                            memberId: currentId!,
                            companyId: widget.lastWorkModel.companyId!,
                          );
                        },
              );
            },
          ),
        ],
      ),
    );
  }
}
