#include <dht11.h>                                   // dht11.h 라이브러리를 불러옵니다.

dht11 DHT11;                                         // DHT11이라는 객체를 만들고 dht11의 내용을 넣어줍니다.

#define DHT11PIN 2                                   // DHT11PIN을 2로 설정합니다.

void setup()
{
  Serial.begin(9600);                               //  시리얼 통신을 사용하기 위해 보드레이트를 9600으로 설정합니다.
  Serial.println("DHT11 TEST PROGRAM ");            // 'DHT11 TEST PROGRAM'를 시리얼 통신으로 송신하고 줄을 바꿉니다.
  Serial.print("LIBRARY VERSION: ");                // 'LIBRARY VERSION: '를 시리얼 통신으로 송신합니다.
  Serial.println(DHT11LIB_VERSION);                 // DHT11LIB_VERSION 변수값을 시리얼 통신으로 송신하고 줄을 바꿉니다.
  Serial.println();                                 // 줄을 바꿉니다.
}

double Fahrenheit(double celsius)                    // Fahrenheit라는 함수를 만듭니다. 함수의 입력값은 celsius에 저장됩니다.
{
  return 1.8 * celsius + 32;                         // 입력된 celsius값을 1.8를 곱하고 32를 더하여 출력합니다.
}

void loop()
{
  Serial.println("\n");                             // 줄바꿈을 츨력하고 줄을 바꿉니다 (2줄을 바꿈)
  int chk = DHT11.read(DHT11PIN);                    // DHT11PIN에서 받은 값을 chk에 저장합니다.
  Serial.print("Humidity (%): ");                   // 'Humidity (%): '를 시리얼 통신으로 출력합니다.
  Serial.println((float)DHT11.humidity, 2);         // DHT11.humidity 값을 소수점 2자리수까지 출력하고 줄을 바꿉니다.
  Serial.print("Temperature (oC): ");               // 'Temperature (oC): '를 시리얼 통신으로 출력합니다.
  Serial.println((float)DHT11.temperature, 2);      // DHT11.temperature 값을 소수점 2자리수까지 출력하고 줄을 바꿉니다.
  Serial.print("Temperature (oF): ");               // 'Temperature (oF): '를 시리얼 통신으로 출력합니다.
  Serial.println(Fahrenheit(DHT11.temperature), 2); // DHT11.temperature 값을 소수점 2자리수까지 출력하고 줄을 바꿉니다.
  delay(2000);                                       // 2초동안 지연시킵니다.
}
