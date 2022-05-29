// const kDurations = [
//   Duration(hours: 0, minutes: 30),
//   Duration(hours: 1, minutes: 0),
//   Duration(hours: 1, minutes: 30),
//   Duration(hours: 2, minutes: 0),
//   Duration(hours: 2, minutes: 30),
//   Duration(hours: 3, minutes: 0),
//   Duration(hours: 3, minutes: 30),
// ];

// final kDentalProblems = [
//   DentalProblem(name: 'Bad breath'),
//   DentalProblem(name: 'Food collection between the teeth'),
//   DentalProblem(name: 'Grinding teeth'),
//   DentalProblem(name: 'Lose teeth or broken fillings'),
//   DentalProblem(name: 'Bleeding gums'),
//   DentalProblem(name: 'Sensitivity to cold'),
//   DentalProblem(name: 'Periodontal disease'),
//   DentalProblem(name: 'Difficulty Chewing/Swallowing'),
//   DentalProblem(name: 'Sensitivity when biting'),
//   DentalProblem(name: 'Sensitivity to sweets'),
//   DentalProblem(name: 'Sensitivity to hot'),
//   DentalProblem(name: 'Sores or growths in the mouth'),
// ];
// const Map<String, String> dentalProblemsPics = {
//   'Bad breath': 'assets/images/bad_breath_dark.jpg',
//   'Food collection between the teeth': 'assets/images/food_collection.png',
//   'Grinding teeth': 'assets/images/teeth_grinding.png',
//   'Lose teeth or broken fillings': 'assets/images/lose_teeth.png',
//   'Bleeding gums': 'assets/images/bleeding_gums.png',
//   'Periodontal disease': 'assets/images/dental-gum-diseases.png',
//   'Sensitivity to cold': 'assets/images/cold_sens.png',
//   'Sensitivity to hot': 'assets/images/sens_tooth.png',
//   'Sensitivity to sweets': 'assets/images/sens_tooth.png',
//   'Sensitivity when biting': 'assets/images/sens_tooth.png',
//   'Sores or growths in the mouth': 'assets/images/download.png',
// };

// /// a map of health problems as keys and their images urls
// Map<String, String> medicalHistoryElementsData = {
//   'Anemia': 'assets/images2/anemia_2.jpg',
//   'Arthritis, Rheumatism': 'assets/images2/arthritis.jpg',
//   'Artificial heart valves': 'assets/images2/heart_valves.jpg',
//   'Athsma': 'assets/images2/athsma.png',
//   'Blood disease': 'assets/images2/blood_disease.png',
//   'Cancer': 'assets/images2/cancer.png',
//   'Chemical dependency': 'assets/images2/chemical_dep.png',
//   'ChemoTherapy': 'assets/images2/chemotherapy.png',
//   'Circulatory problems': 'assets/images2/circulatory_problems.png',
//   'Congential heart lesions': 'assets/images2/congential.png',
//   'Cortisone treatments': 'assets/images2/',
//   'Cough up blood': 'assets/images2/cough_up_blood.jpg',
//   'Diabetes': 'assets/images2/diabetes.png',
//   'Epilepsy': 'assets/images2/epilepsy.png',
//   'Fainting': 'assets/images2/fainting.png',
//   'Glaucoma': 'assets/images2/glaucoma.png',
//   'Headaches': 'assets/images2/headache.jpg',
//   'Heart problems': 'assets/images2/',
//   'Hemophilia': 'assets/images2/',
//   'Hepatitis': 'assets/images2/',
//   'Hernia Repair': 'assets/images2/',
//   'High blood pressure': 'assets/images2/',
//   'HIV/AIDS': 'assets/images2/',
//   'Kidney disease': 'assets/images2/',
//   'Liver disease': 'assets/images2/',
//   'Pacemaker': 'assets/images2/',
//   'Radiation treatment': 'assets/images2/',
//   'Respiratory disease': 'assets/images2/',
//   'Rheumatic fever': 'assets/images2/',
//   'Scarlet fever': 'assets/images2/',
//   'Shortness of breath': 'assets/images2/',
//   'Skin rash': 'assets/images2/',
//   'Stroke': 'assets/images2/',
//   'Swelling of feet or ankles': 'assets/images2/',
//   'Thyroid problems': 'assets/images2/',
//   'Tabacco habit': 'assets/images2/',
//   'Tonsillitis': 'assets/images2/',
//   'Tuberculosis': 'assets/images2/',
//   'Ulcer': 'assets/images2/',
//   'Venereal disease': 'assets/images2/',
// };
// const Map<int, String> kTeethFDINumbers = {
//   11: '11',
//   12: '12',
//   13: '13',
//   14: '14',
//   15: '15',
//   16: '16',
//   17: '17',
//   18: '18',
//   48: '48',
//   47: '47',
//   46: '46',
//   45: '45',
//   44: '44',
//   43: '43',
//   42: '42',
//   41: '41',
//   31: '31',
//   32: '32',
//   33: '33',
//   34: '34',
//   35: '35',
//   36: '36',
//   37: '37',
//   38: '38',
//   28: '28',
//   27: '27',
//   26: '26',
//   25: '25',
//   24: '24',
//   23: '23',
//   22: '22',
//   21: '21',
// };

