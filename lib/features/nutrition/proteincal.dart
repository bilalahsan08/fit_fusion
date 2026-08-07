import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProteinCalScreen extends StatefulWidget {
  const ProteinCalScreen({super.key});

  @override
  State<ProteinCalScreen> createState() => _ProteinCalScreenState();
}

class _ProteinCalScreenState extends State<ProteinCalScreen> {
  final TextEditingController _weightController = TextEditingController();
  
  bool _isKg = true;
  String _selectedGoal = 'Fat Loss';
  String _selectedActivity = 'Moderate';
  
  double _minProtein = 0;
  double _maxProtein = 0;
  
  // Daily Meal Tracker State
  double _loggedProtein = 0;
  final List<Map<String, dynamic>> _loggedFoods = [];

  final List<Map<String, dynamic>> _goals = [
    {'name': 'Fat Loss', 'icon': '🏃', 'baseMin': 1.8, 'baseMax': 2.2},
    {'name': 'Muscle Gain', 'icon': '💪', 'baseMin': 1.6, 'baseMax': 2.4},
    {'name': 'Maintenance', 'icon': '⚖️', 'baseMin': 1.2, 'baseMax': 1.6},
    {'name': 'Strength', 'icon': '🏋️', 'baseMin': 1.6, 'baseMax': 2.2},
    {'name': 'Endurance', 'icon': '🚴', 'baseMin': 1.4, 'baseMax': 1.8},
  ];

  final List<Map<String, dynamic>> _activityLevels = [
    {'name': 'Sedentary', 'icon': '🛋️', 'multiplier': 1.0},
    {'name': 'Light', 'icon': '🚶', 'multiplier': 1.1},
    {'name': 'Moderate', 'icon': '🏃', 'multiplier': 1.2},
    {'name': 'Athlete', 'icon': '⚡', 'multiplier': 1.3},
  ];

  final List<Map<String, dynamic>> _foodDatabase = [
    {'name': 'Chicken Breast', 'value': 31.0, 'measure': 'per 100g', 'icon': '🍗'},
    {'name': 'Whey Protein', 'value': 24.0, 'measure': 'per scoop', 'icon': '🥤'},
    {'name': 'Greek Yogurt', 'value': 10.0, 'measure': 'per 100g', 'icon': '🥄'},
    {'name': 'Eggs (2)', 'value': 12.0, 'measure': 'per 2 large', 'icon': '🥚'},
    {'name': 'Salmon', 'value': 25.0, 'measure': 'per 100g', 'icon': '🐟'},
    {'name': 'Tofu', 'value': 8.0, 'measure': 'per 100g', 'icon': '🧊'},
    {'name': 'Lentils', 'value': 9.0, 'measure': 'per 100g (cooked)', 'icon': '🍛'},
  ];

  void _calculateProtein() {
    double inputWeight = double.tryParse(_weightController.text) ?? 0;
    
    if (inputWeight <= 0) {
      setState(() {
        _minProtein = 0;
        _maxProtein = 0;
      });
      return;
    }

    // Convert lbs to kg if needed
    double weightInKg = _isKg ? inputWeight : inputWeight / 2.20462;

    final goalData = _goals.firstWhere((g) => g['name'] == _selectedGoal);
    final activityData = _activityLevels.firstWhere((a) => a['name'] == _selectedActivity);
    
    final double minFactor = goalData['baseMin'] as double;
    final double maxFactor = goalData['baseMax'] as double;
    final double multiplier = activityData['multiplier'] as double;

    setState(() {
      _minProtein = weightInKg * minFactor * multiplier;
      _maxProtein = weightInKg * maxFactor * multiplier;
    });
  }

