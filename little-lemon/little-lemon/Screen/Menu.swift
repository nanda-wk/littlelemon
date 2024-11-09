//
//  Menu.swift
//  little-lemon
//
//  Created by Nanda WK on 2024-11-06.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var menu: [MenuItem] = []
    @State private var searchText = ""
    @State private var hasLoaded = false

    @FetchRequest(sortDescriptors: [], animation: .default) private var dishes: FetchedResults<Dish>

    private var uniqueCategories: [String] {
        let categories = dishes.compactMap(\.category)
        return Array(Set(categories))
    }

    private let network = NetworkManager.shared

    var body: some View {
        VStack {
            hero

            Divider()
                .padding()

            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()
            ) { (dishes: [Dish]) in
                TextField("Search menu", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .foregroundStyle(.highlight2)
                    .padding(.horizontal)

                HStack {
                    ForEach(uniqueCategories, id: \.self) { category in
                        ZStack {
                            Capsule()
                                .fill(.highlight2)

                            Text(category.capitalized)
                                .font(.footnote)
                                .foregroundStyle(.highlight1)
                        }
                        .frame(height: 40)
                    }
                }
                .padding()

                List {
                    ForEach(dishes, id: \.id) { dish in
                        NavigationLink {
                            MenuDetail(dish: dish)
                        } label: {
                            listCell(dish: dish)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .listStyle(.plain)
            }
        }
        .task {
            if !hasLoaded {
                await getMenuData()
                hasLoaded = true
            }
        }
    }

    var hero: some View {
        VStack(alignment: .leading) {
            Text("Little Lemon")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundStyle(.primary2)

            Text("Chicago")
                .font(.title)
                .foregroundStyle(.highlight1)

            HStack(alignment: .top, spacing: 10) {
                Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    .font(.body)
                    .foregroundStyle(.highlight1)
                    .multilineTextAlignment(.leading)

                Image(.pasta)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 152, height: 152)
                    .clipShape(.rect(cornerRadius: 16))
            }
            .frame(height: 152)
        }
        .padding()
        .background(.primary1)
        .clipShape(.rect(cornerRadius: 16))
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

    private func getMenuData() async {
        PersistenceController.shared.clear()
        if let response = await network.request() {
            menu = response.menu
        }

        for item in menu {
            let dish = Dish(context: viewContext)
            dish.fromMenuItem(item)
        }
        do {
            try viewContext.save()
        } catch {
            print("[Error] Failed to save data: \(error.localizedDescription)")
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
    Menu()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
