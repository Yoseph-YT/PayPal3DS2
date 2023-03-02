//
//  CheckBoxView.swift
//  PayPal3dS2
//
//  Created by Yoseph Tilahun on 1/20/23.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var checked: Bool
        var body: some View {
            Image(systemName: checked ? "checkmark.square.fill" : "square")
                .foregroundColor(checked ? Color.gray : Color.black)
                .onTapGesture {
                    self.checked.toggle()
                }
        }
}

extension View {
  @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
    switch shouldHide {
      case true: self.hidden()
      case false: self
    }
  }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(checked: .constant(false))
    }
}
