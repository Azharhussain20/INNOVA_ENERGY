import Foundation

protocol ThemeFonts {
    var HelveticaNeueItalic : String { get}
    var HelveticaNeueUltraLight : String { get}
    var HelveticaNeueUltraLightItalic : String { get}
    var HelveticaNeueThin : String { get}
    var HelveticaNeueThinItalic : String { get}
    var HelveticaNeueLight : String { get}
    var HelveticaNeueLightItalic : String { get}
    var HelveticaNeueMedium : String { get}
    var HelveticaNeueMediumItalic : String { get}
    var HelveticaNeueBold : String { get}
    var HelveticaNeueBoldItalic : String { get}
    var HelveticaNeueCondensedBold : String { get}
    var HelveticaNeueCondensedBlack : String { get}
    var HelveticaNeueRegular : String { get}
}

class AppFonts: ThemeFonts {
    var HelveticaNeueItalic: String = "HelveticaNeue-Italic"
    var HelveticaNeueUltraLight: String = "HelveticaNeue-UltraLight"
    var HelveticaNeueUltraLightItalic: String = "HelveticaNeue-UltraLightItalic"
    var HelveticaNeueThin: String = "HelveticaNeue-Thin"
    var HelveticaNeueThinItalic: String = "HelveticaNeue-ThinItalic"
    var HelveticaNeueLight: String = "HelveticaNeue-Light"
    var HelveticaNeueLightItalic: String = "HelveticaNeue-LightItalic"
    var HelveticaNeueMedium: String = "HelveticaNeue-Medium"
    var HelveticaNeueMediumItalic: String = "HelveticaNeue-MediumItalic"
    var HelveticaNeueBold: String = "HelveticaNeue-Bold"
    var HelveticaNeueBoldItalic: String = "HelveticaNeue-BoldItalic"
    var HelveticaNeueCondensedBold: String = "HelveticaNeue-CondensedBold"
    var HelveticaNeueCondensedBlack: String = "HelveticaNeue-CondensedBlack"
    var HelveticaNeueRegular: String = "HelveticaNeue-Regular"
}