  void _addFoodToLog(Map<String, dynamic> food) {
    setState(() {
      _loggedFoods.add(food);
      _loggedProtein += food['value'] as double;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added ${food['name']} (+${food['value']}g protein)'),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _clearLog() {
    setState(() {
      _loggedFoods.clear();
      _loggedProtein = 0;
    });
  }

  void _toggleUnit() {
    setState(() {
      _isKg = !_isKg;
      
      // Convert current text input value
      double currentVal = double.tryParse(_weightController.text) ?? 0;
      if (currentVal > 0) {
        if (_isKg) {
          _weightController.text = (currentVal / 2.20462).toStringAsFixed(1);
        } else {
          _weightController.text = (currentVal * 2.20462).toStringAsFixed(1);
        }
      }
      _calculateProtein();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Protein Pro',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black87,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black87),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Section 1: Unit & Weight ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your Weight",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  // Custom Unit Toggle
                  GestureDetector(
                    onTap: _toggleUnit,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          _buildUnitTab('kg', _isKg),
                          _buildUnitTab('lbs', !_isKg),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _weightController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (val) => _calculateProtein(),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    hintText: _isKg ? 'e.g., 70' : 'e.g., 154',
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.normal),
                    prefixIcon: const Icon(Icons.monitor_weight_outlined, color: Colors.blue),
                    suffixText: _isKg ? 'kg' : 'lbs',
                    suffixStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // --- Section 2: Activity Level ---
              Text(
                "Activity Level",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _activityLevels.map((act) {
                    final bool isSelected = _selectedActivity == act['name'];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text('${act['icon']} ${act['name']}'),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _selectedActivity = act['name'] as String;
                              _calculateProtein();
                            });
                          }
                        },
                        selectedColor: Colors.purple.shade500,
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected ? Colors.purple.shade500 : Colors.grey.shade300,
                          ),
                        ),
                        showCheckmark: false,
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),

              // --- Section 3: Goal ---
              Text(
                "Fitness Goal",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 10,
                children: _goals.map((goal) {
                  final bool isSelected = _selectedGoal == goal['name'];
                  return ChoiceChip(
                    label: Text('${goal['icon']} ${goal['name']}'),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedGoal = goal['name'] as String;
                          _calculateProtein();
                        });
                      }
                    },
                    selectedColor: Colors.blue.shade600,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? Colors.blue.shade600 : Colors.grey.shade300,
                      ),
                    ),
                    showCheckmark: false,
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),

              // --- Section 4: Target Dashboard ---
              if (_minProtein > 0) ...[
                _buildHeroDashboard(),
                const SizedBox(height: 24),
                
                // --- Section 5: Daily Protein Builder ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Build Today's Meal",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    if (_loggedProtein > 0)
                      TextButton(
                        onPressed: _clearLog,
                        child: const Text("Reset", style: TextStyle(color: Colors.redAccent)),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildLiveProgressTracker(),
                const SizedBox(height: 16),
                
                // Food Builder Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2.2,
                  ),
                  itemCount: _foodDatabase.length,
                  itemBuilder: (context, index) {
                    final food = _foodDatabase[index];
                    return InkWell(
                      onTap: () => _addFoodToLog(food),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Text(food['icon'], style: const TextStyle(fontSize: 24)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    food['name'],
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '+${food['value']}g',
                                    style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold, fontSize: 12),
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
                const SizedBox(height: 32),
                
                // ISSN Insights
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.science_rounded, color: Colors.green.shade700),
                          const SizedBox(width: 8),
                          Text(
                            "ISSN Science Insight",
                            style: TextStyle(color: Colors.green.shade900, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Based on the International Society of Sports Nutrition (ISSN), protein intakes of 1.4 – 2.0 g/kg/day are recommended for active individuals. Distribute protein evenly (~20-40g per meal) to maximize Muscle Protein Synthesis (MPS).",
                        style: TextStyle(color: Colors.green.shade800, fontSize: 13, height: 1.4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUnitTab(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        boxShadow: isSelected
            ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))]
            : [],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          color: isSelected ? Colors.black87 : Colors.grey.shade600,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildHeroDashboard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade800, Colors.blue.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.fitness_center_rounded, color: Colors.white70, size: 32),
          const SizedBox(height: 12),
          Text(
            "Optimal Daily Protein",
            style: GoogleFonts.poppins(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "${_minProtein.toStringAsFixed(0)}g - ${_maxProtein.toStringAsFixed(0)}g",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Interactive Meal Distribution Pills
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDistributionPill("🌅 B-Fast", (_minProtein * 0.25).toStringAsFixed(0)),
              const SizedBox(width: 8),
              _buildDistributionPill("🥗 Lunch", (_minProtein * 0.25).toStringAsFixed(0)),
              const SizedBox(width: 8),
              _buildDistributionPill("🥩 Dinner", (_minProtein * 0.30).toStringAsFixed(0)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDistributionPill(String name, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "$name ${value}g",
        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildLiveProgressTracker() {
    // Calculate percentage based on the minimum target
    double percentage = _minProtein > 0 ? (_loggedProtein / _minProtein) : 0;
    if (percentage > 1.0) percentage = 1.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Logged: ${_loggedProtein.toStringAsFixed(0)}g",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "${(percentage * 100).toStringAsFixed(0)}%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: percentage >= 1.0 ? Colors.green : Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: 12,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                percentage >= 1.0 ? Colors.green.shade500 : Colors.blue.shade500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
