//
//  MenuDetail.swift
//  little-lemon
//
//  Created by Nanda WK on 2024-11-06.
//

import SwiftUI

struct MenuDetail: View {
    let dish: Dish
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: .init(string: dish.image)) { image in
                    image
                        .resizable()
                        .frame(height: 300)
                } placeholder: {
                    ProgressView()
                }

                VStack(alignment: .leading, spacing: 20) {
                    Text(dish.title)
                        .font(.title)
                        .bold()

                    Text(dish.menuDescription)
                        .font(.body)
                        .multilineTextAlignment(.leading)

                    Text("$\(dish.price)")
                        .font(.headline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .foregroundStyle(.highlight2)
            }
        }
    }
}

#Preview {
    MenuDetail(dish: Dish.preview())
}
