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

enum TransactionEnum: Int, CaseIterable {
    case total, moneyIn, moneyOut
    
    var title: String {
        switch self {
        case .total:
            return "Tất cả"
        case .moneyIn:
            return "Tiền vào"
        case .moneyOut:
            return "Tiền ra"
        }
    
    }
        
}
