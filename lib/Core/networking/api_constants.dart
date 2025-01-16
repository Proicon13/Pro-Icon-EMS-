class ApiConstants {
  static const defaultPerPage = 5;

  static const loginEndPoint = '/auth/login';
  static const registerEndpoint = '/auth/register';
  static const usersEndpoint = '/users';
  static const forgotPasswordEndpoint = '/auth/forgot-password';
  static const resetPasswordEndpoint = '/auth/reset-password';
  static const lookUpCountriesEndpoint = '/lookups/countries';
  static const lookUpHealthConditions = "/lookups/injuries-and-diseases";
  static const lookUpCitiesEndpoint = "/lookups/cities/";
  static const lookupMusclesEndpoint = "/lookups/muscles";
  static const currentUserEndpoint = "/auth/me";
  static const getTrainersEndpoint = "/trainers";
  static const clientsEndPoint = "/clients";
  static const addTrainerEndpoint = "/auth/add-trainer-by-admin";
  static const addCustomProgramEndpoint = "/programer/add-program";
  static updateCustomProgramEndpoint(int id) => "/programer/update-program/$id";
  static deleteCustomProgramEndpoint(int id) => "/programer/delete-program/$id";
  static updateProgramMuscleEndpoint(int id) =>
      "/programer/update-program-mucle/$id";
  static updateProgramCycle(int id) => "/programer/update-program-cycle/$id";

  static clientHealthConditionsEndpoint(int clientId) =>
      "/clients/$clientId/injuriesAndDiseases";
  static updateClientInjuryEndpoint(int clientId, int injuryId) =>
      "/clients/$clientId/injuries/$injuryId";
  static updateClientDiseaseEndpoint(int clientId, int diseaseId) =>
      "/clients/$clientId/diseases/$diseaseId";
  static clientStrategyEndpoint(int clientId) => "/clients/$clientId/strategy";
}
