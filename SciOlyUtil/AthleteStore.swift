//
//  AthleteStore.swift
//  SciOlyUtil
//
//  Created by BRENNAN REINHARD on 10/29/24.
//

import Foundation

class AthleteStore {
    static var athletes: [Athlete] = []
    
    static var new: Athlete? // guaranteed if using NewStudentViewController
    
    static func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(athletes) {
            UserDefaults.standard.set(encoded, forKey: "athletes")
        }
    }
    
    static func load() {
        if let athleeetes = UserDefaults.standard.data(forKey: "athletes") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Athlete].self, from: athleeetes) {
                athletes = decoded
            }
        }
    }
}

class Athlete: Codable {
    var first: String
    var last: String
    var event: [EventType]
    var team: TeamType
    

    
    init(first: String, last: String, event: [EventType], team: TeamType) {
        self.first = first
        self.last = last
        self.event = event
        self.team = team
    }
    
    convenience init(first: String, last: String) {
        self.init(first: first, last: last, event: [.None, .None, .None, .None, .None], team: .JV1)
    }
    
    var name: String {
        return "\(last), \(first)"
    }
    

}

enum TeamType: Int, Codable {
    case Varsity = 0
    case JV1
    case JV2
    
    var description: String {
        switch self {
        case .Varsity: return "Varsity"
        case .JV1: return "JV1"
        case .JV2: return "JV2"
        }
    }
}

class Event: Codable {
    var type: EventType
    var room: String
    var athletes: [Athlete]
    
    init(type: EventType, room: String) {
        self.type = type
        self.room = room
        self.athletes = [Athlete]()
    }
    
    init(type: EventType, room: String, athletes: [Athlete]) {
        self.type = type
        self.room = room
        self.athletes = athletes
    }
}

enum EventType: Int, CustomStringConvertible, CaseIterable, Codable {
    case AirTrajectory = 0
    case AnatomyAndPhysiology
    case Astronomy
    case BungreeDrop
    case ChemLab
    case CodeBusters
    case DiseaseDetective
    case DynamicPlanet
    case Ecology
    case ElectricVehicle
    case Entomology
    case ExperimentalDesign
    case Forensics
    case Fossils
    case GeologicMapping
    case MicrobeMission
    case Optics
    case RobotTour
    case Tower
    case WindPower
    case WriteItDoIt
        
    case None
    
    var description: String {
        switch self {
        case .AirTrajectory: return "Air Trajectory"
        case .AnatomyAndPhysiology: return "Anatomy and Physiology"
        case .Astronomy: return "Astronomy"
        case .BungreeDrop: return "Bungee Drop"
        case .ChemLab: return "Chem Lab"
        case .CodeBusters: return "Code Busters"
        case .DiseaseDetective: return "Disease Detective"
        case .DynamicPlanet: return "Dynamic Planet"
        case .Ecology: return "Ecology"
        case .ElectricVehicle: return "Electric Vehicle"
        case .Entomology: return "Entomology"
        case .ExperimentalDesign: return "Experimental Design"
        case .Forensics: return "Forensics"
        case .Fossils: return "Fossils"
        case .GeologicMapping: return "Geologic Mapping"
        case .MicrobeMission: return "Microbe Mission"
        case .Optics: return "Optics"
        case .RobotTour: return "Robot Tour"
        case .Tower: return "Tower"
        case .WindPower: return "Wind Power"
        case .WriteItDoIt: return "Write It Do It"
        
        case .None: return "None"
        }
    }
    
    var index: Int {
        return rawValue
    }
}
