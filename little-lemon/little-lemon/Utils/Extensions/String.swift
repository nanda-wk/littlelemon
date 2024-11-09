//
//  String.swift
//  little-lemon
//
//  Created by Nanda WK on 2024-11-06.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}
