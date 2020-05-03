//
//  CoreDataWorkerError.swift
//  Storage
//
//  Created by Artem Kufaev on 03.05.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

public enum CoreDataWorkerError: Error {
    case cannotFetch(String)
    case cannotSave(String)
    case cannotConvertion(String)
}
