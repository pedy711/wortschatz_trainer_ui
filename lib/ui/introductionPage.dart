import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wortschatz_trainer/models/basic/customLocation.dart';
import 'package:wortschatz_trainer/models/communication/dataSourceResponse.dart';
import 'package:wortschatz_trainer/models/communication/dsRequest.dart';
import 'package:wortschatz_trainer/models/user.dart';
import 'package:wortschatz_trainer/ui/landingPage.dart';
import 'package:wortschatz_trainer/ui/loginPage.dart';
import 'package:wortschatz_trainer/shared/constants.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;
import 'dart:math' as Math;
import 'package:http/http.dart' as http;


BuildContext _context;
const jasonCodec = const JsonCodec();

class IntroductionPage extends StatefulWidget {
  @override
  createState() => _IntroductionPage();
}

class _IntroductionPage extends State<IntroductionPage> {
  PageView _pageView = PageView();
  PageController _pageController = PageController();
  TextEditingController firstNameController = TextEditingController();
  bool _firstNameBtnActivated = false;
  int _genderSelection = -1;
  final dateFormat = intl.DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  DateTime date;
  Map<String, double> _startLocation;
  Map<String, double> _currentLocation;
  StreamSubscription<Map<String, double>> _locationSubscription;
  Location _location = new Location();
  bool _permission = false;
  String error;
  String _country;
  List<File> _imageArr;
  TextEditingController summaryTextController = TextEditingController();


  @override
  void initState() {
    super.initState();

//    initPlatformState();

/*    _locationSubscription =
        _location.onLocationChanged().listen((Map<String,double> result) {
          setState(() {
            _currentLocation = result;
            print(result);
          });
        });*/
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    _pageView = new PageView(children: <Widget>[
      createAboutYourselfSlide(),
      createFirstNamePage(),
      createGenderPage(),
      createBirthdayPage(),
      createLocationPage(),
      createPhotoUploadPage(),
      createSummaryPage(),
    ], controller: _pageController);

    return new Scaffold(
      backgroundColor: Colors.tealAccent,
      body: _pageView,
    );
  }