import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/core/common/utilities/enums.dart';
import 'package:clinic_v2/core/features/users/data/dentist_data.dart'
    show DentalService;
import 'package:clinic_v2/core/common/models/work_shift.dart';
const kDaysOfWeek = {
  'sunday': DateTime.sunday,
  'monday': DateTime.monday,
  'tuesday': DateTime.tuesday,
  'wednesday': DateTime.wednesday,
  'thursday': DateTime.thursday,
  'friday': DateTime.friday,
  'saturday': DateTime.saturday,

};
final kDefaultWorkShifts = [
  WorkShift(
    start: const TimeOfDay(hour: 10, minute: 0),
    end: const TimeOfDay(hour: 20, minute: 0),
    days: kDaysOfWeek.values.toList(),
  ),
];
final kDefaultDentalDentalServices = [
  DentalService(
    'CU',
    'Dental Check ups',
    type: DentalServiceType.checkUp,
    prices: [0],
  ),
  DentalService(
    'SRP',
    'Scaling and Root planing',
    type: DentalServiceType.periodontal,
    prices: [0],
  ),
  DentalService(
    'GC',
    'Gum Cleaning',
    type: DentalServiceType.periodontal,
    prices: [0],
  ),
  DentalService(
    'PS',
    'Periodontal Surgery',
    type: DentalServiceType.periodontal,
    prices: [0],
  ),
  DentalService(
    'NSE',
    'Non Surgical Extraction',
    type: DentalServiceType.extractions,
    prices: [0],
  ),
  DentalService(
    'SE',
    'Surgical Extraction',
    type: DentalServiceType.extractions,
    prices: [0],
  ),
  DentalService(
    'WTE',
    'Wisdom Tooth Extraction',
    type: DentalServiceType.extractions,
    prices: [0],
  ),
  DentalService(
    'DI',
    'Tooth Implant',
    type: DentalServiceType.dentalImplants,
    prices: [0],
  ),
];
const kDefaultMedicationsList = [
  'Amoxicillin 500 mg',
  'Vitamin D 50000 IU',
  'Ibuprofen 800 mg',
  'Cetirizine hydrochloride 10 mg',
  'Azithromycin 250 mg',
  'Amlodipine besylate 10 mg',
  'Albuterol sulfate 108 mcg/act',
  'Cyclobenzaprine hydrochloride 10 mg',
  'Cephalexin 500 mg',
  'Hydrochlorothiazide 25 mg',
  'Lisinopril 20 mg',
  'Amphetamine/dextroamphetamine 20 mg',
  'Loratadine 10 mg',
  'Amoxicillin-clavulanate potassium 875-125 mg',
  'Folic acid 1 mg',
  'Prednisone 20 mg',
  'Benzonatate 100 mg',
  'Gabapentin 300 mg',
  'Zolpidem tartrate 10 mg',
  'Sulfamethoxazole/trimethoprim DS 800-160 mg',
  'Methylprednisolone 4 mg',
  'Fluconazole 150 mg',
  'Aspirin low dose 81 mg',
  'Atorvastatin calcium 40 mg',
  'Ferrous sulfate 325 mg',
  'Cyanocobalamin 1000 mcg/ml',
  'Metronidazole 500 mg',
  'Bromphen/HBr',
  'Pantoprazole sodium 40 mg',
  'Vitamin D3 50000 IU',
  'Naproxen 500 mg',
  'Alprazolam 0.5 mg',
  'Oseltamivir phosphate 75 mg',
  'Nitrofurantoin monohydrate macrocrystals 100 mg',
  'Losartan 100 mg',
  'Metoprolol succinate ER 25 mg',
  'Fluticasone propionate 50 mcg/act',
  'Chlorhexidine gluconate 0.12%',
  'Doxycycline hyclate 100 mg',
  'Metoprolol tartrate 25 mg',
  'Phenazopyridine HCl 200 mg',
  'Latanoprost eye drops 0.005%',
  'Sertraline HCl 50 mg',
  'Trazodone hydrochloride 50 mg',
  'Omeprazole 20 mg',
  'Ciprofloxacin hydrochloride 500 mg',
  'Levothyroxine sodium 50 mcg',
  'Meloxicam 15 mg',
  'Docusate sodium 100 mg',
  'Triamcinolone acetonide cream 0.1%',
];
// const kDefaultAllergies = [
//   'Metal allergies',
//   'Latex allergy',
//   'Acrylic resin allergy',
//   'Antibiotics allergy',
//   'Local anesthetic allergy',
// ];
