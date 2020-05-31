//
//  AuthData.swift
//  DataManager
//
//  Created by Artem Kufaev on 31.05.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

public struct AuthData: Decodable {
    let accessToken: String
    let user: User
}
