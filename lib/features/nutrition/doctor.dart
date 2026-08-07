
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fit_fusion/core/controllers/doctor_controller.dart';
import 'package:fit_fusion/features/chat/doctor_chat_screen.dart';

// --- Data Models ---
class Dietitian {
  final String id;
  final String name;
  final String specialty;
  final double rating;
  final int reviews;
  final int experience;
  final int fee;
  final String imagePath;

  Dietitian({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.experience,
    required this.fee,
    required this.imagePath,
  });
}

// --- Screen ---
class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  final DoctorController _doctorController = Get.put(DoctorController());
  final TextEditingController _symptomsController = TextEditingController();
  
  DateTime? _selectedDate;
  String? _selectedTimeSlot;
  Dietitian? _selectedDietitian;
  
  bool _isLoadingDietitians = true;
  List<Dietitian> _dietitians = [];

  final List<String> _morningSlots = ['09:00 AM', '10:30 AM', '11:45 AM'];
  final List<String> _afternoonSlots = ['02:00 PM', '03:30 PM', '05:00 PM'];
  final List<String> _eveningSlots = ['06:30 PM', '08:00 PM'];

  @override
  void initState() {
    super.initState();
    _fetchLiveDietitians();
  }

  @override
  void dispose() {
    _symptomsController.dispose();
    super.dispose();
  }

  Future<void> _fetchLiveDietitians() async {
    setState(() => _isLoadingDietitians = true);
    
    // Default fallback dietitians
    final List<Dietitian> fallbackDietitians = [
      Dietitian(
        id: 'd1', name: 'Dr. Sarah Johnson', specialty: 'Sports Nutrition',
        rating: 4.9, reviews: 124, experience: 8, fee: 50,
        imagePath: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=800&q=80',
      ),
      Dietitian(
        id: 'd2', name: 'Dr. Marcus Chen', specialty: 'Keto & Metabolic Reset',
        rating: 4.8, reviews: 89, experience: 6, fee: 45,
        imagePath: 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=800&q=80',
      ),
      Dietitian(
        id: 'd3', name: 'Dr. Emily Watson', specialty: 'Clinical Dietetics',
        rating: 5.0, reviews: 210, experience: 12, fee: 60,
        imagePath: 'https://images.unsplash.com/photo-1594824432258-f4633e21be14?w=800&q=80',
      ),
    ];

    try {
      final List<dynamic> dbDietitiansData = await _doctorController.fetchAllDoctors();
      
      if (dbDietitiansData.isNotEmpty) {
        _dietitians = dbDietitiansData.map((data) {
          return Dietitian(
            id: data['uid'] ?? '',
            name: '${data['firstName'] ?? 'Dr.'} ${data['lastName'] ?? ''}',
            specialty: data['category'] ?? data['qualification'] ?? 'Dietitian',
            rating: (data['averageRating'] ?? 5.0).toDouble(),
            reviews: data['numberOfReviews'] ?? 0,
            experience: int.tryParse(data['yearsOfExperience']?.toString() ?? '5') ?? 5,
            fee: 50, // Default fee if not in DB
            imagePath: (data['profileImageUrl'] != null && data['profileImageUrl'].toString().isNotEmpty) 
                ? data['profileImageUrl'] 
                : 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=800&q=80', // default avatar
          );
        }).toList();
      } else {
        _dietitians = fallbackDietitians;
      }
    } catch (e) {
      debugPrint("Error loading dietitians from DB: $e");
      _dietitians = fallbackDietitians;
    }

    if (mounted) {
      setState(() {
        _isLoadingDietitians = false;
        if (_dietitians.isNotEmpty) {
          _selectedDietitian = _dietitians.first;
        }
      });
    }
  }

  void _pickReportImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Report attached: ${image.name}'),
            backgroundColor: Colors.teal.shade600,
          ),
        );
      }
    }
  }

  void _openChat() {
    if (_selectedDietitian == null) return;
    
    Get.to(() => ChatScreen(
      doctorId: _selectedDietitian!.id,
      doctorName: _selectedDietitian!.name,
      // patientId and patientName will be resolved by the chat logic/controller using current user.
    ));
  }

  void _showBookingConfirmation() async {
    if (_selectedDate == null || _selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a Date and Time Slot')),
      );
      return;
    }
    if (_selectedDietitian == null) return;

    // Save to Firebase via Controller
    await _doctorController.bookAppointment(
      date: _selectedDate!.toLocal().toString().split(' ')[0],
      time: _selectedTimeSlot!,
      description: _symptomsController.text.trim().isEmpty ? "Routine consultation" : _symptomsController.text.trim(),
      receiverId: _selectedDietitian!.id,
    );

    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                child: Icon(Icons.check_circle_rounded, color: Colors.green.shade600, size: 48),
              ),
              const SizedBox(height: 16),
              Text(
                "Booking Confirmed!",
                style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Text(
                "Your consultation with ${_selectedDietitian!.name} is saved to Firebase.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
                child: Column(
                  children: [
                    _buildSummaryRow(Icons.calendar_today_rounded, "Date", _selectedDate!.toLocal().toString().split(' ')[0]),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8.0), child: Divider()),
                    _buildSummaryRow(Icons.access_time_rounded, "Time", _selectedTimeSlot!),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8.0), child: Divider()),
                    _buildSummaryRow(Icons.receipt_long_rounded, "Total Fee", "\$${_selectedDietitian!.fee}.00"),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context); // Go back to nutrition hub
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade600,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text("Done", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.teal.shade600),
        const SizedBox(width: 12),
        Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
        const Spacer(),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Dietitian Consultation',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black87),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SafeArea(
        child: _isLoadingDietitians 
          ? const Center(child: CircularProgressIndicator(color: Colors.teal))
          : SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Dietitian Carousel ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text("Select Specialist", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 160,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _dietitians.length,
                  itemBuilder: (context, index) {
                    final dietitian = _dietitians[index];
                    final isSelected = _selectedDietitian?.id == dietitian.id;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedDietitian = dietitian),
                      child: Container(
                        width: 280,
                        margin: const EdgeInsets.only(right: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.teal.shade600 : Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: isSelected ? Colors.teal.shade600 : Colors.grey.shade200),
                          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(dietitian.imagePath, width: 70, height: 70, fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => Container(width: 70, height: 70, color: Colors.grey.shade300, child: const Icon(Icons.person, color: Colors.white)),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(dietitian.name, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.black87)),
                                  const SizedBox(height: 4),
                                  Text(dietitian.specialty, style: TextStyle(fontSize: 12, color: isSelected ? Colors.teal.shade100 : Colors.grey.shade600), maxLines: 1, overflow: TextOverflow.ellipsis),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.star_rounded, size: 14, color: Colors.amber),
                                      const SizedBox(width: 4),
                                      Text('${dietitian.rating}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.black87)),
                                      const Spacer(),
                                      Text('\$${dietitian.fee}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.teal.shade600)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 32),

              // --- Booking Details ---
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Schedule", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: 16),
                    
                    // Date Picker Button
                    InkWell(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now().add(const Duration(days: 1)),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 90)),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(primary: Colors.teal.shade600),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) setState(() => _selectedDate = picked);
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          children: [
                            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)), child: Icon(Icons.calendar_month_rounded, color: Colors.teal.shade600)),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Select Date", style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 4),
                                  Text(_selectedDate == null ? "Choose a day" : _selectedDate!.toLocal().toString().split(' ')[0], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right_rounded, color: Colors.black26),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Time Slots
                    Text("Morning Slots", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                    const SizedBox(height: 12),
                    Wrap(spacing: 12, runSpacing: 12, children: _morningSlots.map((slot) => _buildTimeChip(slot)).toList()),
                    
                    const SizedBox(height: 16),
                    Text("Afternoon Slots", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                    const SizedBox(height: 12),
                    Wrap(spacing: 12, runSpacing: 12, children: _afternoonSlots.map((slot) => _buildTimeChip(slot)).toList()),

                    const SizedBox(height: 16),
                    Text("Evening Slots", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                    const SizedBox(height: 12),
                    Wrap(spacing: 12, runSpacing: 12, children: _eveningSlots.map((slot) => _buildTimeChip(slot)).toList()),

                    const SizedBox(height: 32),

                    // Goals / Symptoms
                    Text("Health Notes (Optional)", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _symptomsController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Describe your goals, conditions, or allergies...',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.teal.shade400, width: 2)),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Actions
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _openChat,
                            icon: Icon(Icons.chat_bubble_outline_rounded, color: Colors.teal.shade600, size: 20),
                            label: Text('Chat', style: TextStyle(color: Colors.teal.shade600, fontSize: 13)),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(color: Colors.teal.shade200),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _pickReportImage,
                            icon: Icon(Icons.upload_file_rounded, color: Colors.teal.shade600, size: 20),
                            label: Text('Reports', style: TextStyle(color: Colors.teal.shade600, fontSize: 13)),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(color: Colors.teal.shade200),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _showBookingConfirmation,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.teal.shade600,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: const Size.fromHeight(56),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text('Confirm Booking', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16)),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeChip(String time) {
    final bool isSelected = _selectedTimeSlot == time;
    return GestureDetector(
      onTap: () => setState(() => _selectedTimeSlot = time),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal.shade600 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? Colors.teal.shade600 : Colors.grey.shade300),
          boxShadow: isSelected ? [BoxShadow(color: Colors.teal.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4))] : [],
        ),
        child: Text(
          time,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
