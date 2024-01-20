import 'package:flutter/material.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SpeedTest extends StatefulWidget {
  const SpeedTest({super.key});

  @override
  State<SpeedTest> createState() => _SpeedTestState();
}

class _SpeedTestState extends State<SpeedTest> {
  double displayProgress = 0.0;
  double displayRate = 0.0;
  double _downloadRate = 0.0;
  double _uploadRate = 0.0;
  bool isServerSelectionInProgress = false;
  bool isTestingStarted = false;

  String? _ip;
  String? _isp;
  String? _asn;

  String unitTest = '';
  final speedTest = FlutterInternetSpeedTest();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(121, 133, 23, 91),
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.orange,
            height: 0.9,
          ),
        ),
        backgroundColor: Colors.transparent,
        title: const Text(
          "Internet Speed Test",
          style: TextStyle(
              color: Color.fromARGB(255, 228, 100, 100),
              fontWeight: FontWeight.w500),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text(
              "Progress",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            LinearPercentIndicator(
              backgroundColor: const Color.fromARGB(79, 255, 118, 118),
              animation: true,
              linearGradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 224, 66, 66),
                  Color.fromARGB(255, 173, 19, 91)
                ],
              ),
              percent: displayProgress / 100.0,
              lineHeight: 20,
              barRadius: const Radius.circular(10),
              center: Text(
                "${"${displayProgress.toStringAsFixed(1)}%"} ",
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Download Rate",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Upload Rate",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_downloadRate.toStringAsFixed(2)} $unitTest',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${_uploadRate.toStringAsFixed(2)} $unitTest',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              flex: 6,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    radiusFactor: 0.85,
                    minorTicksPerInterval: 1,
                    useRangeColorForAxis: true,
                    interval: 5,
                    minimum: 0,
                    maximum: 100,
                    showTicks: false,
                    axisLineStyle: const AxisLineStyle(
                      thickness: 0.1,
                      thicknessUnit: GaugeSizeUnit.factor,
                      gradient: SweepGradient(colors: <Color>[
                        Color.fromARGB(79, 255, 118, 118),
                        Color.fromARGB(101, 161, 131, 22)
                      ], stops: <double>[
                        0.25,
                        0.75
                      ]),
                    ),
                    showLastLabel: true,
                    axisLabelStyle: const GaugeTextStyle(color: Colors.white),
                    ranges: [
                      GaugeRange(
                        //color: const Color.fromARGB(255, 24, 163, 201),
                        startValue: 0,
                        endValue: 99,
                        startWidth: 10,
                        endWidth: 10,
                      ),
                    ],
                    pointers: [
                      NeedlePointer(
                        value: displayRate,
                        needleStartWidth: 0,
                        needleEndWidth: 5,
                        enableAnimation: true,
                        needleColor: Colors.orange,
                        tailStyle: const TailStyle(
                          color: Colors.white,
                          borderWidth: 0.1,
                          borderColor: Colors.blue,
                        ),
                        knobStyle: const KnobStyle(
                          color: Colors.white,
                          borderColor: Color.fromARGB(255, 56, 184, 167),
                          borderWidth: 0.04,
                          knobRadius: 0.06,
                        ),
                      ),
                      RangePointer(
                          sizeUnit: GaugeSizeUnit.logicalPixel,
                          value: displayRate,
                          gradient: const SweepGradient(colors: <Color>[
                            Color.fromARGB(255, 224, 66, 66),
                            Color.fromARGB(255, 173, 19, 91)
                          ], stops: <double>[
                            0.25,
                            0.80
                          ]),
                          width: 10,
                          enableAnimation: true,
                          color: Colors.orange)
                    ],
                    annotations: [
                      GaugeAnnotation(
                        widget: SizedBox(
                          child: Text(
                            '${displayRate.toStringAsFixed(2)} $unitTest',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        angle: 90,
                        positionFactor: 0.9,
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              isServerSelectionInProgress
                  ? 'Selecting Server...'
                  : 'IP     : ${_ip ?? '00'} \nASP : ${_asn ?? '00'} \nISP   : ${_isp ?? '00'}',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: ElevatedButton(
                autofocus: true,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(232, 209, 140, 13),
                ),
                onPressed: () {
                  testingfunction();
                },
                child: const SizedBox(
                  //height: 100,
                  width: 50,
                  child: Center(
                    child: Text(
                      'Go',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 110, 6, 55),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  testingfunction() {
    resetValues();
    speedTest.startTesting(
      onStarted: () {
        setState(() {
          isTestingStarted = true;
        });
      },
      onCompleted: (TestResult download, TestResult upload) {
        setState(() {
          unitTest = download.unit == SpeedUnit.kbps ? 'Kb/s' : 'Mb/s';
          _downloadRate = download.transferRate;
          displayProgress = 100.0;
          displayRate = _downloadRate;
        });
        setState(() {
          unitTest = download.unit == SpeedUnit.kbps ? 'Kb/s' : 'Mb/s';
          _uploadRate = upload.transferRate;
          displayProgress = 100.0;
          displayRate = _uploadRate;
          isTestingStarted = false;
        });
      },
      onProgress: (double percent, TestResult data) {
        setState(() {
          unitTest = data.unit == SpeedUnit.kbps ? 'Kb/s' : 'Mb/s';
          if (data.type == TestType.download) {
            _downloadRate = data.transferRate;
            displayRate = _downloadRate;
            displayProgress = percent;
          } else {
            _uploadRate = data.transferRate;
            displayRate = _uploadRate;
            displayProgress = percent;
          }
        });
      },
      onError: (String errorMessage, String speedTestError) {
        print('error: ' + errorMessage + speedTestError);
      },
      onDefaultServerSelectionInProgress: () {
        setState(() {
          isServerSelectionInProgress = true;
        });
      },
      onDefaultServerSelectionDone: (Client? client) {
        setState(() {
          isServerSelectionInProgress = false;
          _ip = client!.ip;
          _asn = client.asn;
          _isp = client.isp;
        });
      },
      onDownloadComplete: (TestResult data) {
        unitTest = data.unit == SpeedUnit.kbps ? 'Kb/s' : 'Mb/s';
        setState(() {
          _downloadRate = data.transferRate;
          displayRate = _downloadRate;
        });
      },
      onUploadComplete: (TestResult data) {
        unitTest = data.unit == SpeedUnit.kbps ? 'Kb/s' : 'Mb/s';
        setState(() {
          _uploadRate = data.transferRate;
          displayRate = _uploadRate;
        });
      },
      // onCancel: () {
      //   setState(() {});
      // },
    );
  }

  resetValues() {
    setState(() {
      _downloadRate = 0.0;
      _uploadRate = 0.0;
      displayRate = 0.0;
      displayProgress = 0.0;
      isTestingStarted = false;
      _ip = null;
      _isp = null;
      _asn = null;
    });
  }
}
