//
//  DockButtonsShape.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 7/17/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import SwiftUI

struct DockButtonsShape: Shape {
  
  let cornerRadius: CGFloat
  let circleRadius: CGFloat
  func path(in rect: CGRect) -> Path {
    return makeDockButtons(rect, cornerRadius: cornerRadius, circleRadius: circleRadius)
  }
  
  func makeDockButtons(_ proxy: CGRect , cornerRadius: CGFloat = 4, circleRadius: CGFloat = 10) -> Path {
    let dockWidth = proxy.size.width //* 0.5
    let dockHeight = proxy.size.height //* 0.62725
    
    let offset = CGFloat(4)
    let x1 = ( proxy.size.width - dockWidth) / 2
    let y1 = ( proxy.size.height - dockHeight )
    
    let x2 = ( proxy.size.width + dockWidth) / 2
    
    let x3 = proxy.size.width * 0.5
    let y3 = proxy.size.height
    
    let x4 = x3 + circleRadius + offset
    let x5 = x3 - circleRadius - offset
    
    return Path { path in
      path.move(to: CGPoint(x: x1 + cornerRadius, y: y1))
      path.addQuadCurve(to: CGPoint(x: x1, y: y1 + cornerRadius), control: CGPoint(x: x1, y: y1))
      
      path.addLine(to: CGPoint(x: x1, y: y3 - cornerRadius))
      path.addQuadCurve(to: CGPoint(x: x1 + cornerRadius, y: y3), control: CGPoint(x: x1, y: y3))
      
      path.addLine(to: CGPoint(x: x2 - cornerRadius, y: y3))
      path.addQuadCurve(to: CGPoint(x: x2, y: y3 - cornerRadius), control: CGPoint(x: x2, y: y3))
      
      path.addLine(to: CGPoint(x: x2, y: y1 + cornerRadius))
      path.addQuadCurve(to: CGPoint(x: x2 - cornerRadius, y: y1), control: CGPoint(x: x2, y: y1))
      
      path.addLine(to: CGPoint(x: x4, y: y1))
      
      path.addArc(center: CGPoint(x: x3, y: y1), radius: circleRadius, startAngle: Angle(radians: 0), endAngle: Angle(radians: .pi), clockwise: false)
      
      path.addLine(to: CGPoint(x: x5, y: y1))
      path.closeSubpath()
    }
    
  }
}

struct DockButtonsShape_Previews: PreviewProvider {
  static var previews: some View {
    DockButtonsShape(cornerRadius: 16, circleRadius: 32)
      .previewLayout(.sizeThatFits)
    .padding()
      .frame(width: 320, height: 80, alignment: .center)
  }
}
