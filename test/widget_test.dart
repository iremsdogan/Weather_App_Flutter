import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/main.dart';
import 'package:mockito/annotations.dart';
import 'widget_test.mocks.dart';
import 'package:weather_app/models/weather_data.dart';

// Mock sınıfı WeatherService sınıfını taklit ediyor
@GenerateMocks([WeatherService])
//bunu otomatik yapmazsam elle 
//class MockWeatherService extends Mock implements WeatherService {}
//yazmam gerek
void main() {
  late MockWeatherService mockWeatherService;

  setUp(() {
    mockWeatherService = MockWeatherService();
  });

  testWidgets('Weather data is displayed correctly', (WidgetTester tester) async {
    
    when(mockWeatherService.fetchWeatherData()).thenAnswer((_) async => [
      WeatherData(
        date: '2024-11-05T00:00:00Z', 
        avgTemp: 9,
        minTemp: 4, 
        maxTemp: 13, 
        weatherCode: 1000,
        sunriseTime: '2024-11-04T04:30:00Z',
        sunsetTime: '2024-11-04T14:56:00Z',
      ),
    ]);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Tuesday | 5 November'), findsOneWidget);
    expect(find.text('9°C'), findsOneWidget);
    expect(find.text('4°C'), findsOneWidget);
    expect(find.text('13°C'), findsOneWidget);
    // expect(find.text('04:30'), findsOneWidget);
    // expect(find.text('14:56'), findsOneWidget);
  });
}
