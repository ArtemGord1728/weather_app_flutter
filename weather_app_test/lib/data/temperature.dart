class Temperature {

  Temperature.celcius(this.celcius);
  factory Temperature.farhenheit(double farhenheit) =>
      Temperature.celcius((farhenheit - 32) / 1.8);
  factory Temperature.kelvin(double kelvin) =>
      Temperature.celcius(kelvin - absoluteZero);

  static double absoluteZero = 273.15;

  final double celcius;
  double get farhenheit => celcius * 1.8 + 32;
}