import 'package:meta/meta.dart';

class Disease {
  static const String name = "Cholera";
  static const String causedBy ="Dirty water";
  static const String description = "Cholera kills so be careful";
  static const String causes = "When you drink impure water";
}

class Symptom {
  final String name;
  final int points;
  final String information;
  final String question;

  const Symptom._(
      {@required this.name,
      @required this.points,
      @required this.information,
      @required this.question});

  static const List<Symptom> all = [
  
    Symptom._(name: "Cough", points: 1, information: "Useful info about cough", question: "Question"),
  
  ];
}

class Result {
  final int start;
  final int end;
  final String overview;
  final String description;
  final List<String> advices;

  const Result._({
    @required this.start,
    @required this.end,
    @required this.overview,
    @required this.description,
    @required this.advices,
  });

  static const List<Result> all = [
   
    Result._(
           start: 0,
           end: 3,
           overview: "No harm",
           description: "You have nothing serious",
           advices: [
              
              "Stay at home",
              
              "Protect your self",
              
              "Drink alot",
              
           ],
    ),
    
    Result._(
           start: 4,
           end: 6,
           overview: "Take care",
           description: "Your situation, isn't seveer to be consider a dangerous",
           advices: [
              
              "Stay at home",
              
              "Protect your self",
              
              "Drink alot",
              
           ],
    ),
    
    Result._(
           start: 7,
           end: 14,
           overview: "Take care carefully",
           description: "Your situation, isn't seveer to be consider a dangerous",
           advices: [
              
              "Stay at home",
              
              "Protect your self",
              
              "Drink alot",
              
           ],
    ),
    
    Result._(
           start: 15,
           end: 100,
           overview: "You are dying",
           description: "Your situation, isn't seveer to be consider a dangerous",
           advices: [
              
              "Stay at home",
              
              "Protect your self",
              
              "Drink alot",
              
           ],
    ),
    

  ];
}