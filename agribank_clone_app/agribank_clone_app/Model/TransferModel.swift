import Foundation

struct TransferModel: Codable {
    var id: String = UUID().description
    var userName: String?
    var numberAccount: String?
    var balance: Int?
    var openBranch: String?
    var content: String?
    var money: Int?
    var name2: String?
    var numberAccount2: String?
    var bank2: String?
    var date: Date?
    var isReceive: Bool?
    var code: String?
}
