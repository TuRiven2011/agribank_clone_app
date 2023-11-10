import Foundation

struct BalanceNotificationModel: Codable {
    var numberAccount: String?
    var transferMoney: String?
    var lastBalance: Int?
    var content: String?
}
