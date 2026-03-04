import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/student_viewmodel.dart';

class StudentView extends StatelessWidget {
  const StudentView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StudentViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Student Card - MVVM"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildInfoCard(viewModel),
            const SizedBox(height: 30),
            _buildSubjectIndicator(),
            const SizedBox(height: 20),
            _buildChangeButton(context),
            const SizedBox(height: 20),
            _buildSubjectList(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(StudentViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Column(
        children: [
          Text(
            "Student Name: ${viewModel.studentName}",
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 10),
          Text(
            "Favorite Subject: ${viewModel.currentSubject}",
            style: const TextStyle(fontSize: 20, color: Colors.green),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectIndicator() {
    return Consumer<StudentViewModel>(
      builder: (context, viewModel, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "Subject ${viewModel.currentIndex + 1} of ${viewModel.subjects.length}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  Widget _buildChangeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.read<StudentViewModel>().changeSubject();
        },
        child: const Text("Change Subject"),
      ),
    );
  }

  Widget _buildSubjectList() {
    return Consumer<StudentViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          children: [
            const Text(
              "Available Subjects:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: viewModel.subjects.map((subject) {
                final isCurrent = subject == viewModel.currentSubject;
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isCurrent ? Colors.green : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    subject,
                    style: TextStyle(
                      color: isCurrent ? Colors.white : Colors.black,
                      fontWeight: isCurrent
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
