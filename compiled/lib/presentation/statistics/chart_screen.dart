import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChartScreen extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  const ChartScreen({Key key, this.seriesList, this.animate}) : super(key: key);

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory ChartScreen.withSampleData() {
    return new ChartScreen(
      seriesList: _createSampleData(),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Statistics".text.make(),
      ),
      body: new charts.LineChart(
        seriesList,
        animate: animate,
        // Optionally pass in a [DateTimeFactory] used by the chart. The factory
        // should create the same type of [DateTime] as the data provided. If none
        // specified, the default creates local date time.
        // dateTimeFactory: const charts.LocalDateTimeFactory(),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<PersonConsultation, String>> _createSampleData() {
    final data = [
      new PersonConsultation(
          new DateTime(2017, 9, 19), "Yaoundé", "Suspect", 1),
    ];

    return [
      new charts.Series<PersonConsultation, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (PersonConsultation sales, _) => sales.region,
        measureFn: (PersonConsultation sales, _) => sales.patientID,
        displayName: "Test",
        keyFn: (S, _) => "Hiro",
        data: data,
      )
    ];
  }
}

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {}
}

/// Sample time series data type.
class PersonConsultation {
  final DateTime date;
  final String region;
  final String observation;
  final int patientID;

  PersonConsultation(this.date, this.region, this.observation, this.patientID);
}
