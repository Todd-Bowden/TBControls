//
//  TBSymbolButton.swift
//

import Foundation
import SwiftUI

public struct TBSymbolButton: View {

    let symbol: String
    let offset: CGSize
    let action: () -> Void
    
    @State var hover = false
    @State var press = false
    
    public init(_ symbol: String, offset: CGSize = CGSize.zero, action: @escaping () -> Void) {
        self.symbol = symbol
        self.offset = offset
        self.action = action
    }
    
    private func smallerDimension(size: CGSize) -> CGFloat {
        size.height < size.width ? size.height : size.width
    }
    
    private var backgroundOpacity: CGFloat {
        if press { return 0.3 }
        if hover { return 0.2 }
        return 0
    }
    
    public var body: some View {
        GeometryReader { g in
            ZStack {
                Color.gray
                    .cornerRadius(smallerDimension(size: g.size) * 0.2)
                    .frame(width: g.size.width, height: g.size.height)
                    .opacity(backgroundOpacity)
                Image(systemName: symbol)
                    .font(.system(size: smallerDimension(size: g.size) * 0.6))
                    .opacity(press ? 1 : 0.7)
                    .offset(offset)
            }
            .frame(width: g.size.width, height: g.size.height)
            .contentShape(Rectangle())
            .onTapGesture(perform: action)
            .onHover { hover in
                self.hover = hover
            }
            ._onButtonGesture { press in
                self.press = press
            } perform: { }
        }
    }
       
}
  
