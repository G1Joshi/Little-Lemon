//
//  ValidationHelpers.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 25/11/25.
//

import SwiftUI

enum ValidationHelpers {
    private static let emailRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"

    static func isValidEmail(_ email: String) -> Bool {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedEmail.isEmpty else { return false }
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: trimmedEmail)
    }

    static func isValidName(_ name: String) -> Bool {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty, trimmedName.count >= 3 else { return false }
        let allowedCharacters = CharacterSet.letters.union(.whitespaces)
        return trimmedName.unicodeScalars.allSatisfy { allowedCharacters.contains($0) }
    }

    static func isValidPhone(_ phone: String) -> Bool {
        let trimmedPhone = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedPhone.isEmpty else { return false }

        let digitsOnly = trimmedPhone.filter { $0.isNumber }
        return digitsOnly.count >= 10 && digitsOnly.count <= 15
    }
}

extension String {
    var sanitized: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var isAlphabetic: Bool {
        let allowedCharacters = CharacterSet.letters.union(.whitespaces)
        return unicodeScalars.allSatisfy { allowedCharacters.contains($0) }
    }
}

extension Date {
    var isFuture: Bool {
        self > Date()
    }

    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    var formattedDateTime: String {
        formatted(date: .abbreviated, time: .shortened)
    }
}
