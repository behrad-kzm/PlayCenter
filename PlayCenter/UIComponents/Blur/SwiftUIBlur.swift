//
//  SwiftUIBlur.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 7/16/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import UIKit
import SwiftUI

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
