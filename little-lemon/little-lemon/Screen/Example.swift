//
//  Example.swift
//  little-lemon
//
//  Created by Nanda WK on 2024-11-07.
//

import SwiftUI

struct Example: View {
    @State private var searchText = ""

    var body: some View {
        VStack {
            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()
            ) { (dishes: [Dish]) in

                List {
                    ForEach(dishes, id: \.self) { dish in
                        VStack(alignment: .leading) {
                            Text(dish.title)
                                .font(.system(size: 16, weight: .bold))

                            HStack {
                                Spacer()
                                Text(dish.price)
                                    .foregroundColor(.gray)
                                    .font(.callout)
                            }
                        }
                    }
                }

                .searchable(text: $searchText,
                            prompt: "search...")
            }
        }
    }

    private func listCell(dish: Dish) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(dish.title)
                    .font(.headline)

                Text(dish.menuDescription)
                    .font(.caption)
                    .padding(.bottom, 10)
                    .multilineTextAlignment(.leading)

                Text("$\(dish.price)")
                    .font(.subheadline)
            }
            .foregroundStyle(.highlight2)

            Spacer()

            AsyncImage(url: .init(string: dish.image)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            .clipShape(.rect(cornerRadius: 16))
        }
    }

    private func buildSortDescriptors() -> [NSSortDescriptor] {
        [
            .init(
                key: "title",
                ascending: true,
                selector: #selector(NSString.localizedStandardCompare)
            ),
        ]
    }

    private func buildPredicate() -> NSPredicate {
        searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
}

#Preview {
    Example()
}