  // ------------------------------------------[ About You Page]------------------------------------------------
  Widget createAboutYourselfSlide() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: ListView(
            children: <Widget>[createAboutYourselfCard(), buildRaisedButton()]),
      ),
    );
  }

  Padding createAboutYourselfCard() {
    return Padding(
        padding: EdgeInsets.only(left: 50, right: 50, top: 5, bottom: 100),
        child: Card(
            child: Padding(
                padding:
                EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
                child: Column(
                  children: <Widget>[
                    Text(
                      Constants.SELF_SUMMARY_TITLE_TEXT,
                      textScaleFactor: 1.5,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      Constants.SELF_SUMMARY_TEXT,
                      textDirection: TextDirection.rtl,
                    )
                  ],
                ))));
  }

  RaisedButton buildRaisedButton() {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
      child: Text(
        Constants.NEXT_TEXT,
        textScaleFactor: 1.5,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      textColor: Colors.white,
      color: Colors.blueAccent,
      onPressed: () => nextPage(),
//          submit();
    );
  }

  // ------------------------------------------[ First name Page]------------------------------------------------
  Widget createFirstNamePage() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: ListView(children: <Widget>[
          createFirstNameFields(),
          Padding(padding: EdgeInsets.only(bottom: 145)),
          buildRaisedButtonForFirstNamePage()
        ]),
      ),
    );
  }

  Column createFirstNameFields() {
    return Column(
      children: <Widget>[
        Text(
          Constants.ABOUT_YOU_TEXT,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          textDirection: TextDirection.rtl,
        ),
        TextField(
            maxLength: 50,
            controller: firstNameController,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
                hintStyle: TextStyle(),
                labelText: Constants.FIRST_NAME_TEXT,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            onChanged: onTextChanged),
      ],
    );
  }

  void onTextChanged(String value) {
    setState(() {
      if (value.isNotEmpty && value.length > 1)
        _firstNameBtnActivated = true;
      else
        _firstNameBtnActivated = false;
    });
  }

  RaisedButton buildRaisedButtonForFirstNamePage() {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
      child: Text(
        Constants.NEXT_TEXT,
        textScaleFactor: 1.5,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      textColor: Colors.white,
      color: Colors.blueAccent,
      onPressed: _firstNameBtnActivated ? () => nextPage() : null,
//          submit();
    );
  }

  void nextPage() {
    _pageController.nextPage(
        duration: new Duration(milliseconds: 300), curve: Curves.linear);
  }

  // ------------------------------------------[ Gender Page]------------------------------------------------
  Widget createGenderPage() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: ListView(children: <Widget>[
          createGenderSelectionCard(),
          Padding(padding: EdgeInsets.only(bottom: 30)),
          buildRaisedButtonForGenderPage()
        ]),
      ),
    );
  }

  Column createGenderSelectionCard() {
    return Column(
      children: <Widget>[
        Text(
          Constants.ABOUT_YOU_TEXT,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          textDirection: TextDirection.rtl,
        ),
        Padding(
            padding: EdgeInsets.only(top: 10, bottom: 50),
            child: Card(
              child: Column(
                children: createRadios(),
              ),
            ))
      ],
    );
  }

  List<Widget> createRadios() {
    List<Widget> list = new List<Widget>();

    list.add(new Column(
      children: <Widget>[
        new RadioListTile(
            value: 0,
            groupValue: _genderSelection,
            title: Text(Constants.FEMALE),
            onChanged: (int value) {
              onChangedRadio(value);
            }),
        new Divider(),
        new RadioListTile(
            value: 1,
            groupValue: _genderSelection,
            title: Text(Constants.MALE),
            onChanged: (int value) {
              onChangedRadio(value);
            }),
      ],
    ));

    return list;
  }

  void onChangedRadio(int value) {
    setState(() {
      _genderSelection = value;
      _genderPageBtnActivated = true;
    });
  }

  bool _genderPageBtnActivated = false;

  RaisedButton buildRaisedButtonForGenderPage() {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
      child: Text(
        Constants.NEXT_TEXT,
        textScaleFactor: 1.5,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      textColor: Colors.white,
      color: Colors.blueAccent,
      onPressed: _genderPageBtnActivated ? () => nextPage() : null,
//          submit();
    );
  }

  // ------------------------------------------[ Birthday Page]------------------------------------------------
  bool _birthdayPageBtnActivated = false;

  Widget createBirthdayPage() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: ListView(children: <Widget>[
          createBirthdayDatePicker(),
          Padding(padding: EdgeInsets.only(bottom: 113)),
          buildRaisedButtonForBirthdayPage()
        ]),
      ),
    );
  }

  Column createBirthdayDatePicker() {
    return Column(
      children: <Widget>[
        Text(
          Constants.BIRTHDAY,
          textDirection: TextDirection.rtl,
          textScaleFactor: 1.5,
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 50),
          child: RaisedButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            onPressed: _showDatePicker,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '$_datetime',
                    textScaleFactor: 1.5,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.date_range,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            textColor: Colors.white,
            color: Colors.blue,
          ),
        )
      ],
    );
  }

  String _datetime = '';
  int _year = 2018;
  int _month = 11;
  int _date = 11;

  /// Display date picker.
  void _showDatePicker() {
    String _lang = 'en';
    String _format = 'yyyy-mm-dd';
    bool _showTitleActions = true;

    final bool showTitleActions = false;
    DatePicker.showDatePicker(
      context,
      showTitleActions: _showTitleActions,
      minYear: 1300,
      maxYear: 1397,
      initialYear: _year,
      initialMonth: _month,
      initialDate: _date,
      confirm: Text(
        Constants.OK,
        style: TextStyle(color: Colors.green),
      ),
      cancel: Text(
        Constants.CANCEL,
        style: TextStyle(color: Colors.red),
      ),
      locale: _lang,
      dateFormat: _format,
      onChanged: (year, month, date) {
        debugPrint('onChanged date: $year-$month-$date');

        if (!showTitleActions) {
          _changeDatetime(year, month, date);
        }
      },
      onConfirm: (year, month, date) {
        _changeDatetime(year, month, date);
        _birthdayPageBtnActivated = true;
      },
    );
  }

  void _changeDatetime(int year, int month, int date) {
    setState(() {
      _year = year;
      _month = month;
      _date = date;
      _datetime = '$year-$month-$date';
    });
  }

  RaisedButton buildRaisedButtonForBirthdayPage() {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
      child: Text(
        Constants.NEXT_TEXT,
        textScaleFactor: 1.5,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      textColor: Colors.white,
      color: Colors.blueAccent,
      onPressed:
      _birthdayPageBtnActivated ? () => nextPage() : null,
//          submit();
    );
  }

  void navigateToLandingPage() async {
    bool result = await Navigator.push(
        _context, MaterialPageRoute(builder: (context) => LandingPage()));
  }

