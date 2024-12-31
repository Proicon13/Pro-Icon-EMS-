class ApiConstants {
  static const defaultPerPage = 5;
  static const String baseUrl = "https://api.openweathermap.org/data/2.5/";
  static const loginEndPoint = '/auth/login';
  static const registerEndpoint = '/auth/register';
  static const forgotPasswordEndpoint = '/auth/forgot-password';
  static const resetPasswordEndpoint = '/auth/reset-password';
  static const lookUpCountriesEndpoint = '/lookups/countries';
  static const lookUpCitiesEndpoint = "/lookups/cities/";
  static const currentUserEndpoint = "/auth/me";
  static const getTrainersEndpoint = "/trainers";
  static const clientsEndPoint = "/clients";
  static const addTrainerEndpoint = "/auth/add-trainer-by-admin";
}
