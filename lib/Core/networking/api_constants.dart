class ApiConstants {
  static const defaultPerPage = 5;
  static const String baseUrl = "https://api.openweathermap.org/data/2.5/";
  static const loginEndPoint = '/auth/login';
  static const registerEndpoint = '/auth/register';
  static const usersEndpoint = '/users';
  static const forgotPasswordEndpoint = '/auth/forgot-password';
  static const resetPasswordEndpoint = '/auth/reset-password';
  static const lookUpCountriesEndpoint = '/lookups/countries';
  static const lookUpHealthConditions = "/lookups/injuries-and-diseases";
  static const lookUpCitiesEndpoint = "/lookups/cities/";
  static const currentUserEndpoint = "/auth/me";
  static const getTrainersEndpoint = "/trainers";
  static const clientsEndPoint = "/clients";
  static const addTrainerEndpoint = "/auth/add-trainer-by-admin";
  static clientHealthConditionsEndpoint(int clientId) =>
      "/clients/$clientId/injuriesAndDiseases";
  static updateClientInjuryEndpoint(int clientId, int injuryId) =>
      "/clients/$clientId/injuries/$injuryId";
  static updateClientDiseaseEndpoint(int clientId, int diseaseId) =>
      "/clients/$clientId/diseases/$diseaseId";
  static clientStrategyEndpoint(int clientId) => "/clients/$clientId/strategy";
}
