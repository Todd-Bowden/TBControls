//
//  TBSegmentedPicker.swift
//  TBControls
//
//  Created by Todd Bowden on 2/18/23.
//

import Foundation
import SwiftUI

public struct TBSegmentedPicker<S: Hashable, V: View>: View {
    
    public enum Orientation {
        case horizontal
        case vertical
    }
    
    let orientation: Orientation
    @Binding var selection: S
    let views: [V]
    @State var hover = false

    public init(_ orientation: Orientation = .horizontal, selection: Binding<S>, @ViewBuilder content: () -> TupleView<(V,V)>) {
        self.orientation = orientation
        self._selection = selection
        let v = content().value
        self.views = [v.0, v.1]
    }
    
    public init(_ orientation: Orientation = .horizontal, selection: Binding<S>, @ViewBuilder content: () -> TupleView<(V,V,V)>) {
        self.orientation = orientation
        self._selection = selection
        let v = content().value
        self.views = [v.0, v.1, v.2]
    }
    
    public init(_ orientation: Orientation = .horizontal, selection: Binding<S>, @ViewBuilder content: () -> TupleView<(V,V,V,V)>) {
        self.orientation = orientation
        self._selection = selection
        let v = content().value
        self.views = [v.0, v.1, v.2, v.3]
    }
    
    public init(_ orientation: Orientation = .horizontal, selection: Binding<S>, @ViewBuilder content: () -> TupleView<(V,V,V,V,V)>) {
        self.orientation = orientation
        self._selection = selection
        let v = content().value
        self.views = [v.0, v.1, v.2, v.3, v.4]
    }
    
    public init(_ orientation: Orientation = .horizontal, selection: Binding<S>, @ViewBuilder content: () -> TupleView<(V,V,V,V,V,V)>) {
        self.orientation = orientation
        self._selection = selection
        let v = content().value
        self.views = [v.0, v.1, v.2, v.3, v.4, v.5]
    }
    
    public init(_ orientation: Orientation = .horizontal, selection: Binding<S>, @ViewBuilder content: () -> TupleView<(V,V,V,V,V,V,V)>) {
        self.orientation = orientation
        self._selection = selection
        let v = content().value
        self.views = [v.0, v.1, v.2, v.3, v.4, v.5, v.6]
    }
    
    private func frame(index: Int, size: CGSize) -> CGRect {
        switch orientation {
        case .horizontal:
            let width = size.width / CGFloat(views.count)
            return CGRect(x: CGFloat(index) * width, y: 0, width: width, height: size.height)
        case .vertical:
            let height = size.height / CGFloat(views.count)
            return CGRect(x: 0, y: CGFloat(index) * height, width: size.width, height: height)
        }
    }

    private func cornerRadius(size: CGSize) -> CGFloat {
        switch orientation {
        case .horizontal:
            return size.height * 0.2
        case .vertical:
            return size.width * 0.2
        }
    }
    
    private func selectedIndex() -> Int? {
        for i in 0..<views.count {
            if tag(view: views[i]) == selection {
                return i
            }
        }
        return nil
    }
    
    private func tag(view: V) -> S? {
        Mirror(reflecting: view).descendant("modifier", "value", "tagged") as? S
    }
    
    public var body: some View {
        GeometryReader { g in
            let cornerRadius = cornerRadius(size: g.size)
            ZStack(alignment: .topLeading) {
                // Background
                Color.gray
                    .opacity(hover ? 0.13 : 0.1)
                    .frame(width: g.size.width, height: g.size.height)
                    .cornerRadius(cornerRadius)
                // Selection
                if let s = selectedIndex() {
                    let frame = frame(index: s, size: g.size)
                    Color.gray
                        .cornerRadius(cornerRadius)
                        .frame(width: frame.size.width, height: frame.size.height, alignment: .center)
                        .offset(x: frame.origin.x, y: frame.origin.y)
                        .opacity(0.4)
                        .animation(.easeInOut(duration: 0.1), value: selection)
                }
                // Views
                ForEach(0..<views.count, id: \.self) { i in
                    let view = views[i]
                    let frame = frame(index: i, size: g.size)
                    view
                        .frame(width: frame.size.width, height: frame.size.height, alignment: .center)
                        .offset(x: frame.origin.x, y: frame.origin.y)
                    Rectangle()
                        .opacity(0.0001)
                        .offset(x: frame.origin.x, y: frame.origin.y)
                        .frame(width: frame.size.width, height: frame.size.height, alignment: .center)
                        .onTapGesture {
                            if let tag = tag(view: view) {
                                selection = tag
                                hover = false
                            }
                        }
                }
            }
            .onHover { hover in
                self.hover = hover
            }
        }
    }
    
}
