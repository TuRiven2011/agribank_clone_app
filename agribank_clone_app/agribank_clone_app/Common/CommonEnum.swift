import Foundation

enum NotificationTypeEnum: Int, CaseIterable {
    case balance, deal, other
    
    var title: String {
        switch self {
        case .balance:
            return "Biến động SD"
        case .deal:
            return "Khuyến mại"
        case .other:
            return "Khác"
        }
    }
}
