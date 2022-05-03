import 'package:hewa/models/reStep_model.dart';
import 'package:hewa/utilities/query.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:collection/collection.dart';
import 'package:hewa/models/reStep_model.dart';

class ReStepHelper {
  final String nameDatabase = 'Hewa.db';
  final String tableDatabase = 'recipeStepTABLE';
  int version = 1;

  final String idColumn = 'id';
  final String recipeIdColumn = 'recipeId';
  final String stepColumn = 'step';
  final String descriptionColumn = 'description';

  ReStepHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $recipeIdColumn TEXT, $stepColumn INTEGER, $descriptionColumn TEXT)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

//insertข้อมูลและโชว์errorของดาต้าเบส
  Future<Null> insertDataToSQLite(ReStepModel reStepModel) async {
    // Database database = await connectedDatabase();
    try {
      HewaAPI().insert(tableDatabase, reStepModel.toJson());
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<int> insert(ReStepModel reStepModel) async {
    //Database database = await connectedDatabase();
    var results = HewaAPI().insert(tableDatabase, reStepModel.toJson());
    return results;
  }

  Future<Null> initInsertDataToSQLite() async {
    Database database = await connectedDatabase();
    var steps = [
      [
        "ต้มน้ำซุปต้มไก่ โดยใส่ รากผักชี กระเทียม พริกไทย ขิง น้ำตาลกรวด ซีอิ๊วขาว เกลือ เคี่ยวประมาณ 15 นาที นำไก่ลงไปต้มต่อจนไก่สุก ใช้เวลาประมาณ 30 นาที",
        "นำไก่ที่สุกแล้วไปน็อกในน้ำผสมน้ำแข็ง จนไก่เย็น ใช้เวลาประมาณ 5 – 10 นาที แล้วนำไก่ขึ้นพักให้สะเด็ดน้ำ ทาด้วยน้ำมันพืชบาง ๆ ให้ทั่วชิ้นไก่ พักไว้",
        "น้ำซุปที่ต้มไก่ให้ช้อนมันออกจากน้ำซุป เอาออกจนน้ำซุปใส ใส่ฟักที่หั่นแล้วลงไปต้ม ปรุงรสด้วยซีอิ๊ว และเกลือ ต้มจนฟักสุก",
        "หุงข้าวมันไก่ โดยเจียวกระเทียมกับขิงแก่บุบจนหอม ใส่ข้าวสารดิบลงไป ผัดพอเข้ากัน ปรุงรสด้วยเกลือ น้ำมันไก่ที่ช้อนไว้ ผัดอีกรอบแล้วเทใส่หม้อหุงข้าว ใส่น้ำซุปต้มไก่ลงไป หุงจนข้าวสุก"
      ],
      [
        "เตรียมส่วนผสม หุงข้าวเตรียมไว้ แต่จะดีที่สุดถ้าเป็นข้าวเก่าที่ทานเหลือแช่ตู้เย็นไว้ เพราะ มาผัดจะไม่แฉะ หั่นผักต่างๆให้เรียบร้อยพักเตรียมไว้",
        "ตั้งไฟให้ร้อนใส่น้ำมัน กระเทียมลงไปผัดให้หอม ตามด้วยหมูลงไปผัดให้สุก และใส่ผัก ตามด้วยไข่ไก่ ใส่ข้าวหลังสุด",
        "ปรุงรสใส่ซีอิ๊ว น้ำตาล ซีอิ๊วดำ ผัดจนข้าวสีเหลืองหอม ชิมรสให้ถูกใจก่อนจัดเสริฟ"
      ],
      [
        "ตั้งกระทะใส่น้ำมันให้พอร้อน แล้วใส่กระเทียม และพริกแดงจินดาลงไปผัดจนส่งกลิ่นหอม จากนั้นใส่หมูสับลงไปผัด",
        "เมื่อหมูเริ่มสุกให้ปรุงรสด้วย ซอสหอยนางรม น้ำปลา และน้ำตาลทราย ผัดจนทุกอย่างเข้ากันดี จากนั้นใส่ใบกะเพราลงไปผัดให้สลดลงเล็กน้อย",
        "ตักข้าวสวยร้อน ๆ ใส่จานราดด้วยหมูสับผัดกะเพราหมูสับ"
      ],
      [
        "ใส่หอมแดงคั่ว กระเทียมไทยคั่ว รากผักชี พริกไทยเม็ด พริกชี้ฟ้าสดสีเขียว พริกขี้หนูสด ตะไคร้ ข่า ผิวมะกรูด ลูกผักชี ยี่หร่า ลูกจันทน์ เกลือ กะปิ ลงในครก ตำให้ละเอียด",
        "ตั้งกระทะทรงสูง ใส่หัวกะทิลงไป เคี่ยวด้วยไฟอ่อนจนแตกมัน แล้วจึงใส่พริกแกงเขียวหวานลงไปผัดให้ส่งกลิ่นหอม",
        "ปรับไฟเป็นไฟกลาง จากนั้นใส่เนื้อไก่ลงไปผัดให้เข้ากับพริกแกง จนเนื้อไก่พอสุก",
        "เมื่อผัดเนื้อไก่จนเข้ากับพริกแกงแล้ว เติมหางกะทิลงไป รอจนกะทิเดือด จึงปรุงรสด้วยน้ำปลา และน้ำตาลปี๊บ คนให้ละลายเข้ากัน",
        "ใส่ใบมะกรูด มะเขือเปราะ และมะเขือพวงลงไป รอจนเดือดอีกครั้ง จึงปิดไฟ ใส่พริกชี้ฟ้าแดง และใบโหระพาลงไป และคนให้เข้ากัน",
        "ตักแกงเขียวหวานไก่ใส่ชาม ตกแต่งด้วยใบโหระพาและพริกชี้ฟ้าแดง พร้อมรับประทาน"
      ],
      [
        "นำกุ้งมาปลอกเปลือกและผ่าหลังเอาเส้นดำๆออก"
            "เอาข่า ตะไคร้ ใบมะกูดมาล้างให้สะอาด แล้วหั่นเตรียมไว้   ปลอกหอมแดงแล้วนำมาล้างให้สะอาดแล้วนำไปทุบให้แตกเล็กน้อย  ล้างพริกให้สะอาด แล้วเอาพริกจินดามาตำให้แหลก  ผักชีฝรั่งล้างสะอาดแล้วนำมาซอย  หั่นเห็ดและนำมาล้างให้สะอาด",
        "น้ำ 400 ml ตั้งไฟให้เดือดจากนั่นใส่ ข่า ตะไคร้ ใบมะกูด หอมแดง ต้มสักพักแล้วแล้วใส่เห็ดลงไป พอเดือดตามด้วยกุ้ง",
        "กุ้งเริ่มออกสีแดงก้อเริ่มปรุงรสกันเลย ใส่พริกเผา 1 ช้อน นมสด 7 ช้อน แล้วตามด้วยใส่พริกแล้วแต่ชอบเผ็ดมากเผ็ดน้อย ตามด้วยน้ำปลา 2 ช้อน น้ำตาล 1 ช้อน น้ำมะนาว 2 ช้อน ชิมตามรสชาติที่ชอบ โรยด้วยพริกขี้หนูและผักชีฝรั่ง"
      ],
      [
        "นำไข่ไก่มาล้างเปลือกให้สะอาด แล้วนำไปต้ม 10 นาที ให้ใส่เกลือลงไปด้วย 1 ช้อนจะได้ปอกง่าย  พอครบ 10 นาที เทน้ำออกแล้วนำไข่ไปแช่ทิ้งไว้ในน้ำเย็น  ไข่เย็นแล้วค่อยๆแกะเปลือกออก",
        "เอาหมูสามชั้นมาล้างให้สะอาด หั่นชิ้นสี่เหลี่ยมลูกเต๋า ให้หนาหน่อย เพราะเวลาต้มแล้วจะหดลงอีก"
            "เอาพริกไทย กระเทียม รากผักชี เอาไปตำรวมกัน",
        "ตำจนละเอียดเป็นสามเกลอ",
        "หม้อสำหรับต้ม ใส่น้ำมันลงไป พอน้ำมันร้อนให้เอาสามเกลอลงไปผัดให้หอมเลย",
        "จากนั้นเติมน้ำตาลปีบลงไป ค่อยๆเติมก้อได้นะคะ ระวังจะหวาน ค่อยๆผัดใช้ไฟอ่อนจะเขี้ยวเป็นสีน้ำตาลสวยๆ",
        "จากนั้นนำหมูสามชั้นที่หั่นเตรียมไว้ลงไปผัดจนหมูเริ่มสุก",
        "ค่อยๆเติมนำลงไปให้ท้วมหมู จากนั้นเปิดไฟกลาง ต้มต่อ 1 ชม. ให้หมูนุ่ม",
        "เติมไข่ลงไป ปรุงรสด้วยซีอิ้วขาว ผงปรุงรส ถ้าสียังไม่เข้ม เติมซี้อิ่วดำลงไปเล็กน้อย ต้มต่ออีกครึ่งชม. จากนั้นชิมรสตามชอบใจ"
      ],
      [
        "เตรียมต้นหอม และขึ้นฉ่าย ล้างให้สะอาด ตัดรากออก หั่นยาวประมาณ 3-4 นิ้ว บุบรากผักชี กระเทียม พริกไทย และหั่นขิงเป็นแว่นเตรียมไว้ ผสมน้ำราดกุ้งอบวุ้นเส้น โดยใส่น้ำมันหอย น้ำปลา ซีอิ๊วขาว น้ำตาล และเหล้าจีน 1 ช้อนโต๊ะ (อีก 1 ช้อนโต๊ะ แบ่งไว้ก่อน) คนให้เข้ากันจนน้ำตาลละลาย แล้วเติมน้ำสต๊อกหมูลงไป",
        "ตั้งหม้อจนร้อน (เลือกหม้อที่มีฝาปิดนะคะ) ใส่น้ำมันพืชลงไปพอร้อน ตามด้วยกระเทียม รากผักชี พริกไทย และขิง ผัดจนหอม",
        "ใส่หมูสามชั้นลงไปผัดจนสุกเกรียมทั้งสองด้าน เติมเหล้าจีนส่วนที่เหลืออีก 1 ช้อนโต๊ะ ตามด้วยน้ำมันงา เพื่อความหอม",
        "ใส่วุ้นเส้นลงไป วางทับด้วยกุ้งสด แล้วราดน้ำเครื่องปรุงที่ผสมไว้ลงไป ปิดฝา",
        "เมื่อน้ำงวดลงจนเกือบแห้ง เปิดฝาแล้วใส่ต้นหอมกับขึ้นฉ่ายลงไป ปิดฝากต่อสักครู่ เพื่อให้กุ้งอบวุ้นเส้นได้ความหอมของต้นหอม และขึ้นฉ่าย ยก “กุ้งอบวุ้นเส้น” ออกจากเตาไฟ เสิร์ฟพร้อมน้ำจิ้มซีฟู้ด"
      ],
      [
        "เตรียมส่วนผสมทั้งหมดให้พร้อม",
        "ตั้งกระทะเปิดไฟกลางค่อนไปทางอ่อน แบ่งกะทิใส่ลงไปเล็กน้อยแล้วใส่พริกแกงพะแนงลงไป",
        "ผัดไปเรื่อยๆ ค่อยๆเติมกะทิ ลงไปทีละน้อยๆ เพื่อดึงความมันของกระทิออกมา ผัดจนแตกมันส่งกลิ่นหอม สีสวย",
        "ใส่อกไก่ลงไป เติมน้ำตาล และตามด้วยน้ำปลา ผัดคลุกเคล้าจนเนื้อไก่สุกดี",
        "เบาไฟ เคี่ยวต่อไปอีกเล็กน้อย",
        "ตักใส่ชาม โรยด้วยพริกแดงและใบมะกรูด พร้อมเสิร์ฟ"
      ],
      [
        "นำขิง กระเทียม รากผักชี โขลกรวมกัน พอละเอียด ใส่ผงพะโล้ ผงซุป น้ำมันหอย คลุกให้เข้ากัน",
        "นำไปผัดในกระทะ ตั้งไฟอ่อน ใส่น้ำมัน",
        "นำเป็ดที่เตรียมไว้ ลงไปคลุกเครื่องหมักในกระทะ",
        "เอาเป็ดออกมาจากกระทะ และทาสีแดงทั้งตัว",
        "นำไปย่างด้วยเตา ย่าง แบบ อบไอน้ำเป็นเวลา 2 ชั่วโมง",
        "ได้เป็ดย่าง หอม หนังกรอบ",
        "จัดจานข้าว พร้อมเสิร์ฟ",
        "วิธีทำน้ำซอส น้ำน้ำหมัก เป็ด ข้างต้นมาเคี่ยวต่อ ใส่น้ำเปล่า เต้าเจี้ยว ปรุงรส ตามใจชอบเลย ไว้ราดเป็ด"
      ],
      [
        "นำไข่ไก่ตอกลงในชามผสม จากนั้นนำหมูสับใส่ลงไป ตามด้วยเครื่องปรุง น้ำมันหอย ซีอิ้วขาว ผงคนอร์ ลงไป จากนั้นใช้ส้อมตีให้ไข่เข้ากันจะได้ฟูดีค่ะ",
        "นำกระทะใส่น้ำมันลงไปจากนั้นพอเริ่มร้อนใส่ไข่เจียวหมูสับลงไปรอให้ไข่ด้านล่างสุกดี จากนั้นใช้ตะหลิวกลับอีกด้านหนึ่งขึ้นมารอให้สุกดีเช่นกัน",
        "พอสุกดีตักใส่จาน เสริฟกับข้าวสวยร้อนๆ"
      ],
      [
        "ใส่พริกกับกระเทียมลงในครกตำพอหยาบ จากนั้นฝานมะเขือเทศ ถั่วผักยาวตามลงตำให้พอเข้ากัน ปรุงรสด้วยน้ำปลา น้ำตาลปี๊บ และมะนาว",
        "ใส่เส้นมะละกอสับ ตำเคล้าให้เครื่องปรุงทั้งหมดเข้ากันดี ชิมรสชาติและปรุงเพิ่มได้ตามใจชอบ ตักใส่จานโรยด้วยกุ้งแห้งและถั่วลิสง"
      ],
      [
        "ตั้งไฟอ่อนใส่น้ำปลากับน้ำเปล่าที่เตรียมไว้ลงไป",
        "เติมน้ำตาลปี้บ แล้วคนให้น้ำตาลละลายเข้ากัน",
        "ใน้ำตาลละลายเข้ากันแล้วพักไว้ให้เย็น",
        "ตอกไข่ไก่สด เอาแต่ไข่แดง",
        "นำน้ำปลาที่พักไว้เย็นแล้วมา ตักไข่แดงใส่ลงไป ใส่พริกกับต้นหอมซอยลงไป",
        "คนเล็กน้อยปิดฝาเข้าแช่ตู้เย็น 24 ชัวโมง"
      ],
      [
        "นำหมูสามชั้น และ สะโพกหมู มาหั่นเป็นชิ้นเล็ก ๆ หมักด้วย ซีอิ้วขาว ซีอิ้วดำ ซีอิ้วดำหวาน น้ำตาลทราย และน้ำมันหอย คลุกให้เข้ากัน หมักไว้ 20 นาที",
        "ตั้งกระทะ ใส่น้ำมันให้ร้อน ใส่หอมแดงซอยลงไปผัดให้สลด ใส่น้ำตาลปี๊ปลงไปเคี่ยว จนเปลี่ยนเป็นสีน้ำตาลเข้มนำเนื้อหมูที่หมักไว้ ใส่ลงไปผัดให้เข้ากัน",
        "น้ำจากหมูจะค่อย ๆ ออกมา เคี่ยวจนน้ำคลุกคลิก ตักใส่ถ้วยจัดเสิร์ฟ หรือจะเสิร์ฟเป็นเครื่องเคียงข้าวคลุกกะปิก็ได้"
      ],
      [
        "นำสะโพกไก่มาหั่นให้เป็นชิ้นขนาดพอดีคำ นำหม้อขึ้นตั้งไฟแรง เทหัวกะทิลงใส่หม้อ",
        "นำตะไคร้ ข่าอ่อน และใบมะกรูด และเกลือ ลงต้มในหัวกะทิ รอให้เดือด นำเนื้อไก่ลงต้มในกะทิให้สุก",
        "ปรุงรสตามชอบ ปิดไฟแล้วบีบมะนาวเล็กน้อยแล้วตักเสิร์ฟ พร้อมข้าวร้อน ๆ"
      ],
      [
        "ตั้งกระทะ ใช้ไฟอ่อน ใส่เบคอนหั่นชิ้นลงไป ผัดไปเรื่อย ๆ จนน้ำมันเริ่มออก เจียวต่ออีกจนเบคอนเปลี่ยนเป็นสีน้ำตาลกรอบ แล้วตักออกพักไว้",
        "เทน้ำมันที่ได้จากเบคอนออก ให้เหลือไว้ในกระทะเล็กน้อย ใส่เนยเพิ่มเข้าไป สับกระเทียมให้ละเอียด แล้วใส่ละไปผัดให้เหลืองหอมใส่ข้าวตามลงไปผัดให้เข้ากับกระเทียม ปรุงรสด้วยโชยุ น้ำตาล เกลือ พริกไทย คลุกเคล้าให้รสชาติกระจายทั่ว ปิดไฟ ใส่ต้นหอมซอย คลุกให้เข้ากันอีกครั้ง",
        "ตักข้าวผัดใส่ถ้วย ท๊อปปิ้งด้วยเบคอนกรอบ"
      ],
      [
        "นำผักโขมมาสับหยาบ หั่นครึ่งหัวหอม แบ่งซอยบาง ๆ และหั่นเต๋าเล็ก อย่างละครึ่ง จากนั้นซอยกระเทียมเตรียมไว้",
        "ต้มนมกับหัวหอมซอยและกระเทียมให้เดือดจนหัวหอมสุกแล้วพักไว้ ตั้งกระทะให้ร้อนใส่เนยลงไปละลาย แล้วใส่แป้งลงไปผัดให้สุก กรองนมร้อนใส่ลงไปแล้วคนให้เข้ากัน จากนั้นปรุงรสด้วยเกลือและพริกไทย",
        "ตั้งกระทะให้ร้อน ใส่หัวหอมลงไปผัดให้เริ่มสุก ใส่กระเทียมตามลงไปผัดให้เหลืองสวย และใส่ผักโขมลงไปผัดให้สุก ปรุงรสด้วยเกลือและพริกไทยใส่ครีมซอสที่เตรียมไว้ลงไปผัดให้เข้ากัน เทผักโขมที่ผัดแล้วใส่จานอบ แล้วโรยมอสซาเรลล่าชีสให้ทั่วแล้วนำไปอบจนเหลืองสวย"
      ],
      [
        "ตั้งน้ำใส่เกลือเล็กน้อย รอจนเดือด กรีดผิวมันฝรั่งก่อนลงต้ม เพื่อให้ปอกเปลือกได้ง่ายขึ้น เมื่อมันฝรั่งสุกนำขึ้นจากหม้อ แล้วแช่น้ำให้พอหายร้อน เมื่อมันฝรั่งหายร้อนแล้ว ใช้มือรูดเปลือกออก หั่นให้เป็นชิ้นเต๋า",
        "ใช้ส้อมหรือที่บด บดมันฝรั่งให้ละเอียดใส่วิปปิงครีม เนย นมข้นจืด ปรุงรสด้วยเกลือ และพริกไทย คนตะล่อมให้ทุกอย่างเข้ากัน",
        "ตักใส่ถ้วยจัดเสิร์ฟ ราดด้วยเกรวี่ตามชอบ โรยพาร์สลีย์สับเล็กน้อย เป็นอันพร้อมรับประทาน"
      ],
      [
        "ล้างเห็ดแชมปิญองให้สะอาด แล้วหั่นเป็นชิ้นบางๆ ประมาณ 8-10 ดอก",
        "ตั้งหม้อด้วยไฟอ่อนๆ ใส่เนยลงไป จากนั้น นำหอมใหญ่ และ เห็ดทั้งหมดที่หั่นเตรียมไว้ลงไปผัดประมาณ 2-3 นาที",
        "นำแป้งข้าวโพดผสมน้ำอุณภูมิห้องประมาณ 1/4 ถ้วยตวง แล้วเทผสมลงไปผัดกับเห็ดและเนยด้วยไฟอ่อน",
        "เติมน้ำซุปที่เตรียมไว้ลงไป จากนั้นเร่งไฟปานกลางประมาณ 3 นาที คนจนน้ำเริ่มข้น",
        "เติมครีมลงไป 1 ถ้วยตวง จากนั้นลดไฟอ่อน ค่อยๆ คนจนน้ำซุป และเห็ด เป็นเนื้อเดียวกัน และเริ่มส่งกลิ่นหอม ซึ่งใช้เวลาราวๆ 3-5 นาที",
        "โรยเกลือ พริกไทย ตักใส่ชาม แล้วเสิร์ฟพร้อมขนมปังได้เลย"
      ],
      [
        "ผสมเครื่องเทศทุกอย่างเข้าด้วยกัน เพื่อทำ dry rub",
        "นวดเครื่องเทศทุกอย่างลงบนหมู",
        "ห่อหมูแต่ละชิ้น ด้วยกระดาษ foil ซ้อนกันสองแผ่น ประกบกันและม้วนขอบให้เป็นลักษณะของ pocket (เป็นการทำถุงความร้อนให้อบหมูอย่างชุ่มฉ่ำเวลาเอาเข้าเตาอบ)",
        "ใส่หมูเข้าเตาอบที่ 135 องศา C เป็นเวลาอย่างน้อย 2.30 ชั่วโมง (ซึ่งนุ่มทานได้แล้ว แต่เราจะทับด้วยซอสบาร์บีคิวอีกรอบ)",
        "Glaze (ทาหมู) ด้วยซอสบาร์บีควิให้ชุ่มฉ่ำ ปรับอุณหภูมิเตาอบเป็นสูงสุด (สัก 250 องศา)   นำหมูเข้าไปอบเพื่อให้ได้รอยไหม้ (caramelized) ของซอสบาร์บีคิวอีกด้านละ 3-5 นาที",
        "เสิร์ฟคู่กับซอสบาร์บีคิวที่เหลือ และมันอบหรือโควสลอว์"
      ],
      [
        " เตรียมผักสลัดต่างๆ ตามชอบ ล้างให้สะอาด จัดใส่จานแล้วใส่ตู้เย็นไว้",
        " ส่วนผสมของน้ำสลัดต่างๆ ยกเว้นเกลือและพริกไทย ปั่นในเครื่องปั่น จนได้ส่วนผสมที่มีลักษณะเป็นเนื้อครีม",
        "เก็บใส่ภาชนะ ที่มีฝาปิด แล้วเก็บใส่ตู้เย็นสักพัก จากนั้นเตรียมผักสลัด ราดด้วยน้ำสลัด โรยด้วยพาร์เมซานชีสขูด"
      ],
      [
        "ตั้งหม้อต้มน้ำให้เดือดพร้อมทั้งใส่เกลือ และน้ำมันมะกอก แล้วใส่เส้นสปาเกตตีลงไป คนให้เส้นจมน้ำหมดทุกเส้น หรี่ไฟอ่อนพร้อมปิดฝา ต้มประมาณ 10 นาที แล้วเช็กเส้น จากนั้นนำเส้นสปาเกตตีต้มสุกแช่น้ำเย็นสักครู่ สะเด็ดน้ำออกนำไปคลุกกับน้ำมันพืช เพื่อไม่ให้เส้นเหนียวติดกัน แล้วพักไว้",
        "นำคุกกิ้งครีม ชีสพาร์เมซานขูดฝอย และพริกไทยผสมลงในถ้วย คนให้เข้ากัน นำกระทะตั้งไฟกลาง ใส่เบคอนลงไปทอดจนเกรียม จากนั้นใส่เนยลงไป ตามด้วยกระเทียม และหอมใหญ่ลงไปผัดให้จนส่งกลิ่นหอม จากนั้นใส่สปาเกตตีลงไปผัดกับส่วนผสมต่างๆ ตามด้วยคุกกิ้งครีม ผัดให้เข้ากันดีจากนั้นปิดไฟ และใส่ไข่แดงลงไป คนเร็ว ๆ ให้ไข่แดงเข้ากับเส้น",
        "จัดเสิร์ฟ “สปาเกตตีคาร์โบนาราครีมซอส” ลงในจาน จากนั้นโรยชีสพาร์เมซาน และเบคอนทอดกรอบลงไป ตกแต่งหน้าด้วยใบพาร์สลีย์"
      ],
      [
        "ตั้งกระทะ แล้วนำเนื้อสันในไปจี่รอบด้านหลัง จากนั้นนำขึ้นมาพัก พักให้เนื้อเย็นลงเล็กน้อย แล้วแล้วทาด้วยมัสดาร์ดให้ทั่ว กางฟิล์มห่ออาหารลงบนพื้นผิวเรียบ หรือเขียง แล้วจึงนำเบคอน วางเรียงแนวตั้งเข้าหาตัวให้ซ้อนกัน ประมาณ 1 ซม. หลังจากนั้นทาด้วยเห็ดบด",
        "นำเนื้อที่ย่างเตรียมไว้ มาวางบนเบคอนตรงกลาง แล้วจึงดึงแผ่นฟิล์มขึ้นจากด้านที่ใกล้ตัวแล้วม้วนขึ้นไปด้านบนห่างจากตัว หลังจากนั้นจัดระเบียบห่อให้สวยงาม นำไปแช่ตู้เย็นเพื่อให้เซทตัวประมาณ 15 นาที นำแป้งพาย ออกมาคลายความเย็น 1 นาที แล้วทาเนยลงบนผิวหน้า หลังจากนั้นเนื้อที่ห่อเบคอน มาวางตรงจุดศูนย์กลาง พับม้วน ห่อให้สวยงามและทาด้วยไข่แดงโรยเกลือเล็กน้อยด้านบน บั้งทำลวดลายเพื่อความสวยงาม และนำเข้าเตาอบ อุณหภูมิ 200 องศาเซลเซียส 15-20 นาที",
        "นำซอสไวน์แดงมาอุ่นให้ร้อนได้ที่สำหรับเป็นซอสทานพร้อมกับ beef wellington"
      ],
      [
        "หั่นสันในหมูเป็นชิ้นพอดีคำเตรียมไว้",
        "ผสมแป้งทอดกรอบ เกลือป่น และพริกไทยป่น คนให้เข้ากัน แล้วใส่สันในหมูที่หั่นไว้ลงไปคลุกแป้งบาง ๆ จากนั้นนำไปทอดจนเหลืองกรอบ ตักขึ้นสะเด็ดน้ำมัน",
        "ใส่น้ำมันพืชลงในกระทะ พอน้ำมันร้อนใส่กระเทียมลงผัดจนหอม ใส่หอมใหญ่ พริกหวานทั้งสองสี และสับปะรดลงผัดจนสุก",
        "ปรุงรสด้วยซอสมะเขือเทศ น้ำตาลทราย และซีอิ๊วขาว ผัดให้เข้ากัน จากนั้นใส่หมูทอดที่พักไว้ลงผัดให้เข้ากันอีกครั้ง ตักใส่จานที่เตรียมไว้"
      ],
      [
        "นำน้ำมันรำข้าวใส่ลงไปในกระทะเล็กน้อย เปิดไฟปานกลาง แล้วใส่รากผักชี  กระเทียม และพริกไทยดำที่ตำเตรียมไว้ลงไปผัดให้หอม",
        "ใส่หมูบดลงไปผัดจนหมูบดสุกแล้วใส่วุ้นเส้นและเห็นหูหนูซอยตามลงไปผัดให้เข้ากัน",
        "ปรุงรสด้วยซอสหอยนางรม ซอสปรุงรส และน้ำตาลทราย ผัดจนส่วนผสมทั้งหมดเข้ากันดี",
        "จากนั้นก็ใส่ผักที่เตรียมไว้ เช่น กะหล่ำปลี แครอท และถั่วงอก ผัดให้ทุกอย่างเข้ากันแล้วตักใส่จานวางพักไว้",
        "เตรียมแป้งโรตี โดยแผ่แผ่นแป้งแล้วใส่ไส้ที่เราผัดเตรียมไว้ลงไป เกลี่ยให้อยู่ริมขอบของแป้ง แล้วจัดการม้วนปิดทุกด้านเพื่อไม่ให้ไส้ไหลออกมา และส่วนของแผ่นแป้งที่จะประกบด้านสุดท้าย ให้ทาไข่ขาวเพื่อเป็นกาวเชื่อมติดกัน",
        "ตั้งกระทะใส่น้ำมันให้ท่วม รอให้น้ำมันร้อนแล้วใส่ปอเปี๊ยะลงไปทอดให้เหลืองกรอบ",
        "ตักขึ้นมาสะเด็ดน้ำมันแล้วเสิร์ฟคู่กับน้ำจิ้มหวานหรือน้ำจิ้มบ๊วย"
      ],
      [
        "โขลกกระเทียม พริกไทยขาวเม็ด และรากผักชี เข้าด้วยกันจนละเอียด ใส่กุ้งสับลงในชามผสม ตามด้วยหมูสับ กระเทียม พริกไทยขาวเม็ด และรากผักชีที่โขลกไว้ ซอสปรุงรส น้ำมันงา น้ำตาลทราย ซอสหอยนางรมและไข่ไก่ จากนั้นคนให้เข้ากัน"
            "ตักไส้วางลงบนแผ่นเกี๊ยวประมาณ 1 ช้อนชา และห่อให้สวยงาม ทำแบบเดียวกันจนครบ นำไปต้มในน้ำเดือดจัด และตักออกใส่ชาม",
        "นำหม้อขึ้นตั้งไฟปานกลาง เทน้ำซุปกระดูกหมูลงไป และรอจนเดือด ใส่ผักกวางตุ้ง และต้มจนสุก เทใส่ถ้วยเกี๊ยวที่เตรียมไว้ และโรยต้นหอมซอย พร้อมเสิร์ฟ"
      ],
      [
        "นำกระทะขึ้นตั้งไฟปานกลาง เทน้ำมันพืชลงไป ตามด้วยหอมหัวใหญ่ผัดจนหอม",
        "ใส่เหล้าจีนลงไป ตามด้วยกุ้งสดและผัดจนสุก",
        "ใส่แครอท กะหล่ำปลี ดอกไม้จีน เห็ดหูหนู ผัดแป๊ปเดียวพอค่ะ จากนั้นผัดวุ้นเส้น คลุกเคล้าให้เข้ากัน เติมน้ำเปล่า รอจนวุ้นเส้นสุกและน้ำงวด",
        "จากนั้นเริ่มปรุงรสชาติด้วยน้ำปลา น้ำตาลทรายและซอสหอยนางรม",
        "โรยต้นหอมและขึ้นฉ่ายตักใส่จาน"
      ],
      [
        "เตรียมเครื่องบดสับ ใส่เนื้อหมูสับลงไปปั่นให้ละเอียด ใส่ไข่ไก่ แป้งมัน กระเทียมสับ หอมแดงสับ พริกไทยป่น น้ำตาลทราย ซีอิ๊วขาวเห็ดหอม น้ำมันหอย น้ำมันงา ปั่นให้ละเอียดเข้ากันดี ใส่แครอทสับ ต้นหอมซอย ผสมพอเข้ากัน แล้วตักพักไว้ในตู้เย็นประมาณ 10-20 นาที ถ้าอยากให้เหนียวหนึบขึ้นให้นวดด้วยมืออีกรอบก่อนห่อขนมจีบ",
        "นำแผ่นแป้งมาตัดมุมให้เป็นวงกลมตามคลิป เตรียมถาดวางขนมจีบ รองด้วยใบตอง ทาน้ำมันที่ได้จากการเจียวกระเทียม ทาลงบางๆ ให้ทั่ว",
        "นำเอาแผ่นแป้งทาขอบขนมจีบตามคลิป หรือให้ลองจุ่มน้ำก่อนถ้าหากขาดให้ทาตามคลิป แล้วจึงตักไส้ใส่ลงไปลงกลาง จับให้เป็นจีบ เป็นคำๆ วางเรียงใส่ถาดไว้ก่อน",
        "เตรียมซึ้งรองด้วยใบตอง แล้วทาใบตองด้วยน้ำมันที่ได้จากการเจียวกระเทียม",
        "นำขนมจีบมาเรียงเว้นให้มีระยะห่าง เพื่อทำให้สุกทั่วถึง แล้วนึ่งขนมจีบประมาณ 5-10 นาที ทาน้ำมันเจียวกระเทียมให้ทั่วๆ แล้วนึ่งต่ออีก 1 นาที",
        "ขนมจีบหมูสับเสร็จเรียบร้อยจัดใส่จาน โรยกระเทียมเจียวกรอบๆ เสิร์ฟพร้อมน้ำจิ้ม จิ๊กโฉ่ว ผักสดผักชี ผักกาดหอม"
      ],
      [
        "ทำการล้างเป็ดสดให้สะอาด เอาเครื่องในออก เสร็จแล้วแขวนผึ่งลมไว้ค่ะ",
        "ตั้งหม้อใบใหญ่ ๆ ที่ใส่เป็ดได้ต้มน้ำให้เดือด ใส่น้ำตาลปี๊บ ซีอิ๊วขาว ซีอิ๊วหวาน น้ำมันหอย ซอสปรุงรส และเหล้าจีนลงไป",
        "ตามด้วยพริกไทยดำ อบเชย โป๊ยกั๊ก ข่า กระเทียม รากผักชี และเครื่องพะโล้ จากนั้นคนให้เข้ากัน เคี่ยวทิ้งไว้ 1 ชั่วโมง ให้กลิ่นของเครื่องเทศออกมา",
        "หลังจากนั้นนำเป็ดที่ล้างสะอาดแล้วมาใส่หม้อ โดยจับเป็ดหงายลงไปนะคะ ใช้เวลา 20 นาที หลังจากนั้นกลับตัวเป็ดเอาอีกด้านลง ต้มต่ออีก 20 นาทีค่ะ",
        "เคี่ยวต่อไปโดยใช้ไฟอ่อน อีกประมาณ 2 ชั่วโมง เสร็จแล้วนำขึ้นผึ่งไว้ค่ะ",
        "ทำการกรองเครื่องพะโล้ออกจากน้ำต้มเป็ดค่ะ น้ำที่เหลือจะนำไปราดเป็ด หรือจะทำเป็นก๋วยเตี๋ยวเป็ดก็เข้าท่าเลยค่ะ TIP ระหว่างต้มพยายามกดเป็ดให้จมน้ำนะคะ เป็ดจะได้สุกทั่วถึงกันคะ",
        "วิธีทำน้ำจิ้มเป็ดพะโล้ โดยโขลกพริกและกระเทียมเข้าด้วยกัน ปรุงรสด้วยเกลือ น้ำส้มสายชู และน้ำตาลทรายแดง คนให้เข้ากัน ชิมรสได้ตามชอบเลยค่ะ",
        "เมื่อเป็ดหายร้อนแล้ว ทำการสับเป็ดได้เลยค่ะ จัดใส่จานให้สวยงาม ตกแต่ด้วยผักชี พร้อมเสิร์ฟได้แล้วจ้า"
      ],
      [
        "ผสมหมูสับ พริกไทยป่น ซีอิ๊วขาว น้ำปลา คลุกเคล้าพอเข้ากัน",
        "ต้มน้ำเปล่า ใส่กระเทียม คนอร์ก้อน พอเดือด ปั้นหมูสับที่หมักไว้เป็นก้อนกลมลงต้มพอสุก ใส่เกลือป่น คอยช้อนฟองออก",
        "ปรุงรสด้วยน้ำปลา คนให้เข้ากัน ใส่ผักกาดขาว ใส่เต้าหู้ไข่ โรยด้วนคื่นฉ่าย",
        "ตักใส่ชามโรยด้วยพริกไทย"
      ],
      [
        "หั่นปลาแซลม่อนเป็นลูกเต๋า พักไว้แล้วไปเตรียมน้ำยำ",
        "ตำพริกขี้หนูกับกระเทียมให้แหลก ปรุงรสด้วยน้ำมะนาว น้ำปลาและน้ำตาลทราย",
        "ใบมะกรูด ตะไคร้ และหอมแดง ที่ซอยทิ้งไว้ใส่ลงไปในชามผสม ตักน้ำยำลงไปผสมด้วยแล้วคลุกเคล้าให้เข้ากันพร้อมชิมรส",
        "เมื่อได้รสชาติที่ต้องการแล้วให้ใส่ปลาแซลมอนลงไปได้เลย คลุกเคล้าอย่างเบามือ",
        "จัดผักกาดแก้วเรียงใส่จาน ตักยำปลาแซลมอนลงไป โรยด้วยใบโหระพาตบท้าย แค่นี้ก็เป็นเสร็จ"
      ],
      [
        "นำหมูสามชั้นไปต้มในน้ำเดือดที่เติมเกลือ 15-20 นาที ตักขึ้นพักไว้",
        "นำส้อมมาจิ้มที่หนังหมูจนทั่ว ทาหนังหมูด้วยน้ำส้มสายชู และทาเกลือเพื่อเพิ่มรสชาติให้ชิ้นหมูจนทั่วทั้งชิ้น",
        "ผึ่งหมูให้แห้งแล้วนำไปอบที่อุณหภูมิ 200 องศาเซลเซียส เป็นเวลา 30 นาที",
        "นำด้านที่เป็นหนังหมู จุ่มลงในน้ำมันที่ร้อนแล้วให้หนังพองสวยงาม นำไปหั่นเป็นชิ้นสำหรับผัด",
        "ตำพริกขี้หนูกับกระเทียมให้ละเอียด นำไปผัดกับน้ำมันพร้อมก้านคะน้า คนให้เข้ากัน",
        "ใส่ใบคะน้า ปรุงรสด้วยเต้าเจี้ยว น้ำมันหอย ซอสปรุงรส น้ำตาลทราย น้ำเปล่า ผัดให้เข้ากัน ใส่หมูกรอบ ผัดพอเข้ากัน ปิดไฟ นำไปทานกับข้าวสวยร้อน ๆ และไข่ดาว"
      ],
      [
        "ใส่สน้ำมันเล็กน้อย ผัดกระเทียมจนหอม ใส่หมูลงไปผัดให้พอขลุกขลิก",
        "ปรุงรสด้วยซอสหอยนางรม ซีอิ๊วขาว น้ำตาลทราย พริกป่น และพริกไทยดำ ผัดต่อจนเครื่องปรุงเข้าเนื้อหมู จากนั้นก็ตักใส่จานเสิร์ฟ โดรยด้วยผักชี หรือจะตักราดข้าวพร้อมกับไข่ดาวกรอบๆ ตามชอบเลยค่ะ"
      ],
      [
        "หั่นหมูเป็นชิ้นพอดีคำ คลุกกับผงฟู พริกไทย และซีอิ๊วขาวเล็กน้อย หมักทิ้งไว้หั่นคะน้าเป็นท่อน ๆ TIP : อย่าใส่ผงฟูเยอะเกิน เพราะจะทำให้เกิดรสเฝื่อน",
        "ตั้งกระทะให้ร้อน ใส่น้ำมันพืชลงไปเล็กน้อย ใส่กระเทียมสับลงไปเจียวจนสุกเหลือง และมีกลิ่นหอม จากนั้นให้เร่งไฟขึ้น และใส่เนื้อหมูลงไปผัดจนสุกปรุงรสด้วย ซีอิ๊วดำ น้ำมันหอย และซีอิ๊วขาว ผัดให้ส่วนผสมเข้ากัน แล้วจึงใส่เส้นใหญ่ลงไปผัดแบ่งส่วนผสมทั้งหมดไปไว้ข้างหนึ่งของกระทะ แล้วตอกไข่ลงไป ใช้ตะหลิวตีไข่เบา ๆ ให้พอเข้ากัน พอเห็นว่าไข่เริ่มสุก ก็ยกเส้นขึ้นมากลบไข่ ใส่คะน้าแล้วผัดให้สุกทั่วกัน TIP : ผัดเส้นให้เกรียมนิด ๆ ช่วยเพิ่มกลิ่นหอม และ เนื้อสัมผัสให้กับเส้นใหญ่ ",
        "ตักใส่จานเสิร์ฟ อาจจะเสิร์ฟคู่กับ พริกน้ำส้ม พริกป่น น้ำปลา น้ำตาล ให้ปรุงเพิ่มกันตามใจชอบ เพียงเท่านี้เราก็มีเมนู “ผัดซีอิ๊วหมู” เด็ด ๆ ไว้กินกันแล้ว!"
      ],
      [
        "ทำกระทงโดยใช้ใบตองผึ่งแดดให้นิ่ม นำมาตัดเป็นวงกลมเส้นผ่านศูนย์กลางประมาณ 6 นิ้ว พับมุมใบตองให้เป็นกระทง 3 หรือ 4 มุม กลัดด้วยไม้กลัดหรือแม็ค",
        "นำผักกาดขาวมาล้างให้สะอาด แกะใบรองก้นกระทง",
        "ทำตัวห่อหมกโดยผสมพริกแกงไข่ไก่และเนื้อปลาขูด ปรุงรสด้วยน้ำตาลปี๊บ น้ำปลา คนให้เข้ากัน ค่อยๆเติมกะทิทีละน้อย สลับกับคนให้เข้ากัน จนกระทั่งกะทิหมด ใส่ใบมะกรูดซอย ใส่เนื้อปลาช่อนที่หั่นเป็นชิ้น คนให้เข้ากันอีกครั้ง",
        "ตักห่อหมกใส่ลงไปให้พอดีกระทง นำลงนึ่งในซึ้งใช้ไฟกลาง-อ่อน ประมาณ 20นาที",
        "ทำกะทิหยอดหน้าห่อหมกโดยนำหัวกะทิผสมกับแป้งข้าวโพด คนให้แป้งละลาย นำไปตั้งไฟคนจนกระทั่งกะทิข้นขึ้น",
        "ตักกะทิหยอดหน้าห่อหมกที่นึ่งสุกแล้ว ตกแต่งด้วยใบมะกรูดซอยและพริกชี้ฟ้าแดงซอย"
      ],
      [
        "เริ่มจากทอดปลาจนกรอบเตรียมไว้ จะใช้ปลาชนิดใดก็ได้ตามที่มีหรือชอบ ทำความสะอาดคลุกเคล้าเกลือดับคาวเล็กน้อยแล้วทอดด้วยไฟกลางจนเหลืองกรอบ หรือบ้านไหนมีปลาทอดเหลือจากมื้อเก่า ๆ ก็นำมาทำฉู่ฉี่ได้เช่นกัน",
        "หั่นนำผักชีใบเลื่อยเป็นฝอยเล็ก ๆ เตรียมไว้ สำหรับใช้ใส่ช่วงท้ายและโรยหน้า จะเห็นว่าสูตรนี้ไม่ใส่ใบมะกรูดหั่นฝอยเพื่อหลีกเลี่ยงรสขมและอาศัยความหอมเฉพาะเครื่องแกง",
        "นำพริกแกงเผ็ดลงไปผัดในกระทะที่ตั้งน้ำมันไว้ร้อนแล้ว ผัดจนมีกลิ่นหอมฉุน  จากนั้นปรุงรสด้วยน้ำปลา",
        "เติมน้ำลงเล็กน้อยเพื่อป้องกันพริกแกงไหม้ก็พอ ใส่น้ำตาลทรายแล้วผัดผสมให้เข้ากัน",
        "จากนั้นนำปลาทอดลงไปคลุกเคล้า ผัดให้เข้ากันขณะตั้งไฟอยู่ คนเบา ๆ รักษาตัวปลา",
        "โรยผักชีใบเลื่อยลงไป คนผสมให้เข้ากัน เป็นอันเสร็จเรียบร้อย พร้อมเสิร์ฟบนจาน โรยหน้าผักชีและพริกชี้ฟ้าแดงอีกหน่อย"
      ],
      [
        "สับกระเทียมพร้อมแกะหนำเลี๊ยบเอาแต่ส่วนเนื้อ",
        "ผสมหมูสับกับหนำเลี๊ยบที่ยีจนละเอียด ตามด้วยซีอิ๊วขาว, น้ำมันหอย, และพริกไทยป่น พักไว้ซักครู่",
        "ตั้งกระทะ เจียวกระเทียมในน้ำมันบางส่วนจนเหลืองกรอบ ตักขึ้น ส่วนกระเทียมที่เหลือจะนำไปผัดกับหมูสับ",
        "ผัดหมูสับในกระทะ ใช้ไฟกลาง ปรุงรสด้วยน้ำตาลทรายและผงปรุงรส",
        "ผัดไปเรื่อยๆ จนหมูสุกทั่วกัน ลองชิมรส ขาดรสอะไร สามารถปรับได้ ปรับไฟเป็นแรงสุด ทิ้งหมูไว้ในกระทะซักครู่ให้ตรงผิวเกรียมเล็กน้อย คั่วต่อไปจนแห้ง ปิดไฟ",
        "ตักขึ้นใส่จาน โรยกระเทียมเจียว จัดเสริฟกับพริกขี้หนู, มะนาว, และหอมแดง"
      ],
      [
        "เอาวุ้นเส้น แช่น้ำ และหั่นผักต่างๆ แล้วเอาแครอท ไปต้มซัก 3 นาทีให้สุกครึ่งเดียว เคล็ดลับ: หั่นแบบที่เราชอบกิน ไม่ใหญ่ไม่เล็กไป",
        "ใส่น้ำมัน 1 ชต เจียว กระเทียมพอหอม ใส่หมู ลูกชิ้นปลาลง พอหมูพอสุก ใส่ผักกาด ผักบุ้ง แครอท ลงไปผัดต่อ เคล็ดลับ: หมู จะหมักก่อน หรือไม่หมักก็ได้ ถ้าหมักๆด้วย ซอสปรุงรสและ น้ำมันหอย ทิ้งไว้ 15 นาที",
        "ผักใกล้สุก ใส่วุ้นเส้นลงไป พอวุ้นเส้นใกล้สุก ใส่ไข่ตามลงไป ผักต่ออีกซักพัก แล้ว ใส่ซอสสุกี้ ซอสปรุงรส พริกสด",
        "ผัดต่อเปนอันเสรจ ตอนเสริฟจะบีบมะนาวใส่ หรือไม่ใส่ก็ได้"
      ],
      [
        "เทกะทิประมาณ 100 มล. ลงกระทะ ตั้งไฟอ่อนถึงปานกลาง จนกะทิเดือด แล้วใส่พริกแกงพะแนง เคล็ดลับ: พริกแกงพะแนงใช้ตราน้ำใจ 1 ช้อนโต๊ะพูนๆ",
        "ผัดพริกแกงกับกะทิจนละลายเข้ากันดี จากนั้นใส่สันคอหมูสไลด์หั่นชิ้นลงไปผัด เคล็ดลับ: เลือกสันคอหมูมาทำเพราะเนื้อนุ่มอร่อย มีมันแทรกไม่เยอะเกินไป",
        "นำใบมะกรูด 2 ใบกรีดแกนกลางออกฉีกและขยี้ใบมะกรูดด้วยมือและใส่ลงผัดพร้อมหมู เคล็ดลับ: ขยี้ใบมะกรูดด้วยมือ จะหอมกว่าใช้มีดหั่น",
        "เมื่อผัดเนื้อหมูเกือบสุก ลดไฟเป็นไฟอ่อน ปรุงรสด้วยน้ำปลา",
        "เติมน้ำตาลมะพร้าว และผัดให้น้ำตาลละลาย",
        "ใส่มะเขือพวงลงผัด เริ่มเปิดเตาไฟปานกลาง ผัดมะเขือพวง กับหมูและเครื่องแกงให้เข้ากัน",
        "เติมกะทิ 150 มล หรือส่วนที่เหลือลงกะทะ ใช้ตะหลิวผัดทุกอย่างให้เข้ากัน",
        "รอจนกะทิเดือด ปิดไฟ ตักใส่ชาม โรยหน้าด้วยใบมะกรูดซอย และยกเสิร์ฟ เคล็ดลับ: หากต้องการเพิ่มความเผ็ดให้ซอยพริกชี้ฟ้าเป็นเส้นๆ โรยหน้า"
      ],
      [
        "ตอกไข่ลงในชามผสม ตามด้วยน้ำตาล เกลือ และน้ำเปล่าตีส่วนผสมให้เข้ากันอย่าให้เหลือเศษไข่",
        "นำกระทะตั้งไฟโดยใช้ไฟกลาง พอกระทะร้อนใช้กระดาษทิชชู่ชุบน้ำมัน ทาให้ทั่วกระทะ ตักไข่ลงไป 2 ทัพพีเล็ก กลิ้งไข่ให้บางเต็มกระทะ พอไข่ด้านข้างเริ่มแข็ง ตรงกลางสุกนิดหน่อย ให้เราหรี่ไฟให้อ่อน และใช่ตะเกียบแซะไข่ แล้วค่อย ๆ ม้วนตะล่อมจนถึงฝั่งตรงข้าม",
        "นำทิชชู่ชุบน้ำมันทาบาง ๆ บนกระทะอีกครั้ง เร่งไฟขึ้นให้เป็นไฟกลาง ทำทุก ๆ ขั้นตอนเหมือนเดิมจนไข่หมด",
        "พอไข่สุกปิดไฟแล้วนำไข่มาจัดทรง โดยใช้ไม้ไผ่สำหรับม้วนซูชิจัดทรงให้สวย รอไข่เย็นตัวลงก่อนค่อนหั่นชิ้น",
        "เมื่อไข่เย็นตัวลงให้หั่นชิ้นพอดีคำ จากนั้นเรียงไข่ใส่จานที่ต้องการจัดเสิร์ฟ เสิร์ฟพร้อมโชยุ"
      ],
      [
        "นำขิงบด น้ำตาลทราย ผงดาชิ สาเก มิริน โชวยุ และน้ำเปล่า มาเทรวมกันไว้ในถ้วย คนผสมให้เข้ากัน พักไว้",
        "ใส่หอมหัวใหญ่กับน้ำมันพืชลงในกระทะแล้วเปิดไฟแรงผัดจนหอมหัวใหญ่เริ่มสลด",
        "ใส่เนื้อวัวลงไปผัดแค่พอสุก",
        "เทส่วนผสมน้ำปรุงในข้อที่ 1 ลงไป พอน้ำเดือดก็ปรับเป็นไฟกลาง รอให้น้ำงวดลงครึ่งหนึ่ง",
        "ระหว่างรอน้ำงวด ให้นำเส้นชิราตากิไปต้มแล้วนำมาล้างเพื่อดับกลิ่นคาว จากนั้นจึงใช้มีดหั่นครึ่ง เพื่อให้เส้นไม่ยาวจนเกินไป (ถ้าไม่ต้มก็ให้ล้างหลาย ๆ น้ำ)",
        "ใส่เส้นชิราตากิลงในกระทะ ผัดจนน้ำเริ่มงวดอีกสักนิดเป็นอันเสร็จ"
      ],
      [
        "นำกระทะตั้งไฟ ใส่น้ำมันพอน้ำมันร้อนใส่กระเทียมลงไปผัดพอส่งกลิ่นหอม ใส่เนื้อไก่ลงไปผัดพอสุก ใส่เห็ดหอมลงไปผัด ตามด้วยแครอทและกระหล่ำปลี คนเคล้าส่วนผสมให้เข้ากัน ผัดผัดพอสลด ใส่เส้นยากิโซบะ/เส้นหมี่ฮ๊กเกี้ยนลงไป ปรุงรสด้วย ซอสปรุงรส/ซีอิ้วขาว+ซอสหอยนางรม+พริกไทยป่น+น้ำตาลทราย+ซีอิ้วดำ คนเคล้าส่วนผสมให้เข้ากัน ชิมรสชาติเพิ่มเติมได้ตามชอบ จากนั้นใส่ต้นหอมลงไป คลุกเคล้าส่วนผสมให้เข้ากันอีกครั้ง ปิดเตา พร้อมเสริฟ เคล็ดลับ: ตั้งกระทะนำหม้อนึ่งตั้งไฟ พอน้ำเดือดร้อนได้ที่ นำเส้นลงไปนึ่งเป็นเวลา 5 - 6 นาที (นึ่งเพื่อเวลาผัดเส้นเหนียวนุ่ม ไม่เละ ไม่หัก)"
      ],
      [
        "นำสันนอกหมูมาทุบให้มีความหนาประมาณ 0.5 เซนติเมตร",
        "ปรุงรสด้วยเกลือพริกไทย พักไว้ประมาณ 15 - 30 นาที",
        "นำหมูที่ปรุงรสมาคลุกกับแป้งสาลีอเนกประสงค์ ไข่ และเกล็ดขนมปังตามลำดับ",
        "นำลงทอดในน้ำมันร้อน ไฟกลาง ให้สุกกรอบ",
        "หั่นชิ้นหมูให้มีความหนาพอดี จัดเรียงใส่จานพร้อมกะหล่ำปลีซอย และเลมอนหั่นชิ้นจากนั้นราดด้วย คิคโคแมน เทสตี้ เจแปน ซอสทงคัตสึ ให้สวยงามพร้อมเสิร์ฟ"
      ],
      [
        "ปลาซาบะบั้งด้านหนังเเล้วเอาลงเตาที่ทาเนยไว้",
        "ใส่ซอสเทอริยากิ เเละน้ำมันงาเพิ่มความหอมลงไปเเล้วเติมน้ำเปล่าลงไปด้วยนิดหน่อย เปิดไฟกลางๆ เคล็ดลับ: *อย่าใช้ไฟเเรงนะคะ ระวังซอสไหม้ **ใส่น้ำลงไปด้วยซอสจะได้ไม่ไหม้ง่ายก่อนปลาจะสุก",
        "ค่อยๆกับด้านปลาจนสุกทั้งสองด้าน รอให้ปลาขึ้นสีสวยเเละซอสจะข้นขึ้นด้วย เติมซอสได้ค่ะตามชอบ",
        "ทานคู่เเครอท กระหล่ำปลีผัด"
      ],
      [
        "นำหมูบด กระเทียมสับ หอมใหญ่สับ กะหล่ำปลีสับ ใบกุยช่ายซอย ต้นหอมซอย ขิงขูด แป้งมัน โชยุ น้ำมันงา น้ำตาลทราย เทใส่ชามผสม แล้วคนให้เข้ากัน",
        "นำแผ่นเกี๊ยวซ่าวางไว้บนมือ ใช้ไม้พายหรือช้อนเล็ก ๆ ตักไส้วางกลางแผ่นเกี๊ยวซ่า เอาน้ำลูบบริเวณขอบเล็กน้อย พับแผ่นเกี๊ยวซ่าอีกด้านทบขึ้นมา ค่อย ๆ จับจีบทั้งสองด้านเข้าตรงกลาง ให้เป็นเส้นโค้งสวยงาม",
        "นำเกี๊ยวซ่าที่ห่อเสร็จแล้ว วางเรียงลงในกระทะ ใส่น้ำมันเพียงเล็กน้อย ตั้งไฟกลางจนกระทะเริ่มร้อน ค่อย ๆ เทน้ำใส่ลงไปประมาณครึ่งของตัวเกี๊ยวซ่า แล้วปิดฝาเร่งไฟแรง รอจนน้ำระเหยหมด",
        "เมื่อน้ำระเหยหมด แล้วปิดไฟยกกระทะออกจากเตา นำกระทะมาพลิกเกี๊ยวซ่าลงใส่ในจานเสิร์ฟ เท่านี้ก็พร้อมฟินแล้วครับผม"
      ],
      [
        "ใส่น้ำมันลงในกระทะ ใส่แฮม ถั่วลันเตา แครอท และเม็ดข้าวโพดลงไปผัด เปิดไฟแรง ผัดสักครู่",
        "เทข้าวลงไป ปรุงรสด้วยซอสมะเขือเทศ ซีอิ๊วขาว ผัดข้าวให้เข้ากัน ตักใส่จานพักไว้",
        "ตอกไข่ไก่ใส่ชาม ปรุงรสด้วยเกลือ เติมนมสดลงไป ตีไข่ไก่ให้เข้ากัน",
        "เทน้ำมันพืชลงไปกลอกให้ทั่วกระทะ ใช้ไฟแรงสุด ค่อย ๆ เทไข่ไก่ลงไป คนไข่อย่างรวดเร็ว พร้อมกลอกไข่ให้เป็นแผ่นบางทั่วกระทะ หากได้แผ่นไข่ลักษณะกลมแบนพอสุกแล้วให้ตะแคงกระทะ ปรับเป็นไฟอ่อน เอียงกระทะไปมาเพื่อทำให้ไข่สุกมากขึ้นตามชอบ",
        "พอไข่สุกได้ที่แล้วก็ตักข้าวผัดลงไปตรงกลางไข่ ห่อแผ่นไข่โดยพับด้านข้างทั้ง 2 ด้านของไข่เข้าหากัน จากนั้นค่อย ๆ จับกระทะคว่ำลงบนจาน",
        "ใช้กระดาษทิชชูอเนกประสงค์สำหรับทำอาหารมาจัดไข่เป็นทรงลูกรักบี้ จัดเรียงใส่จาน พร้อมเสิร์ฟ"
      ],
      [
        "หมักปีกไก่ กับซีอิ้วขาว กับ น้ำปลา อย่างละ 2 ช้อน ทิ้งไว้ 2 ชั่วโมง พอจะนำออกมาทอดให้ใส่แป้งทอดกรอบ ผสมกับน้ำเย็นคลุกๆให่เข้ากัน",
        "ตั้งน้ำมันให้เดือด ปริมาณน้ำมันต้องเทให้ท้วมเนื้อไก่",
        "ทอดไฟกลางถึงแรง"
      ],
      [
        "ผสมอกไก่กับรากผักชี กระเทียม พริกไทย",
        "ปั้นเป็นก้อน หนาขนาด2ซม. นาบกระทะ ไฟกลางด้านละ5-10นาที",
        "ขนมปังทาด้วยซอสมะเขือเทศ จัดเรียงตามรูป พร้อมทาน"
      ],
      [
        "ลวกเส้นมาม่าในน้ำเดือดซักพัก ไม่ต้องนาน ไม่งั้นตอนผัดจะเละ นำเส้นขึ้นมาพักไว้",
        "ตั้งกระทะ ใส่น้ำมัน พอร้อน ฝส่กระเทียมสับลงไป",
        "ใส่หมูสับลงไปผัด",
        "ผัดหมูสับไปซักพัก ใส่ผักตามชอบ ถ้าผักสุกยาก แนะนำให้ลวกก่อนนำมาผัด"
      ],
      [
        "โขลกน้ำพริก โดยใส่ หอมแดง กระเทียม พริกแห้ง เกลือ และกะปิ โขลกให้ละเอียด",
        "ตั้งกระทะใส่น้ำมันเอากระเทียมบุบลงเจียว ให้มีสีเหลืองเล็กน้อยเอาน้ำพริกที่โขลกไว้ใส่ลงไปผัดให้หอม ใส่หมูสับตามลงไปผัด หากมันดูแห้งเกินไปเติมน้ำเล็กน้อยพอหมูใกล้สุกใส่มะเขือเทศตามลงไป ผัดจนมะเขือเทศสุกเละ ปรุงรสด้วยน้ำตาลและน้ำปลา TIPS : หากไม่ชอบหวานไม่ต้องใส่น้ำตาลก็ได้ค่ะ",
        "ปิดไฟแล้วตักใส่ถ้วย โรยหน้าด้วยต้นหอม ผักชีซอย เพียงเท่านี้ “น้ำพริกอ่อง” รสลำ ๆ ก็พร้อมรับประทาน! TIPS : กินแกล้มกับ ผักสด แคบหมู หรือคลุกข้าวสวยร้อน ๆ ก็เข้ากันได้ดีสุด ๆ ไปเลย"
      ],
      [
        "เริ่มทำข้าวเปรี้ยว โดยนำน้ำส้มสายชู น้ำตาลทราย และเกลือป่น ใส่ลงในถ้วยคนให้เข้ากัน จากนั้นนำไปเทใส่ข้าวญี่ปุ่นร้อน ๆ",
        "พอข้าวเย็นก็ตักใส่ภาชนะ จัดแต่งหน้าตามใจชอบ โดยใส่ปลาแซลมอน ยำสาหร่าย ไข่กุ้ง และไข่หั่นฝอย พร้อมเสิร์ฟ"
      ],
    ];
    steps.forEachIndexed((index, element) {
      element.forEachIndexed((i, e) {
        ReStepModel reStepModel = ReStepModel(
            recipeId: (index + 1).toString(), step: i + 1, description: e);
        insertDataToSQLite(reStepModel);
      });
    });
  }

  Future<int> update(ReStepModel reStepModel) async {
    // Database database = await connectedDatabase();
    var results = HewaAPI().update(tableDatabase, reStepModel.toJson(),
        where: '${recipeIdColumn} = ? AND ${stepColumn} = ?',
        whereArgs: [reStepModel.recipeId, reStepModel.step]);
    return results;
  }

  Future<List<ReStepModel>> readlDataFromSQLite() async {
    // Database database = await connectedDatabase();
    List<ReStepModel> reStepModels = [];

    List<dynamic> maps = await HewaAPI().query(tableDatabase);
    for (var map in maps) {
      ReStepModel reStepModel = ReStepModel.fromJson(map);
      reStepModels.add(reStepModel);
    }
    return reStepModels;
  }

  Future<List<ReStepModel>> readDataFromSQLiteWhereId(int id) async {
    //Database database = await connectedDatabase();
    List<ReStepModel> reStepModels = [];
    List<dynamic> maps = await HewaAPI()
        .query(tableDatabase, where: '$idColumn = ?', whereArgs: [id]);
    for (var map in maps) {
      ReStepModel reStepModel = ReStepModel.fromJson(map);
      reStepModels.add(reStepModel);
    }
    return reStepModels;
  }

  Future<List<ReStepModel>> readDataFromSQLiteRestep(
      ReStepModel reStepModel) async {
    //Database database = await connectedDatabase();
    List<ReStepModel> restepModels = [];

    List<dynamic> maps = await HewaAPI().query(tableDatabase,
        where: '$recipeIdColumn = ? And $stepColumn = ?',
        whereArgs: [reStepModel.recipeId, reStepModel.step]);
    for (var map in maps) {
      ReStepModel reStepModel = ReStepModel.fromJson(map);
      restepModels.add(reStepModel);
      print(map);
    }
    return restepModels;
  }

  Future<List<ReStepModel>> readDataFromSQLiteWhereRecipe(
      String recipeId) async {
    //Database database = await connectedDatabase();
    List<ReStepModel> reStepModels = [];

    List<dynamic> maps = await HewaAPI().query(tableDatabase,
        where: '$recipeIdColumn = ?', whereArgs: [recipeId]);
    for (var map in maps) {
      ReStepModel reStepModel = ReStepModel.fromJson(map);
      reStepModels.add(reStepModel);
    }
    return reStepModels;
  }

  Future<Null> deleteDataWhere(String recipeId, int step) async {
    // Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase,
          where: '$recipeIdColumn = ? AND $stepColumn = ?',
          whereArgs: [recipeId, step]);
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteDataWhereRecipe(String recipeId) async {
    //Database database = await connectedDatabase();
    try {
      await HewaAPI().rawQuery(
          'DELETE FROM $tableDatabase WHERE $recipeIdColumn = ?',
          values: [recipeId]);
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteAlldata() async {
    // Database database = await connectedDatabase();
    try {
      await HewaAPI().delete(tableDatabase);
    } catch (e) {
      print('e delete All ==>> ${e.toString()}');
    }
  }
}
