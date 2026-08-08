import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final nameController = TextEditingController(text: 'Shlok Singh');
  final usernameController = TextEditingController(text: '@shlok_singh');
  final ageController = TextEditingController(text: '21');
  final bioController = TextEditingController(
    text: 'Traveller • Explorer • Dreamer\nCollecting footprints, not things.',
  );
  final emailController = TextEditingController(text: 'shloksingh25@gmail.com');
  final cityController = TextEditingController(text: 'Mumbai, India');

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    ageController.dispose();
    bioController.dispose();
    emailController.dispose();
    cityController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personal Information',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            // ---------------- PROFILE PHOTO ----------------
            const SizedBox(height: 10),

            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 70,
                  child: Icon(Icons.person, size: 75),
                ),

                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                  child: IconButton(
                    onPressed: () {
                      // Add image picker later
                    },
                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            TextButton(
              onPressed: () {
                // Add image picker later
              },
              child: const Text(
                'Change Photo',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ),

            const SizedBox(height: 15),

            // ---------------- PERSONAL INFORMATION ----------------
            _buildField(
              icon: Icons.person_outline,
              label: 'Name',
              controller: nameController,
            ),

            _buildField(
              icon: Icons.alternate_email,
              label: 'Username',
              controller: usernameController,
            ),

            _buildField(
              icon: Icons.calendar_month,
              label: 'Age',
              controller: ageController,
              keyboardType: TextInputType.number,
            ),

            _buildField(
              icon: Icons.description_outlined,
              label: 'Bio',
              controller: bioController,
              maxLines: 3,
            ),

            _buildField(
              icon: Icons.email_outlined,
              label: 'Email',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),

            _buildField(
              icon: Icons.location_on_outlined,
              label: 'City',
              controller: cityController,
            ),

            const SizedBox(height: 15),

            // ---------------- CHANGE PASSWORD ----------------
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade300),
              ),

              child: ListTile(
                contentPadding: EdgeInsets.zero,

                leading: Container(
                  padding: const EdgeInsets.all(12),

                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(14),
                  ),

                  child: const Icon(
                    Icons.lock_outline,
                    color: Colors.deepPurple,
                  ),
                ),

                title: const Text(
                  'Change Password',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),

                subtitle: const Text(
                  'Update your password to keep your account secure.',
                ),

                trailing: const Icon(Icons.chevron_right, size: 30),

                onTap: () {
                  // Password screen will be added later
                },
              ),
            ),

            const SizedBox(height: 20),

            // ---------------- SAVE BUTTON ----------------
            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: () {
                  // Save user information later
                },

                icon: const Icon(Icons.save_outlined, color: Colors.white),

                label: const Text(
                  'Save Changes',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ---------------- TEXT FIELD WIDGET ----------------

  Widget _buildField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            margin: const EdgeInsets.only(top: 25),

            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(icon, color: Colors.deepPurple),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              maxLines: maxLines,

              decoration: InputDecoration(
                labelText: label,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.deepPurple,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