// ------------------------------------------[ Location Page]------------------------------------------------
  bool _locationPageBtnActivated = false;
  bool _defaultLocationCard = true;

  Widget createLocationPage() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: ListView(children: <Widget>[
          Text(
            Constants.ABOUT_YOU_TEXT,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textDirection: TextDirection.rtl,
          ),
          Text(
            Constants.WHERE_DO_YOU_LIVE,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textDirection: TextDirection.rtl,
          ),
          _defaultLocationCard ? createLocationCard() : createLocationForm(),
          Padding(padding: EdgeInsets.only(bottom: 30)),
          buildRaisedButtonLocationNextPage()
        ]),
      ),
    );
  }

  Column createLocationCard() {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 40, bottom: 50),
            child: Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Text(
                        Constants.AUTOMATIC_LOCATION,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                      Padding(padding: EdgeInsets.all(30)),
                      enableLocationServicesBtn(),
                      Padding(padding: EdgeInsets.all(5)),
                      InkWell(
                        child: Text(
                          "No Thanks",
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () =>
                            setState(() {
                              _defaultLocationCard = false;
                              _locationPageBtnActivated = true;
                            }),
                      )
                    ],
                  ),
                )))
      ],
    );
  }

  Widget createLocationForm() {
    return CountryCodePicker(
      onChanged: (countryCode) => _onCountryChange(countryCode),
      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
      initialSelection: 'IR',
      favorite: ['+98', 'IR'],
    );
  }

  _onCountryChange(CountryCode countryCode) {
    _country = countryCode.name;
    /*  setState(() {
      _locationPageBtnActivated = true;
    });*/
    print("New Country selected: " + countryCode.toString());
  }

  RaisedButton buildRaisedButtonLocationNextPage() {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(2.0)),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
      child: Text(
        Constants.NEXT_TEXT,
        textScaleFactor: 1.5,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      textColor: Colors.white,
      color: Colors.blueAccent,
      onPressed: _locationPageBtnActivated ? () => nextPage() : null,
//          submit();
    );
  }

  RaisedButton enableLocationServicesBtn() {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(2.0)),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
      child: Padding(
        padding: EdgeInsets.only(left: 80, right: 80),
        child: Text(
          Constants.ACTIVATE,
          textScaleFactor: 1.2,
        ),
      ),
      textColor: Colors.white,
      color: Colors.blueAccent,
      onPressed: () => initPlatformState(),
//          submit();
    );
  }

  initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
/**/
    try {
      _permission = await _location.hasPermission();
      _currentLocation = await _location.getLocation();
      error = null;
//      _locationPageBtnActivated = true;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
        'Permission denied - please ask the user to enable it from the app settings';
      }

      _currentLocation = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    //if (!mounted) return;

    setState(() {
      _startLocation = _currentLocation;
    });

    _locationSubscription =
        _location.onLocationChanged().listen((Map<String, double> result) {
          setState(() {
            _locationPageBtnActivated = true;
            _currentLocation = result;
          });
        });
  }

