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
    
    func save() {
        
    }
    
    func load() {
        
    }
}

class Athlete: Codable {
    var first: String
    var last: String
    var event: [Event]
    
    init(first: String, last: String, event: [Event]) {
        self.first = first
        self.last = last
        self.event = event
    }
    convenience init (first: String, last: String) {
        self.init(first: first, last: last, event: [Event(type: .None, block: 1), Event(type: .None, block: 2), Event(type: .None, block: 3), Event(type: .None, block: 4), Event(type: .None, block: 5)])
    }
    

}

class Event: Codable {
    var type: EventType
    var block: Int
    
    init(type: EventType, block: Int) {
        self.type = type
        self.block = block
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
        case .WindPower: return "Wind Power"
        case .WriteItDoIt: return "Write It Do It"
        
        case .None: return "None"
        }
    }
    
    var index: Int {
        return rawValue
    }
}
