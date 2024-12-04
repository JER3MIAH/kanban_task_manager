const String baseSvgPath = 'assets/svgs/';
const String basePngPath = 'assets/pngs/';
const String baseJsonPath = 'assets/json/';

final String arrowDown = 'arrowDown'.svg;
final String addIcon = 'addIcon'.svg;
final String iconBoard = 'icon-board'.svg;
final String iconCheck = 'icon-check'.svg;
final String iconChevronDown = 'icon-chevron-down'.svg;
final String iconChevronUp = 'icon-chevron-up'.svg;
final String iconCross = 'icon-cross'.svg;
final String iconDarkTheme = 'icon-dark-theme'.svg;
final String iconLightTheme = 'icon-light-theme'.svg;
final String iconHideSidebar = 'icon-hide-sidebar'.svg;
final String iconShowSidebar = 'icon-show-sidebar'.svg;
final String iconverticalEllipsis = 'icon-vertical-ellipsis'.svg;
final String logoDark = 'logo-dark'.svg;
final String logoLight = 'logo-light'.svg;
final String logoMobile = 'logo-mobile'.svg;


extension ImageExtension on String {
  // png paths
  String get png => '$basePngPath$this.png';
  // svgs path
  String get svg => '$baseSvgPath$this.svg';
  // jsons path
  String get json => '$baseJsonPath$this.json';
}
