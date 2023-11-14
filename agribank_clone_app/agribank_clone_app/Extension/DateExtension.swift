//
//  DateExtension.swift
//  agribank_clone_app
//
//  Created by Tú Phạm Bá on 14/11/2023.
//

import Foundation

extension Date {
    func formatToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm dd/MM/yyyy" //If you dont want static "UTC" you can go for ZZZZ instead of 'UTC'Z.
        formatter.timeZone = TimeZone(abbreviation: "IST")
        let result = formatter.string(from: self)
        return result
    }
}
