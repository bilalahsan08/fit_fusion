import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Doctor extends StatefulWidget {
  const Doctor({super.key});

  @override
  State<Doctor> createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  final TextEditingController _symptomsController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedSpecialty;

  final List<String> _specialties = [
    'Cardiologist',
    'Dermatologist',
    'Neurologist',
    'Pediatrician',
    'Orthopedic',
    'Gynecologist',
    'Psychiatrist',
    'Oncologist',
    'ENT Specialist',
    'General Physician'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Dietition Appointment',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(  // Ensures content is visible within screen limits
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Info
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage('assets/images/doctor.png'),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Dr. Sarah Johnson",
                            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
                        Text("Cardiologist", style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700])),
                        const SizedBox(height: 4),
                        Row(
                          children: List.generate(5, (index) => const Icon(Icons.star, size: 16, color: Colors.amber)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Specialty Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedSpecialty,
                  items: _specialties.map((specialty) {
                    return DropdownMenuItem(value: specialty, child: Text(specialty));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedSpecialty = value),
                  decoration: InputDecoration(
                    labelText: 'Choose Specialty',
                    labelStyle: GoogleFonts.poppins(fontSize: 16, color: Colors.teal),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal.withOpacity(0.5), width: 1.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Date Picker
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) {
                      setState(() {
                        _selectedDate = picked;
                      });
                    }
                  },
                  child: Text(
                    _selectedDate == null
                        ? 'Select Appointment Date'
                        : 'Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.teal),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.teal, backgroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: Colors.teal.withOpacity(0.5), width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(height: 16),

                // Time Picker (with restricted time range)
                ElevatedButton(
                  onPressed: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      builder: (BuildContext context, Widget? child) {
                        return MediaQuery(
                          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null) {
                      // Limit the selected time to between 9 AM and 9 PM
                      if (picked.hour >= 9 && picked.hour <= 21) {
                        setState(() {
                          _selectedTime = picked;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please select a time between 9 AM and 9 PM')),
                        );
                      }
                    }
                  },
                  child: Text(
                    _selectedTime == null
                        ? 'Select Time Slot'
                        : 'Time: ${_selectedTime!.format(context)}',
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.teal),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.teal, backgroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: Colors.teal.withOpacity(0.5), width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(height: 16),

                // Symptoms TextField
                TextField(
                  controller: _symptomsController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Describe your condition',
                    hintText: 'e.g. Headache, chest pain...',
                    labelStyle: GoogleFonts.poppins(fontSize: 16, color: Colors.teal),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal.withOpacity(0.5), width: 1.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Book Button
                ElevatedButton.icon(
                  onPressed: () {
                    // Logic to book appointment
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Appointment Booked')),
                    );
                  },
                  icon: const Icon(Icons.calendar_today, color: Colors.white),
                  label: const Text('Book Appointment', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16), backgroundColor: Colors.teal,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(height: 10),

                // Chat & Upload buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.chat, color: Colors.teal),
                        label: const Text('Chat with Dietition', style: TextStyle(color: Colors.teal)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.teal),
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.upload_file, color: Colors.teal),
                        label: const Text('Upload Reports', style: TextStyle(color: Colors.teal)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.teal),
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[100], // Gray background color
    );
  }
}
