/******************************************************************************** 
    
    ExerciseModel

    Фильтрация тренировок, тестовое заполнение.
  
 *******************************************************************************/

import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/exercise.dart';

// Класс развернутого фильтра
class ExpandedFilter {
  final String value;
  bool active;
  ExpandedFilter(this.value) {
    active = false;
  }
}

// Класс фильтра-родителя
class Filter {
  String type;
  int position;
  List<ExpandedFilter> children;
}

enum ShowOption {
  CTLG_ONLY,
  CTLG_AND_DSCR,
  HIDE
}

class ExerciseAttrib {
  final String name;
  final ShowOption show;
  ExerciseAttrib(this.name, this.show);
}

mixin ExerciseModel on Model {

  String _filtersFileName      = "assets/config/filters.txt";
  String _exerciseViewFileName = "assets/config/exercise_view.txt";

  List<Exercise> exercises = []; // Все упражнения

  int exerciseQuan = 100; // Число упражнений
  int id = 0; // id упражнения (увеличивается при добавлении)

  bool favoriteEnabled = false;

  int _pageNumber = 0;
  
  // Фильтры
  List<String> mainFilters = [];
  Map<String, Filter> filters = Map();
  List<String> timeFilters = [];

  // Аттрибуты упражнения
  List<ExerciseAttrib> exerciseAttribs = [];

  /************************************
   * public функции
  ************************************/

  List<Exercise> getExercises( int pageNumber ) {
    _pageNumber = pageNumber;
    return _getExercises;
  }

  // Сброс фильтрации
  void resetFilters() {
    for (Filter f in filters.values) {
      for (ExpandedFilter expf in f.children) {
        expf.active = false;
      }
    }
    notifyListeners();
  }

  void enableFavorite() {
    favoriteEnabled = !favoriteEnabled;
    notifyListeners();
  }

  void revertFavorite(Exercise aExercise) {
    aExercise.isFavorite = !aExercise.isFavorite;
    notifyListeners();
  }

  bool isFavorite( int id ) {
    return exercises[id].isFavorite;
  }

  /************************************
   * private функции
  ************************************/


  Future<String> _getFileData(String path) async {
    return await rootBundle.loadString(path);
  }

  // Вычисляет, в том ли временном периоде находится упражнение
  bool _fetchPeriod(int time) {
    return true;
  }

  List<Exercise> get _getExercises {
    List<Exercise> filteredExercises = exercises;
    
    // Фильтрация избранного
    if (favoriteEnabled) {
      filteredExercises = filteredExercises.where((item) => item.isFavorite).toList();
    }

    if (_pageNumber != 0) {
      filteredExercises = filteredExercises.where((item) => item.mainType == mainFilters[_pageNumber]).toList();
    }
    for (String key in filters.keys) {
      bool noFilters = true;
      Filter f = filters[key];
      List<String> matchingValues = [];
      for (ExpandedFilter expandedFilter in f.children) {
        if (expandedFilter.active) {
          noFilters = false;
          matchingValues.add(expandedFilter.value);
        }
      }
      if (!noFilters) {
        filteredExercises = filteredExercises.where((item) => matchingValues.contains(item.types[key])).toList();
      }
    }
    return filteredExercises;
  }

  // Используется только в MainModel
  void fillExercises() async {
    // Считывание фильтров из файла
    await _getFilters();

    // Считывание аттрибутов упражнения из файла
    await _getExerciseAttributes();
    
    // Инициализация пустым списком
    exercises = [];
    for (int i = 0; i < exerciseQuan; i++) {
      _addExercise();
    }

  }

  void _addExercise() {
    // В дальнейшем - считывание из сервера или файла
    Exercise exercise;

    int stepsNum = 3;
    int mistakesNum = 5;

    // Создание упражнения
    exercise = Exercise(
        id: id,
        title: "ТРЕНИРОВКА " + id.toString(),
        description: id % 3 == 0 ?
            "В баскетбол играют две команды, каждая из которых состоит из пяти полевых игроков (замены не ограничены). Цель каждой команды — забросить мяч в кольцо с сеткой (корзину) соперника и помешать другой команде завладеть мячом и забросить его в свою корзину. Корзина находится на высоте 3,05 м от паркета (10 футов). За мяч, заброшенный с ближней и средней дистанций, засчитывается два очка, с дальней (из-за трёхочковой линии) — три очка; штрафной бросок оценивается в одно очко. Стандартный размер баскетбольной площадки — 28 м в длину и 15 м — в ширину. Баскетбол — один из самых популярных видов спорта в мире"
            : (id % 3 == 1 ?
            "Футбольный матч состоит из двух равных таймов по 45 минут каждый, если судья и команды-участницы не согласовали перед игрой иного варианта. Любая договорённость об уменьшении времени тайма должна быть достигнута до начала матча и не должна противоречить регламенту соревнований."
            : "Каждая из двух команд может иметь в составе до 14 игроков, на поле во время игры могут находиться 6 игроков. Цель игры — атакующим ударом добить мяч до пола, то есть до игровой поверхности площадки половины противника, или заставить его ошибиться. Игра начинается вводом мяча в игру при помощи подачи согласно жребию."),
        image: id % 3 == 0 ? "assets/images/sport.jpg" : (id % 3 == 1 ? "assets/images/fut.jpg" : "assets/images/vol.jpg"));

    // Добавление шагов и ошибок
    exercise.steps = List<ExerciseStep>();
    exercise.mistakes = List<Mistake>();

    for (int i = 0; i < stepsNum; i++) {
      exercise.steps.add(ExerciseStep(
          id: i,
          exerciseId: id,
          image: exercise.image,
          text: (i+1).toString() + "-й шаг"));
    }

    for (int i = 0; i < mistakesNum; i++) {
      exercise.mistakes.add(Mistake(
          id: i, exerciseId: id, image: exercise.image, text: (i+1).toString() + "-я ошибочка"));
    }

    exercise.types = Map();

    exercise.mainType = mainFilters[mainFilters.length - 1 - id % (mainFilters.length - 1)];
    for (int i = 0; i < exerciseAttribs.length; i++) {
      String type = exerciseAttribs[i].name;
      Filter filter = filters[type];
      if (filter == null) {
        print('нет фильтра');
        exercise.types[type] = 'значение';
      }
      else {
        exercise.types[type] = filter.children[(id + i) % filter.children.length].value;
      } 
    }
    // print('Главный тип: ' + exercise.mainType);
    // print('Уровень: ' + exercise.types['Level']);
    // print('Основная группа мышц: ' + exercise.types['MainMuscles']);
    // Добавление заполненного упражнения в список
    if (id % 7 == 0) {
      exercise.isFavorite = true;
    }
    exercises.add(exercise);
    id++;
  }

  Future<void> _getFilters() async {
    String filtersData = await _getFileData(_filtersFileName);
    List<String> input = filtersData.split('\n');
    input.removeWhere((s) => s.startsWith('#'));
    // Разбор главного фильтра
    String mainFilterStart = input.firstWhere((s) => s.startsWith('mainFilter'));
    String mainFilterEnd = input.firstWhere((s) => s.startsWith('/mainFilter'));
    
    int mainFilterStartIndex = input.indexOf(mainFilterStart); 
    int mainFilterEndIndex = input.indexOf(mainFilterEnd);

    for (int i = mainFilterStartIndex + 1; i < mainFilterEndIndex; i++) {
      mainFilters.add(input[i]);
    }

    // Временной фильтр - TODO
    String timeFilterStart = input.firstWhere((s) => s.startsWith('timeFilter'));
    String timeFilterEnd = input.firstWhere((s) => s.startsWith('/timeFilter'));
    
    int timeFilterStartIndex = input.indexOf(timeFilterStart); 
    int timeFilterEndIndex = input.indexOf(timeFilterEnd);
    
    for (int i = timeFilterStartIndex + 1; i < timeFilterEndIndex; i++) {
      timeFilters.add(input[i]);
    }

    // Побочные фильтры
    List<String> filterStarts = input.where((s) => s.startsWith('filter')).toList();

    int filterPosition = 0;
    for (String start in filterStarts) {
      int filterStartIndex = input.indexOf(start);
      String end = input.firstWhere((s) => s.compareTo('/' + start) == 0);
      int filterEndIndex = input.indexOf(end);

      String filterName = input[filterStartIndex].substring('filter'.length, input[filterStartIndex].length - 1);
      filters[filterName] = Filter();
      filters[filterName].type = input[filterStartIndex + 1];
      filters[filterName].position = filterPosition++;
      List<ExpandedFilter> children = [];
      for (int i = filterStartIndex + 2; i < filterEndIndex; i++) {
        children.add(ExpandedFilter(input[i]));
      }
      // Получение имени фильтра и добавление в карту фильтров
      filters[filterName].children = children;
    }
  }

  Future<void> _getExerciseAttributes() async {
    String filtersData = await _getFileData(_exerciseViewFileName);
    List<String> input = filtersData.split('\n');

    input.removeWhere((s) => s.startsWith('#') || s.length < 2);
    
    ShowOption option;
    for (int i = 0; i < input.length; i++) {
      if (i < 3) {
        option = ShowOption.CTLG_ONLY;
      }
      else if (i < 6) {
        option = ShowOption.CTLG_AND_DSCR;
      }
      else {
        option = ShowOption.HIDE;
      }
      // Убрать символ перевода
      exerciseAttribs.add(ExerciseAttrib(input[i].substring(0, input[i].length - 1), option));
    }
  }
}
