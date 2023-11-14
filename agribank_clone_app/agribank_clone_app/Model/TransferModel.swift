//
//  TransferModel.swift
//  agribank_clone_app
//
//  Created by Tú Phạm Bá on 13/11/2023.
//

import Foundation

struct TransferModel: Codable {
    var userName: String?
    var numberAccount: String?
    var balance: Int?
    var openBranch: String?
    var content: String?
    var money: Int?
    var numberTransferAccount: String?
    var bankTransfer: String?
    var date: Date?
    var isReceive: Bool?
}
