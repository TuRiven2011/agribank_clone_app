import Foundation

extension Int {
    func addComma() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value: self))
        return formattedNumber?.replacingOccurrences(of: ".", with: ",", options: .literal, range: nil) ?? ""
    }
}