// ------------------------------------------[ Photo Upload Page]------------------------------------------------
  bool _photoUploadPageBtnActivated = false;

  Widget createPhotoUploadPage() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 20)),
          Text(
            Constants.ABOUT_YOU_TEXT,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textDirection: TextDirection.rtl,
          ),
          Text(
            Constants.ADD_SOME_GREAT_PHOTOS,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textDirection: TextDirection.rtl,
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          new Expanded(child: buildGridView()),
          /*_imageArr == null
              ? new Text('No image selected.')
              : new Image.file(_imageArr.elementAt(0)),
          Padding(padding: EdgeInsets.only(bottom: 30)),
          new FloatingActionButton(
            onPressed: getImage,
            tooltip: 'Pick Image',
            child: new Icon(Icons.add_a_photo),
          ),*/
          buildRaisedButtonPhotoUploadNextPage()
        ]),
      ),
    );
  }

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (_imageArr == null) {
        _imageArr = new List<File>();
      }
      if (image != null) {
        _imageArr.add(image);
        _photoUploadPageBtnActivated = true;
      }
    });
  }

  bool notNull(Object o) => o != null;

  Card makeGridCell(IconData icon, int imgNum) {
    Widget imgOrTextWidget = createImgWidget(imgNum);
    return Card(
      elevation: 1.0,
      child: Column(
        children: <Widget>[
          imgOrTextWidget,
          imgOrTextWidget == null
              ? new FloatingActionButton(
            onPressed: getImage,
            tooltip: 'Pick Image',
            child: new Icon(Icons.add_a_photo),
          )
              : null
        ].where(notNull).toList(),
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Image createImgWidget(int imgNum) {
    return _imageArr != null && _imageArr.length > imgNum
        ? new Image.file(
      _imageArr.elementAt(imgNum),
      height: 140,
      width: 140,
    )
        : null;
  }

  GridView buildGridView() {
    return GridView.count(
        primary: true,
        padding: EdgeInsets.all(1.0),
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        children: <Widget>[
          makeGridCell(Icons.add_a_photo, 0),
          makeGridCell(Icons.add_a_photo, 1),
          makeGridCell(Icons.add_a_photo, 2),
          makeGridCell(Icons.add_a_photo, 3),
          makeGridCell(Icons.add_a_photo, 4),
          makeGridCell(Icons.add_a_photo, 5),
        ]);
  }

  Future getImageCamera() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    int rand = new Math.Random().nextInt(100000);

    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image);

    var compressImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));

    setState(() {
      _imageArr.add(compressImg);
    });
  }

  Future getImageGallery() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    int rand = new Math.Random().nextInt(100000);

    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image);

    var compressImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));

    setState(() {
      _imageArr.add(compressImg);
    });
  }

  RaisedButton buildRaisedButtonPhotoUploadNextPage() {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(2.0)),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
      child: Text(
        Constants.NEXT_TEXT,
        textScaleFactor: 1.5,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      textColor: Colors.white,
      color: Colors.blueAccent,
      onPressed: _photoUploadPageBtnActivated ? () => nextPage() : null,
//          submit();
    );
  }

  // ------------------------------------------[ Summary Page]------------------------------------------------
  bool _summaryPageBtnActivated = false;

  Widget createSummaryPage() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: ListView(children: <Widget>[
          Text(
            Constants.ABOUT_YOU_TEXT,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textDirection: TextDirection.rtl,
          ),
          Text(
            Constants.SHORT_SUMMARY,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textDirection: TextDirection.rtl,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: TextField(
                maxLength: 500,
                maxLines: 5,
                controller: summaryTextController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintStyle: TextStyle(),
                  labelText: Constants.SHORT_SUMMARY_Label,
                  filled: true,
                  /*border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.0))*/),
                onChanged: activateFinishBtn),
          ),
          /*_imageArr == null
              ? new Text('No image selected.')
              : new Image.file(_imageArr.elementAt(0)),
          Padding(padding: EdgeInsets.only(bottom: 30)),
          new FloatingActionButton(
            onPressed: getImage,
            tooltip: 'Pick Image',
            child: new Icon(Icons.add_a_photo),
          ),*/
          buildRaisedButtonSummaryNextPage()
        ]),
      ),
    );
  }

  RaisedButton buildRaisedButtonSummaryNextPage() {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(2.0)),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
      child: Text(
        Constants.GET_STARTED_BTN,
        textScaleFactor: 1.5,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      textColor: Colors.white,
      color: Colors.blueAccent,
      onPressed: _summaryPageBtnActivated ? () => saveData() : null,
//          submit();
    );
  }

  void activateFinishBtn(String value) {
    setState(() {
      if (value.isNotEmpty && value.length > 1)
        _summaryPageBtnActivated = true;
      else
        _summaryPageBtnActivated = false;
    });
  }

  void saveData() {
    var currentLocation = <String, double>{};

    User user = User();
 /*    user.firstName = firstNameController.text;
    user.gender = _genderSelection;
    user.birthday = new DateTime(_year, _month, _date);
    user.location = new CustomLocation(
        _currentLocation["latitude"], _currentLocation["longitude"]);
    user.summary = summaryTextController.text; */


    registerUser(user);

//    _date
//    _month
//    _year


  }

  Future<String> registerUser(User user) async {
    Uri uri = Uri.http(Constants.SERVER_URL, Constants.REGISTER_USER);
    String str = json.encode(user);
    print(str);

    http.Response response = await http.post(
        uri,
        body: json.encode(user.toJson()),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        }
    );

    if (response.statusCode == 201) {
      // registration accepted: go to next
      navigateToPage(IntroductionPage());
    } else {
      // user already exists: go to sign in page
      print(response.statusCode);
//      navigateToPage(LoginPage());
    }
  }


  void navigateToPage(Widget page) async {
    bool result = await Navigator.push(
        _context, MaterialPageRoute(builder: (context) => page));
  }
}