enum AppAuthStateEnum { wait, unAuth, auth, noInternet }

enum LoadingStateEnum { wait, loading, success, fail }

enum ProfileTabsEnum { nft, posts }

enum ProductTarget { buy, sell }

abstract class ReportType {
  static String porn = "Порнуху отправляет ааахавзхазвха";
  static String spam = "Спамит, вообще афигел молодой";
  static String violence = "Насилие";
  static String childAbuse = "Детское насилие";
  static String copyright = "Нарушение авторских прав";
  static String drugs = "Продажа или использование наркотиков";
  static String personalDetails = "Раскрытие личной информации";
  static String other = "Другое";
}
