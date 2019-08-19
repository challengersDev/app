/******************************************************************************** 
   
    UserModel

    Тестовая модель пользователя
 
 *******************************************************************************/

import 'package:scoped_model/scoped_model.dart';

import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../models/auth.dart';

mixin UserModel on Model {
  // Загрузка
  bool isLoading = false;
  User user = User(id: 0,
                   name: "ИМЯ",
                   surname: "ФАМИЛИЯ",
                   email: "email@email.ru",
                   age: 20, 
                   level: UserLevel.BEGINNER,
                   bodyType: BodyType.ENDO,
                   height: 175,
                   weight: 65,
                   sex: Sex.MAN,
                   photo: "assets/images/1.jpg");
  
  User userCopy;

  Future<Map<String, dynamic>> authenticate(String email, String password,
      [AuthMode mode = AuthMode.Login]) async {
    isLoading = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    http.Response response;
    if (mode == AuthMode.Login) {
      response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyA6WUhEXAZFtJx40pkYKjWocaFJnYalaM8',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?AIzaSyA6WUhEXAZFtJx40pkYKjWocaFJnYalaM8',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Неизвестная ошибка';
    print(responseData);
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication succeeded!';
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'Такой e-mail уже существует';
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'Такой e-mail не найден';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'Неверный пароль';
    }
    isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  void setAge( int age ) {
    if ( age < 5 || age > 150 ) {
      return;
    }
    user.age = age;
    notifyListeners();
  }
  void setHeight( int height ) {
    if ( height < 100 || height > 250 ) {
      return;
    }
    user.height = height;
    notifyListeners();
  }
  void setWeight( int weight ) {
    if ( weight < 30 || weight > 350 ) {
      return;
    }
    user.weight = weight;
    notifyListeners();
  }

  void setLevel( UserLevel level ) {
    user.level = level;
    notifyListeners();
  }

  void setBodyType( BodyType type ) {
    user.bodyType = type;
    notifyListeners();
  }

  void setSex( Sex sex ) {
    user.sex = sex;
    notifyListeners();
  }
  
  void createUserCopy() {
     userCopy = User(id: user.id,
                name: user.name,
                surname: user.surname,
                email: user.email,
                sex: user.sex,
                level: user.level,
                bodyType: user.bodyType,
                age: user.age,
                weight: user.weight,
                height: user.height,
                photo: user.photo);
  }
  void revertUser() {
    user = userCopy;
    notifyListeners();
  }
  void confirmChanges() {
    createUserCopy();
  }
}