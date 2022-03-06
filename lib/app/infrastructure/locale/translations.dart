class AppTranslation {
  Map<String, Map<String, String>> get keys => const {
        'en': {
          'العربية': 'Arabic',
        },
        'ar': {
          // Login secreen
          'Login': 'تسجيل الدخول',
          'Username': 'اسم المستخدم',
          'Password': 'كلمة المرور',
          'username is required!': '!هذا الحقل مطلوب',
          'this field can not be empty!': '!هذا الحقل لا يمكن أن تكون فارغاً',
          'password is too short!': 'كلمة السر قصيرة!',
          'DISMISS': 'إغلاق',
          'OPEN WIFI SETTINGS': 'فتح إعدادت الواي فاي',

          // Home screen
          'Home': 'الرئيسية',
          'Today': 'اليوم',
          'Upcoming': 'المواعيدالقادمة',
          // 'Add': 'إضافة ',
          'Calendar': 'التقويم',
          'Search': 'البحث',
          'No appointments\nscheduled for the day': 'لا يوجد مواعيد لهذا اليوم',

          // Manage services screen
          'Services management': 'إدارة الخدمات',
          'Manage Services': 'إدارة الخدمات',
          // 'Dental treatments': '',
          'Cosmetic treatments': 'العلاجات التجميلية',
          'price': 'السعر',
          'type No. ': 'النوع رقم ',
          'Add a type': 'إضافة نوع جديد',
          'New dental service': 'خدمة سنيّة جديدة',
          'Dental service type': 'نوع الخدمة السنيّة',
          'service name': 'اسم الخدمة',
          'select type': 'اختر النوع',
          'Dental service info': ' معلومات الخدمةالسنيّة',
          'Dental service prices': 'أسعار الخدمة السنيّة',
          'This field is required!': 'هذا الحقل مطلوب!',
          // Search screen
          'patients': 'مرضى',
          'appts': 'مواعيد',
          'payments': 'دفعات',
          'Search...': 'البحث...',
          'search for:': 'البحث عن:',
          'search for patients': 'البحث عن مرضى',
          'search for appts': 'البحث عن مواعيد',
          'search for payments': 'البحث عن مدفوعات',
          'No patient found with the name: ': 'لا يوجد مريض باسم: ',
          'No appointments found for ': 'لا يوجد مواعيد من أجل ',
          'No payments found for ': 'لا يوجد مدفوعات من قبل ',
          // settings screen
          'Settings': 'الإعدادت',
          'Apperance': 'المظهر',
          'Prefrences': 'التفضيلات',
          'Account': 'الحساب',
          'Language': 'اللغة',
          'English': 'الإنجليزية',
          'العربية': 'العربية',
          'Dark mode': 'الوضع الليلي',
          'enabled': 'مفعّل',
          'disabled': 'غير مفعّل',
          'app language:': 'لغة التطبيق',
          // All Pateints screen
          'My Patients': 'قائمة المرضى',
          'My patients': 'قائمة المرضى',
          'No patients have been added.': 'لم يتم إضافة أيّة مرضى.',
          'add patients from contacts': 'إضافة مرضى من جهات الاتصال',
          // Payments screen
          'filter: ': 'التصفية: ',
          'pending': 'معلق',
          'paid': 'مدفوع',
          'all': 'الكل',
          'total: ': 'الإجمالي: ',
          ' - paid amount: ': ' - المبلع المدفوع: ',
          'S.P': 'ل.س',
          'No payments found by ': 'لا يوجد أي مدفوعات من قبل ',
          'tap on an appointment to view more details': '',
          'tap on a payment to view more details':
              'اضغط على واحدة من الدفعات لعرض المزيد من التفاصيل',
          'payment additional details': 'تفاصيل إضافية عن الدفعة',
          'Payment status': 'حالة الدفعة',
          'set as paid': 'تحديد الحالة كمدفوع',
          'open in full view mode': 'فتح في الوضع الكامل ',
          'delete payment': 'حذف الدفعة',
          'go to patient profile': 'الذهاب إلى ملف المريض',
          //================//
          //================//
          // Patient Screen //
          //================//
          //Tabs titles//
          'Profile': 'الملف الشخصي',
          'Appointments': 'المواعيد',
          'Payments': 'المدفوعات',
          'Docs': 'الملفات',
          // 'New patient': 'مريض جديد',
          //
          // popup menu //
          'Call': 'اتصال',
          'Open in WhatsApp': 'فتح في واتساب',
          'Save': 'حفظ',
          'Edit': 'تعديل',
          'Delete': 'حذف',
          //
          // profile tab //
          'Personal Info': 'المعلومات الشخصية',
          'Name': 'الاسم',
          'Contact No.': 'رقم التواصل',
          'Age': 'العمر',
          'Address': 'العنوان',
          'Gender': 'الجنس',
          'male': 'ذكر',
          'female': 'أنثى',
          'Date created': 'تاريخ الإضافة',
          'Presonal Info': 'المعلومات الشخصية',
          'Dental History': 'التاريخ السِني',
          'DENTAL HISTORY': 'التاريخ السِني',
          'Dental treatments': 'العلاجات السنيّة',
          'Dental problems': 'المشاكل السنيّة',
          'Medical History': 'التاريخ المرضي',
          'MEDICAL HISTORY': 'التاريخ المرضي',
          'Current': 'حالية',
          'Old': 'سابقة',
          'New': 'جديدة',
          'Previous': 'سابقة',
          'planned': 'مخطط لها',
          'completed': 'مُنجزة',
          'Add/edit dental problems': 'إضافة/تعديل الأمراض السنيّة',
          // 'Dental problems':
          'Select form your contacts': 'اختر من جهات الاتصال الخاصة بك',
          'Last treatment date': 'تاريخ آخر معالجة',
          'edit date of last visit to a dentist':
              'تعديل تاريخ آخر زيارة لطبيب أسنان',
          'add date of last visit to a dentist':
              'إضافة تاريخ آخر زيارة لطبيب أسنان',
          'enter last visit date:': 'ادخل تاريخ آخر زيارة',
          'Go to patient medical history': 'الذهاب إلى التاريخ المَرَضي',

          //
          // Appointments tab//
          'No appointments have been added.': 'لم يتم إضافة أية مواعيد.',
          "Save the patient's info before adding new appointments.":
              'قم بحفظ معلومات المريض قبل إضافة مواعيد جديدة',
          'cancel this appt.': 'إلغاء هذا الموعد',
          'change status': 'تغيير الحالة',
          'planned treatments': 'العلاجات المخطط لها',
          'completed treatments': 'العلاجات المنتهبة',
          'No treatments have been added': 'لم يتم إضافة أية علاجات',
          'treatment No. ': 'العلاج رقم ',
          'appointment additional details': 'تفاصيل إضافية عن الموعد',
          'tap on an appt to view more details':
              'اضغط على واحدة من المواعيد لعرض المزيد من التفاصيل',
          ' to ': ' إلى ',
          // Payments tab//
          'No payments have been added.': 'لم يتم إضافة أية مدفوعات.',
          "Save the patient's info before adding new payments.":
              'قم بحفظ معلومات المريض قبل إضافة دفعات جديدة',
          'performed dental treatment(s):': 'العلاجات السنية المنجزة:',
          // 'tap on a payment to view more details':'اضغط على واحدة من الدفعات لعرض المزيد من التفاصيل',
          // Add New Screen
          'New payment': 'دفعة جديدة',
          'New Appt.': 'موعد جديد',
          'New patient': 'مريض جديد',
          'New treatment session': 'جلسة علاج جديدة',
          // ============== //
          // Appt Screen
          'Add new appointment': 'إضافة موعد جديد',
          'Edit appointment ': 'تعديل بيانات الموعد',
          'Add': 'إضافة',
          'Save changes': 'حفظ التعديلات',
          'search for a patient...': 'ابحث عن مريض...',
          'Add treatment plan for this appointment':
              'إضافة خطة  علاج لهذا الموعد',
          'Edit this appointment treatment plan': 'تعديل خطة علاج هذا الموعد ',
          'please select a patient first..': 'رجاءً اختر المريض أولاً...',
          'note': 'تنبيه',
          // ===========//
          'Patient name': 'اسم المريض',
          'Appt. Date': 'تاريخ الموعد',
          'Appt. Hours': 'وقت الموعد',
          'None is selected..': 'لم يتم تحديد ساعات الزيارة...',
          'Available Hours': 'الساعات المتاحة',
          'Treatment(s) detailes': 'تفاصيل العلاج',
          'add treatment(s) plan': 'إضافة خطة العلاج',
          'remove treatment(s) plan': 'إزالة خطة العلاج',
          'Add Appt. treatment plan': 'إضافة خطة العلاج',
          // appt treatment section //
          'Teeth view': 'الأسنان',
          'Treatment(s) status': 'حالة العلاج',
          'Dental treatment(s)': 'العلاجات السنية',
          'upper': 'علوي',
          'lower': 'سفلي',
          'add more': 'إضافة المزيد',
          // payment screen //
          'Payment details': 'تفاصيل الدفعة',
          'Payment date': 'تاريخ الدفعة',
          // 'paid': '',
          // ===========//
          // ADD NEW PATIENT SCREEN//
          // ========================================//
          // PERSONAL INFO SECTION//
          // ========================================//
          'phone number field is required!': 'حقل الرقم مطلوب!',
          'age field is required!': 'حقل تاريخ الولادة مطلوب!',
          'address field is required!': 'حقل العنوان مطلوب!',
          'name field is required!': 'حقل الاسم مطلوب!',
          'Done': 'إنهاء',
          'prev': 'للخلف',
          'Next': 'التالي',
          'ADD': 'إضافة',
          'add/edit': 'إضافة/تعديل',
          'Add other patient info OR continue to profile page.':
              'أضف معلومات إضافية عن المريض أو تابع لملفه الشخصي.',
        },
      };
}
