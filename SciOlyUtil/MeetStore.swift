//
//  MeetStore.swift
//  SciOlyUtil
//
//  Created by Brennan Reinhard on 11/11/24.
//

import Foundation

class MeetStore {
    static var meets: [Meet] = []
    
    static func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(meets) {
            UserDefaults.standard.set(encoded, forKey: "meets")
        }
    }
    
    static func load() {
        if let meeets = UserDefaults.standard.data(forKey: "meets") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Meet].self, from: meeets) {
                meets = decoded
            }
        }
    }
}

class Meet: Codable {
    var name: String
    var date: Date
    var blocks: [Block]
    
    init(name: String, date: Date, blocks: [Block]) {
        self.name = name
        self.date = date
        self.blocks = blocks
    }
}

struct Block: Codable {
    var start: Date // when the block starts
    var end: Date // block end
    
    var events: [Event] // list of events in block
}
