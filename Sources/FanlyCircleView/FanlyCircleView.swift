//
//  FanlyCircleView.swift
//  demo
//
//  Created by 叶梅树 on 2022/11/6.
//

import SwiftUI

public struct FanlyCircleView: View {
    @Binding var radius: CGFloat
    
    @Binding var foregroundColors: [Color]
    
    @Binding var borderColors: [Color]
    
    @State var width: CGFloat = 0.0
    
    public init(
        radius: Binding<CGFloat>,
        foregroundColors: Binding<[Color]>,
        borderColors: Binding<[Color]>
    ) {
        self._radius = radius
        self._foregroundColors = foregroundColors
        self._borderColors = borderColors
    }
    
    public var body: some View {
        GeometryReader { geo in
            if radius <= 0 ||
                foregroundColors.count == 0 ||
                borderColors.count == 0 ||
                foregroundColors.count != borderColors.count {
                EmptyView()
            } else {
                ZStack {
                    ForEach(0..<foregroundColors.count, id: \.self) { i in
                        Circle()
                            .frame(width: radius, height: radius)
                            .foregroundColor(foregroundColors[i])
                            .overlay(
                                RoundedRectangle(cornerRadius: radius)
                                    .stroke(borderColors[i], lineWidth: 1)
                            )
                            .offset(getValue(i + 1))
                    }
                }.frame(
                    width: self.width,
                    height: self.width,
                    alignment: .center
                )
                .onAppear {
                    self.width = geo.frame(in: .local).width
                }
            }
        }
    }
    
    private func getValue(_ i: Int) -> CGSize {
        let degree: Double = 360.0 * Double(i - 1) / Double(foregroundColors.count) - 90.0
        let x = CGFloat(Double(width / 2 * cos(degree * Double.pi / 180)))
        let y = CGFloat(Double(width / 2 * sin(degree * Double.pi / 180)))
        
        return CGSize(
            width: x,
            height: y
        )
    }
}

