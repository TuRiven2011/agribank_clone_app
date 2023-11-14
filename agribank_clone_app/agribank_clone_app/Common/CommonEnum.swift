import Foundation
import UIKit

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

enum AppBankEnum: CaseIterable {
    case vietcom, vietin, bidv, vpbank, abbank, exim, scb, lienviet, ncb, ocean, donga, sacom, techcom, mb, maritimebank, shb, bvb, vib, acb, tpbank, hsbc
    
    var image: UIImage? {
        switch self {
        case .vietcom:
            return .init(named: "Logo_Vietcombank_Normal")
        case .vietin:
            return .init(named: "Logo_Viettinbank_Normal")
        case .bidv:
            return .init(named: "bidvbank_Normal")
        case .vpbank:
            return .init(named: "Logo_VPBank_Normal")
        case .abbank:
            return .init(named: "logo_abb_Normal")
        case .exim:
            return .init(named: "Logo_Eximbank_Normal")
        case .scb:
            return .init(named: "Logo_SCB_Normal")
        case .lienviet:
            return .init(named: "Logo_LienViet_Normal")
        case .ncb:
            return .init(named: "Logo_NCB_Normal")
        case .ocean:
            return .init(named: "Logo_Oceanbank_Normal")
        case .donga:
            return .init(named: "Logo_DongA_Normal")
        case .sacom:
            return .init(named: "Logo_Sacombank_Normal")
        case .techcom:
            return .init(named: "Logo_Teccombank_Normal")
        case .mb:
            return .init(named: "Logo_Quandoi_Normal")
        case .maritimebank:
            return .init(named: "Logo_Maritimebank_Normal")
        case .shb:
            return .init(named: "Logo_SHB_Normal")
        case .bvb:
            return .init(named: "Logo_Baovietbank_Normal")
        case .vib:
            return .init(named: "Logo_VIB_Normal")
        case .acb:
            return .init(named: "logo_acb_Normal")
        case .tpbank:
            return .init(named: "Logo_TPbank_Normal")
        case .hsbc:
            return .init(named: "Logo_HSBC_Normal")
        }
    }
}
