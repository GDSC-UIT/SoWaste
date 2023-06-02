class UrlValue {
  static const appUrl = 'https://sowaste-dev.up.railway.app';
  static const detectTrashUrl =
      'http://35.197.129.203/detect?bb_format=xyxy&return_image=false';

  static const dictionaryUrl = "$appUrl/api/dictionaries";
  static const articlesUrl = "$appUrl/api/articles";
  static const questionsUrl = "$appUrl/api/questions";
  static const trashUrl = "$appUrl/api/dictionary";
  static const userUrl = "$appUrl/api/user";
  static const updateUserPointUrl = "$appUrl/api/user/point";

  // reward
  static const getAllAppRewardsUrl = "$appUrl/api/reward";
  static const getAllUserRewardsUrl = "$appUrl/api/exchanged/user";
  static const getAllAppBadgesUrl = "$appUrl/api/badge";
  static const getAllUserBadgesUrl = "$appUrl/api/badge-collection/user";
  static const createUserExchangeUrl = "$appUrl/api/user/exchange";
  static const deleteUserExchangeUrl = "$appUrl/api/exchanged";

  //qr
  static const postQrCodeUrl = "$appUrl/api/qr/scan";
}
