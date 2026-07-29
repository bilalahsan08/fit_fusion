import 'package:fit_fusion/core/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _controller = Get.put(ProfileController());

  late TextEditingController _nameController;
  late String _selectedGender;
  late double _height;
  late double _weight;
  late String _selectedGoal;
  late String _birthday;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _controller.name.value);
    _selectedGender = _controller.gender.value;
    _height = _controller.heightCm.value;
    _weight = _controller.weightKg.value;
    _selectedGoal = _controller.goal.value;
    _birthday = _controller.birthday.value;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    final success = await _controller.saveProfile(
      newName: _nameController.text.trim().isEmpty ? 'User' : _nameController.text.trim(),
      newGender: _selectedGender,
      newHeight: _height,
      newWeight: _weight,
      newGoal: _selectedGoal,
      newBirthday: _birthday,
    );

    if (success) {
      Get.back();
      Get.snackbar(
        'Profile Saved',
        'Your changes have been saved successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        'Could not save profile',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _saveChanges,
            child: const Text(
              'SAVE',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          // Profile Photo Header
          Center(
            child: Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.lightBlueAccent],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withValues(alpha: 0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Name Field
          _buildEditRow(
            icon: Icons.person_outline_rounded,
            title: 'Full Name',
            value: _nameController.text,
            onTap: () => _showNameDialog(),
          ),
          const SizedBox(height: 12),

          // Gender Field
          _buildEditRow(
            icon: Icons.wc_rounded,
            title: 'Gender',
            value: _selectedGender,
            onTap: () => _showGenderPicker(),
          ),
          const SizedBox(height: 12),

          // Birthday Field
          _buildEditRow(
            icon: Icons.cake_outlined,
            title: 'Birthday',
            value: _birthday,
            onTap: () => _selectBirthday(context),
          ),
          const SizedBox(height: 12),

          // Height Field
          _buildEditRow(
            icon: Icons.height_rounded,
            title: 'Height',
            value: '${_height.round()} cm',
            onTap: () => _showHeightSlider(),
          ),
          const SizedBox(height: 12),

          // Weight Field
          _buildEditRow(
            icon: Icons.monitor_weight_outlined,
            title: 'Weight',
            value: '${_weight.toStringAsFixed(1)} kg',
            onTap: () => _showWeightSlider(),
          ),
          const SizedBox(height: 12),

          // Goal Field
          _buildEditRow(
            icon: Icons.flag_outlined,
            title: 'Fitness Goal',
            value: _selectedGoal,
            onTap: () => _showGoalPicker(),
          ),
        ],
      ),
    );
  }

  Widget _buildEditRow({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blueAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.blueAccent, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
                fontSize: 15,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showNameDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Edit Full Name'),
        content: TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            hintText: 'Enter name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {});
              Navigator.pop(ctx);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showGenderPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Gender',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: ['Male', 'Female', 'Other'].map((g) {
                final isSelected = _selectedGender == g;
                return ChoiceChip(
                  label: Text(g),
                  selected: isSelected,
                  selectedColor: Colors.blueAccent,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _selectedGender = g);
                      Navigator.pop(ctx);
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _selectBirthday(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1995, 1, 1),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthday = '${picked.day.toString().padLeft(2, '0')} ${_monthName(picked.month)} ${picked.year}';
      });
    }
  }

  String _monthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  void _showHeightSlider() {
    double tempHeight = _height;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Height: ${tempHeight.round()} cm',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Slider(
                value: tempHeight,
                min: 120,
                max: 220,
                divisions: 100,
                label: '${tempHeight.round()} cm',
                onChanged: (val) => setModalState(() => tempHeight = val),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  setState(() => _height = tempHeight);
                  Navigator.pop(ctx);
                },
                child: const Text('Save Height'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showWeightSlider() {
    double tempWeight = _weight;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Weight: ${tempWeight.toStringAsFixed(1)} kg',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Slider(
                value: tempWeight,
                min: 30,
                max: 180,
                divisions: 300,
                label: '${tempWeight.toStringAsFixed(1)} kg',
                onChanged: (val) => setModalState(() => tempWeight = val),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  setState(() => _weight = tempWeight);
                  Navigator.pop(ctx);
                },
                child: const Text('Save Weight'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showGoalPicker() {
    final goals = ['Lose weight', 'Build muscle', 'Stay fit', 'Improve endurance'];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Primary Goal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Column(
              children: goals.map((g) {
                final isSelected = _selectedGoal == g;
                return RadioListTile<String>(
                  title: Text(g),
                  value: g,
                  groupValue: _selectedGoal,
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _selectedGoal = val);
                      Navigator.pop(ctx);
                    }
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
