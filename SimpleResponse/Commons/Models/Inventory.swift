//
//  Inventory.swift
//  SimpleResponse
//
//  Created by Santo Michael Sihombing on 08/03/22.
//

import Foundation

// MARK: - Inventory
struct Inventory: Codable {
    let id, fullname, colorBackgroud, colorText: String?
    let isSuccess: Bool?
    let location, time: String?
    let listUser: [ListUser]?
}

// MARK: - ListUser
struct ListUser: Codable {
    let fullname, colorBackgroud, colorText: String?
}
