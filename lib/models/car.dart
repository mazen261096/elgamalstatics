import 'package:elgamalstatics/presentation/logic_code_machine/price_calcuator.dart';
import 'package:elgamalstatics/presentation/resources/strings_manager.dart';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';

class Car {
  late int id;
  late int? insuranceCode;
  late String url;
  late String? fileName;
  late String company;
  late String brand;
  late String model;
  late String luxuryCategory;
  late String city;
  late String address;
  late DateTime actualYear;
  late int licenseYear;
  late int counter;
  late String carType;
  late String color;
  late int price;
  late bool? review;
  late bool? repairImage;
  late bool? enka;
  late List<String> repairs;
  late int repairsCount;
  late String contactNumber;
  late List<String> carPhotos;
  late String titleModel;
  late String titleEngine;
  late String titleType;
  late int insuranceDate;
  late bool active;
  late String repairImages;
  late String accessories1;
  late String accessories2;
  late String accessories3;
  late String accessories4;
  late String allAccessories;
  late Map<String, bool> singleAccessories ;
  late int               totalCostDollar   ;
  late int               totalCostEgp      ;
  int? bonus ;

  Car.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    fileName = data['fileName'];
    insuranceCode = data['insuranceCode'];
    url = data['url'];
    city = data['city'];
    address = data['address'];
    actualYear = DateTime.parse(data['actualYear']);
    licenseYear = data['licenseYear'];
    counter = data['counter'];
    carType = data['carType'];
    color = data['color'];
    price = data['price'];
    review = data['review'];
    repairImage = data['repairImage'];
    enka = data['enka'];
    repairs = data['repairs'].cast<String>();
    repairsCount = data['repairsCount'];
    contactNumber = data['contactNumber'];
    carPhotos = data['carPhotos'].cast<String>();
    titleModel = data['titleModel'];
    titleEngine = data['titleEngine'];
    titleType = data['titleType'];
    insuranceDate = data['insuranceDate'];
    active = data['active'];
    repairImages = data['repairImages'];
    accessories1 = data['accessories1'];
    accessories2 = data['accessories2'];
    accessories3 = data['accessories3'];
    accessories4 = data['accessories4'];
    allAccessories = data['allAccessories'];
    singleAccessories = data['singleAccessories'].cast<String, bool>();
    totalCostDollar = data['totalCostDollar'];
    totalCostEgp = data['totalCostEgp'];
    company=data ['company'];
    brand  =data ['brand'];
    model  =data ['model'];
    luxuryCategory = data['luxuryCategory'];
    if(fileName == 'elgamal') bonus = data['bonus'];
  }

  Car.fromRow(List<Data?> row, String name) {

    PriceCalculator.fetchNumbers();
    id = row[0] == null ? 999999999 : int.parse(row[0]!.value.toString());
    fileName = name;
    print(name);
    company = name != 'elgamal' ? name.split('_')[0] : row[36]!.value.toString();
    brand = name != 'elgamal' ? name.split('_')[1] : row[37]!.value.toString();
    model = name != 'elgamal' ? name.split('_')[2] : row[38]!.value.toString();
    luxuryCategory = name != 'elgamal' ? name.split('_')[3] : row[39]!.value.toString();
    insuranceCode = row[1]?.value == null ? 99999999 : int.tryParse(row[1]!.value.toString()) ?? 999999999;
    url = row[2] == null ? '' : row[2]!.value.toString();
    city = row[3] == null ? '' : row[3]!.value.toString();
    address = row[4] == null ? '' : row[4]!.value.toString();
    actualYear = row[5] == null ? DateTime.now() : getDateFromYearMonth(row[5]!.value.toString());
    licenseYear = actualYear.month >= 6 ? actualYear.year + 1 : actualYear.year;
    counter = row[6] == null ? 999999999 : int.parse(row[6]!.value.toString());
    carType = row[11]!.value.toString();
    color = row[12]!.value.toString();
    price = int.parse(row[13]!.value.toString());
    review = row[14]?.value.toString().toLowerCase().trim() == 'true' ? true : false;
    repairImage = row[15]?.value == null ? false : true;
    enka = row[16]?.value.toString().toLowerCase().trim() == 'true' ? true : false;
    repairs = row[17]!.value.toString().split("_x000D_").map((e) => e.trim()).toList();
    repairsCount = int.parse(row[18]!.value.toString());
    contactNumber = row[21] == null ? '' : row[21]!.value.toString();
    carPhotos = refactorCarPhotos(row[24]!.value.toString());
    titleModel = row[25]!.value.toString();
    titleEngine = row[26]!.value.toString();
    titleType = row[27]!.value.toString();
    insuranceDate = calculateMonthsOutOfInsurance(row[28] == null ? '' : row[28]!.value.toString());
    active = row[29]?.value.toString().toLowerCase().trim() == 'true' ? true : false;
    repairImages = repairImage == true ? row[30]!.value.toString() : '';
    accessories1 = row[32]!.value.toString();
    accessories2 = row[33]!.value.toString();
    accessories3 = row[34]!.value.toString();
    accessories4 = row[35]!.value.toString();
    allAccessories = '  $accessories1  $accessories2  $accessories3  $accessories4 ';

    singleAccessories = getSingleAccessories(allAccessories: allAccessories);

    totalCostDollar = name=='elgamal'? double.parse(row[40]!.value.toString()).toInt():PriceCalculator.totalCostDollar(carPrice: double.parse(row[13]!.value.toString())).toInt();

    totalCostEgp =    name=='elgamal'? double.parse(row[41]!.value.toString()).toInt():PriceCalculator.totalCostEgp(carPrice: double.parse(row[13]!.value.toString())).toInt();

    bonus = name=='elgamal'? double.parse(row[42]!.value.toString()).toInt():null;


  }

   Map<String, dynamic> toJson(Car car) {
    return {
      "id": car.id,
      "fileName": car.fileName,
      "insuranceCode": car.insuranceCode,
      "url": car.url,
      "city": car.city,
      "address": car.address,
      "actualYear": car.actualYear.toString(),
      "licenseYear": car.licenseYear,
      "counter": car.counter,
      "carType": car.carType,
      "color": car.color,
      "price": car.price,
      "review": car.review,
      "repairImage": car.repairImage,
      "enka": car.enka,
      "repairs": car.repairs,
      "repairsCount": car.repairsCount,
      "contactNumber": car.contactNumber,
      "carPhotos": car.carPhotos,
      "titleModel": car.titleModel,
      "titleEngine": car.titleEngine,
      "titleType": car.titleType,
      "insuranceDate": car.insuranceDate,
      "active": car.active,
      "repairImages": car.repairImages,
      "accessories1": car.accessories1,
      "accessories2": car.accessories2,
      "accessories3": car.accessories3,
      "accessories4": car.accessories4,
      "allAccessories": car.allAccessories,
      "singleAccessories": car.singleAccessories,
      "totalCostDollar": car.totalCostDollar,
      "totalCostEgp": car.totalCostEgp,
      "company":car.company,
      "brand":car.brand,
      "model":car.model,
      "luxuryCategory":car.luxuryCategory,
    if(fileName == 'elgamal') 'bonus':car.bonus

    };
  }



  List<String> refactorCarPhotos(String sheetLinks) {
    List purePhotos = sheetLinks.split("\n").skip(1)
        .where((url) => url.isNotEmpty) // إزالة السلاسل الفارغة
        .map((url) {
      final cleanUrl = url.split('?')[0] + '?impolicy=heightRate'; // إزالة العلامة المائية من الرابط
      final parts = cleanUrl.split('/'); // تقسيم الرابط بناءً على العلامة "_"
      final number = parts.last.split('_').last; // استخراج رقم الصورة
      return {'url': cleanUrl, 'number': number};
    })
        .toList();

    // ترتيب الصور وفقًا لأرقامها
    purePhotos.sort((a, b) => a['number'].compareTo(b['number']));

    // استخراج الروابط بعد التنظيف والترتيب
    return purePhotos.map((photo) => photo['url'] as String).toList();
  }

  Map<String, bool> getSingleAccessories({required String allAccessories}) {
    return {
      AppStrings.accessories11: allAccessories.contains(AppStrings.accessories11),
      AppStrings.accessories12: allAccessories.contains(AppStrings.accessories12),
      AppStrings.accessories13: allAccessories.contains(AppStrings.accessories13),
      AppStrings.accessories14: allAccessories.contains(AppStrings.accessories14),
      AppStrings.accessories15: allAccessories.contains(AppStrings.accessories15),
      AppStrings.accessories16: allAccessories.contains(AppStrings.accessories16),
      AppStrings.accessories17: allAccessories.contains(AppStrings.accessories17),
      AppStrings.accessories18: allAccessories.contains(AppStrings.accessories18),
      AppStrings.accessories19: allAccessories.contains(AppStrings.accessories19),
      AppStrings.accessories110: allAccessories.contains(AppStrings.accessories110),
      AppStrings.accessories111: allAccessories.contains(AppStrings.accessories111),
      AppStrings.accessories112: allAccessories.contains(AppStrings.accessories112),
      AppStrings.accessories113: allAccessories.contains(AppStrings.accessories113),
      AppStrings.accessories114: allAccessories.contains(AppStrings.accessories114),
      AppStrings.accessories115: allAccessories.contains(AppStrings.accessories115),
      AppStrings.accessories116: allAccessories.contains(AppStrings.accessories116),
      AppStrings.accessories117: allAccessories.contains(AppStrings.accessories117),
      AppStrings.accessories21: allAccessories.contains(AppStrings.accessories21),
      AppStrings.accessories22: allAccessories.contains(AppStrings.accessories22),
      AppStrings.accessories23: allAccessories.contains(AppStrings.accessories23),
      AppStrings.accessories24: allAccessories.contains(AppStrings.accessories24),
      AppStrings.accessories25: allAccessories.contains(AppStrings.accessories25),
      AppStrings.accessories26: allAccessories.contains(AppStrings.accessories26),
      AppStrings.accessories27: allAccessories.contains(AppStrings.accessories27),
      AppStrings.accessories28: allAccessories.contains(AppStrings.accessories28),
      AppStrings.accessories29: allAccessories.contains(AppStrings.accessories29),
      AppStrings.accessories210: allAccessories.contains(AppStrings.accessories210),
      AppStrings.accessories211: allAccessories.contains(AppStrings.accessories211),
      AppStrings.accessories212: allAccessories.contains(AppStrings.accessories212),
      AppStrings.accessories213: allAccessories.contains(AppStrings.accessories213),
      AppStrings.accessories31: allAccessories.contains(AppStrings.accessories31),
      AppStrings.accessories32: allAccessories.contains(AppStrings.accessories32),
      AppStrings.accessories33: allAccessories.contains(AppStrings.accessories33),
      AppStrings.accessories34: allAccessories.contains(AppStrings.accessories34),
      AppStrings.accessories35: allAccessories.contains(AppStrings.accessories35),
      AppStrings.accessories36: allAccessories.contains(AppStrings.accessories36),
      AppStrings.accessories37: allAccessories.contains(AppStrings.accessories37),
      AppStrings.accessories38: allAccessories.contains(AppStrings.accessories38),
      AppStrings.accessories39: allAccessories.contains(AppStrings.accessories39),
      AppStrings.accessories310: allAccessories.contains(AppStrings.accessories310),
      AppStrings.accessories311: allAccessories.contains(AppStrings.accessories311),
      AppStrings.accessories312: allAccessories.contains(AppStrings.accessories312),
      AppStrings.accessories313: allAccessories.contains(AppStrings.accessories313),
      AppStrings.accessories314: allAccessories.contains(AppStrings.accessories314),
      AppStrings.accessories315: allAccessories.contains(AppStrings.accessories315),
      AppStrings.accessories316: allAccessories.contains(AppStrings.accessories316),
      AppStrings.accessories41: allAccessories.contains(AppStrings.accessories41),
      AppStrings.accessories42: allAccessories.contains(AppStrings.accessories42),
      AppStrings.accessories43: allAccessories.contains(AppStrings.accessories43),
      AppStrings.accessories44: allAccessories.contains(AppStrings.accessories44),
      AppStrings.accessories45: allAccessories.contains(AppStrings.accessories45),
      AppStrings.accessories46: allAccessories.contains(AppStrings.accessories46),
      AppStrings.accessories47: allAccessories.contains(AppStrings.accessories47),
      AppStrings.accessories48: allAccessories.contains(AppStrings.accessories48),
    };
  }

  DateTime getDateFromYearMonth(String yearMonth) {
    // Parse the year and month from the input string
    int year = int.parse(yearMonth.substring(0, 4));
    int month = int.parse(yearMonth.substring(4, 6));

    // Create a DateTime object with the provided year and month
    return DateTime(year, month);
  }


  int calculateMonthsOutOfInsurance(String? periodsText) {
    if (periodsText == null || periodsText.isEmpty) {
      return 0; // إذا كان النص فارغًا نرجع صفر
    }

    // استخراج الفترات
    List<String> periods = periodsText.split(',');

    int totalMonths = 0;

    // تعريف تنسيق التاريخ
    DateFormat dateFormat = DateFormat('yyyy년 MM월');

    for (String period in periods) {
      // إزالة المسافات غير الضرورية
      period = period.trim();

      // تقسيم الفترة إلى بداية ونهاية
      List<String> dates = period.split('~');
      if (dates.length != 2) {
        continue; // إذا لم تكن الفترة تحتوي على تاريخين
      }

      try {
        // تحويل التواريخ من النصوص إلى كائنات DateTime
        DateTime startDate = dateFormat.parse(dates[0].trim());
        DateTime endDate = dateFormat.parse(dates[1].trim());

        // حساب الفرق بالشهور
        int monthsDifference = (endDate.year - startDate.year) * 12 + (endDate.month - startDate.month);
        totalMonths = monthsDifference ; // إضافة 1 لاحتساب الشهر الحالي
      } catch (e) {
        // في حالة حدوث خطأ في التنسيق، يتم تجاهل الفترة
        continue;
      }
    }

    return totalMonths;
  }


  String generateFacebookPostFromCar(Car car) {
    String carTitle = "🚗✨ ${car.company} - ${car.brand} - ${car.licenseYear} - ${car.luxuryCategory} ✨🚗";

    String carInfo = """
💎 الـشـركـة : ${car.company} .
💎 الـمـاركـة : ${car.brand} .
💎 الـمـوديـل : ${car.model} .
📅 الـسـنـة : ${car.licenseYear} .
🏎️ الـفـئـة : ${car.luxuryCategory} .
🎨 الـلـون : ${car.color} .
🔢 الـعـداد : ${car.counter.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => "${match.group(1)},")} كم .
🛠️ الإصـلاحـات: ${car.repairsCount == 0 ? 'لا يوجد إصلاحات' : car.repairs.toString()}
💰 الـسـعـر : ${car.totalCostDollar.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => "${match.group(1)},")} دولار (${car.totalCostEgp.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => "${match.group(1)},")} جنيه مصري) .
  """;

    // فلترة الإضافات الفعلية فقط من ماب الإضافات
    List<String> trueAccessories = car.singleAccessories.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();

    // تنسيق الإضافات
    String accessoriesInfo = trueAccessories.isNotEmpty
        ? "✨ الـكـمـالـيـات :\n" +  trueAccessories.map((acc) => "✔️ ${acc} .").join(" \n")
        : "❌ لا توجد كماليات";

    // إضافة لمسات تسويقية مع تنسيق سطر التواصل
    String marketingTouch = """
📞 للتفاصيل والتواصل : 
📱 01288833353
  """;

    return """
${carTitle}
────────────────────────\n
${carInfo}
────────────────────────\n
${accessoriesInfo}\n
────────────────────────\n
${marketingTouch}
  """;
  }



}
