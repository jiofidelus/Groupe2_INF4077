import 'package:meta/meta.dart';

class Disease {
  static const String name = "{{.Disease.Name}}";
  static const String causedBy ="{{.Disease.CausedBy}}";
  static const String description = "{{.Disease.Description}}";
  static const String causes = "{{.Disease.Causes}}";
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
  {{range .Symptoms}}
    Symptom._(name: "{{.Name}}", points: {{.Points}}, information: "{{.Information}}", question: "{{.Question}}"),
  {{end}}
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
   {{range .Results}}
    Result._(
           start: {{.Start}},
           end: {{.End}},
           overview: "{{.Overview}}",
           description: "{{.Description}}",
           advices: [
              {{range .Results}}
              "{{.}}",
              {{end}}
           ],
    ),
    {{end}}

  ];
}
