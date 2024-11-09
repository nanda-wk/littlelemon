//
//  NetworkManager.swift
//  little-lemon
//
//  Created by Nanda WK on 2024-11-06.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func request() async -> MenuList? {
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        var result: MenuList?

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                print("[Error] Invalid status code.")
                return result
            }

            guard (200 ... 299).contains(statusCode) else {
                print("[Error] Status code \(statusCode) is not in the range of 200...299.")
                return result
            }

            result = try JSONDecoder().decode(MenuList.self, from: data)

        } catch {
            print("[Error] \(error.localizedDescription)")
        }
        return result
    }
}
