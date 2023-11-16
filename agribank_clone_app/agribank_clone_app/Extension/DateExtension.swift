import Foundation

extension Date {
    func formatToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm dd/MM/yyyy" //If you dont want static "UTC" you can go for ZZZZ instead of 'UTC'Z.
        formatter.timeZone = TimeZone(abbreviation: "IST")
        let result = formatter.string(from: self)
        return result
    }
}
extension Date {
    func format(partern: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = partern
        dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatterGet.string(from: self)
    }
}
