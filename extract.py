import os
import re
import json

def extract_from_file(path, type_):
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Extract image
    image_match = re.search(r"Image\.asset\(\s*['\"]([^'\"]+)['\"]", content)
    image = image_match.group(1) if image_match else ""
    
    # Extract title - look for Text("...", style: GoogleFonts.poppins(fontSize: 24 (or 26/34)
    # Actually, look for the first big text
    title_match = re.search(r'Text\(\s*["\'](.*?)["\']\s*,\s*style:\s*GoogleFonts\.poppins\(\s*(?:fontSize:\s*(?:24|26|34)|fontWeight:\s*FontWeight\.bold)', content)
    if not title_match:
        # Fallback for meals
        title_match = re.search(r'Text\(\s*["\']([^"\']+)["\']\s*,\s*style:\s*GoogleFonts\.poppins\(\s*fontSize:\s*24', content)
    title = title_match.group(1) if title_match else ""
    
    if type_ == 'meal':
        # Calories and weight
        cal_match = re.search(r'Calories:\s*([^\\]+?)(?:\\n|\s*kcal)', content)
        calories = cal_match.group(1).strip() + " kcal" if cal_match else ""
        
        weight_match = re.search(r'Weight:\s*([^\\]+?)(?:\\n|")', content)
        weight = weight_match.group(1).strip() if weight_match else ""
        
        # Description
        desc_match = re.search(r'Description.*?Text\(\s*["\'](.*?)["\']\s*,', content, re.DOTALL)
        if desc_match:
            desc = desc_match.group(1).replace('\n', ' ').strip()
        else:
            # Fallback
            desc_match = re.search(r'Text\(\s*["\'](.*?)["\']\s*,\s*style:\s*GoogleFonts\.poppins\(fontSize:\s*16\)', content, re.DOTALL)
            desc = desc_match.group(1).replace('\n', ' ').strip() if desc_match else ""
            
        return {'id': os.path.basename(path).replace('.dart', ''), 'title': title, 'imagePath': image, 'calories': calories, 'weight': weight, 'description': desc}
        
    elif type_ == 'workout':
        # Description
        # Workouts have a description usually after "Description:" or it's a long text.
        desc_match = re.search(r'Text\(\s*["\'](.*?)["\']\s*,\s*style:\s*GoogleFonts\.poppins\(fontSize:\s*16\)', content, re.DOTALL)
        desc = desc_match.group(1).replace('\n', ' ').strip() if desc_match else ""
        
        return {'id': os.path.basename(path).replace('.dart', ''), 'title': title, 'imagePath': image, 'description': desc}

def process_meals():
    meals = []
    meal_dir = 'lib/features/nutrition/diet_plan'
    if os.path.exists(meal_dir):
        for file in os.listdir(meal_dir):
            if file.endswith('.dart'):
                meals.append(extract_from_file(os.path.join(meal_dir, file), 'meal'))
    return meals

def process_workouts():
    workouts = []
    workout_dirs = ['lib/features/workout/lose_fat', 'lib/features/workout/strength', 'lib/features/workout/cardio', 'lib/features/workout/yoga', 'lib/features/workout/warmup']
    for d in workout_dirs:
        if os.path.exists(d):
            for file in os.listdir(d):
                if file.endswith('.dart') and file != 'start_exercise.dart':
                    workouts.append(extract_from_file(os.path.join(d, file), 'workout'))
    return workouts

meals = process_meals()
workouts = process_workouts()

print(json.dumps({'meals': meals, 'workouts': workouts}, indent=2))
