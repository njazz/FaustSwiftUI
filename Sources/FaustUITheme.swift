//
//  FaustUITheme.swift
//  FaustSwiftUI
//
//  Created by alex on 28/03/2025.
//

import SwiftUI

extension Color {
    func inverted() -> Color {
        let ciColor = CIColor(color: NSColor(self))
        
        // Invert RGB values
        let invertedRed = 1.0 - ciColor!.red
        let invertedGreen = 1.0 - ciColor!.green
        let invertedBlue = 1.0 - ciColor!.blue
        
        return Color(
            red: invertedRed,
            green: invertedGreen,
            blue: invertedBlue
        )
    }
}

public protocol FaustWidgetTheme {

    var accentColor : Color { get }
    var numboxTextColor : Color { get }
    var numboxBackgroundColor : Color { get }
    
    var cornerRadius: CGFloat { get }
    
    /// used in label and number boxes
    var font : Font { get }
    
    /// label & numbox size. widget size is usually 1..2 x labelSize
    var labelSize: CGFloat { get }
    
    /// size of the slider component in hslider/vslider
    /// add elementWidth to get full width for hslider or elementWidth\*  to get height for vslider
    var sliderSize: CGFloat { get }
    
    var padding: CGFloat { get }
    var groupSpacing: CGFloat { get }
}

public class DefaultTheme: FaustWidgetTheme {

    public var accentColor: Color = .accentColor
    public var numboxTextColor: Color = .white
    public var numboxBackgroundColor: Color = .gray
    
    public var cornerRadius: CGFloat = 5
    public var font: Font = .title
    
    public var labelSize: CGFloat = 25
    public var sliderSize: CGFloat = 200
    
    public var padding: CGFloat = 5
    public var groupSpacing: CGFloat = 3
}

class FaustThemeManager: ObservableObject {
    @Published var theme: DefaultTheme = DefaultTheme()

    func switchTheme(to newTheme: DefaultTheme) {
        theme = newTheme
    }
}


