//
//  AppButton.swift
//  little-lemon
//
//  Created by Nanda WK on 2024-11-06.
//

import SwiftUI

struct AppButton: View {
    let height: CGFloat = 60
    let title: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(.primary2)

            Text(title)
                .font(.title2)
                .bold()
        }
        .frame(height: 60)
    }
}
