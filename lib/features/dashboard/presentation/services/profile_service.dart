import 'package:insurance_flutter/features/dashboard/presentation/models/profile_details.dart';

class ProfileService {
  Future<ProfileDetails> getProfileDetails() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1000));

    // Return mock data matching the design
    return ProfileDetails(
      name: 'Rahul Sharma',
      email: 'rahul.sharma@gmail.com',
      maritialStatus: 'Married',
      occupation: 'Software Engineer',
      age: '32 years',
      city: 'Mumbai',
      gender: 'Male',
      dependents: '2',
    );
  }
}
