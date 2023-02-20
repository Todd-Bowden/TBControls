//
//  TBCheckbox.swift
//
//

import Foundation
import SwiftUI

public struct TBCheckbox: View {

    let size: CGFloat
    let symbol: String
    @Binding var isChecked: Bool
    @State var hover: Bool = false
    
    public init(size: CGFloat, isChecked: Binding<Bool>, symbol: String = "checkmark") {
        self.size = size
        self.symbol = symbol
        self._isChecked = isChecked
    }
    
    private var backgroundOpacity: CGFloat {
        if isChecked { return 0.4 }
        if hover { return 0.15 }
        return 0.1
    }
    
    private var symbolOpacity: CGFloat {
        if isChecked { return 0.85 }
        if hover { return 0.15 }
        return 0
    }

    public var body: some View {
        ZStack {
            Color.gray
                .frame(width: size, height: size, alignment: .center)
                .cornerRadius(size * 0.2)
                .opacity(backgroundOpacity)
            
            Image(systemName: symbol)
                .font(Font.system(size: size * 0.6))
                .opacity(symbolOpacity)
        }
        .frame(width: size, height: size, alignment: .center)
        .contentShape(Rectangle())
        .onHover { hover in
            self.hover = hover
        }
        .onTapGesture {
            isChecked.toggle()
            if !isChecked { hover = false }
        }
    }
}

struct TBCheckbox_Previews: PreviewProvider {
    static var previews: some View {
        TBCheckbox(size: 30, isChecked: .constant(false))
        TBCheckbox(size: 30, isChecked: .constant(true))
            
    }
}
