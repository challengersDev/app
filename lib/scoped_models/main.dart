/******************************************************************************** 
    
    MainModel
   
    Главная модель, объединяющая все модели типа scoped_model
    Используется везде, где есть scoped_model
 
 *******************************************************************************/

import 'package:scoped_model/scoped_model.dart';

import './exercise.dart';
import './navigation.dart';
import './user.dart';
import './edit_options.dart';
import './sizes.dart';


class MainModel extends Model with ExerciseModel, NavigationModel, UserModel, EditOptionsModel, SizesModel {
  
  MainModel() {

    fillExercises();

    // Создание копии для отката изменений
    createUserCopy();

  }
}