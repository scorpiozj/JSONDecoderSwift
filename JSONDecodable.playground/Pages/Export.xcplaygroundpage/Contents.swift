//: [Previous](@previous)

import Foundation

let jsonString = """
{
"taskName": "Solor",
"taskNumber": 100105,
"startDate": "05-30-2019",
"isAssigned": false,
"task_mission": "this is to do something",
"taskCondition": {
"load": 5000,
"temperature": 50,
"pressure": 1200
},
"assigner": {
"csr_name": "Wang Gang"
},
"parts":[{"number": "WD062781", "name": "fep"},{"number": "WF065212", "name": "ltp"}],
"workers": {
"site": [
{"worker": { "id": "W60001", "name": "Li"}},
{"worker": { "id": "W60023", "name": "Wan"}}
]
},
"sales":[
{"workers":{"id": "S80010","name": "Cang"}}
]

}
"""
var jsonData = jsonString.data(using: .utf8)!
struct ZZHSite : Codable {
    
    let worker : ZZHWorker?
    
    
    enum CodingKeys: String, CodingKey {
        case worker
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        worker = try ZZHWorker(from: decoder)
    }
}


struct ZZHTaskCondition : Codable {
    
    let load : Int?
    let pressure : Int?
    let temperature : Int?
    
    
    enum CodingKeys: String, CodingKey {
        case load = "load"
        case pressure = "pressure"
        case temperature = "temperature"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        load = try values.decodeIfPresent(Int.self, forKey: .load)
        pressure = try values.decodeIfPresent(Int.self, forKey: .pressure)
        temperature = try values.decodeIfPresent(Int.self, forKey: .temperature)
    }
}

struct ZZHWorker : Codable {
    
    let id : String?
    let name : String?
    let site : [ZZHSite]?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case site = "site"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        site = try values.decodeIfPresent([ZZHSite].self, forKey: .site)
    }
}

struct ZZHPart : Codable {
    
    let name : String?
    let number : String?
    
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case number = "number"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        number = try values.decodeIfPresent(String.self, forKey: .number)
    }
}

struct ZZHAssigner : Codable {
    
    let csrName : String?
    
    
    enum CodingKeys: String, CodingKey {
        case csrName = "csr_name"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        csrName = try values.decodeIfPresent(String.self, forKey: .csrName)
    }
    
    
}
struct ZZHSale : Codable {
    
    let workers : ZZHWorker?
    
    enum CodingKeys: String, CodingKey {
        case workers
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        workers = try ZZHWorker(from: decoder)
    }
}
struct ZZHTask : Codable {
    
    let assigner : ZZHAssigner?
    let isAssigned : Bool?
    let parts : [ZZHPart]?
    let sales : [ZZHSale]?
    let startDate : String?
    let taskCondition : ZZHTaskCondition?
    let taskName : String?
    let taskNumber : Int?
    let taskMission : String?
    let workers : ZZHWorker?
    
    
    enum CodingKeys: String, CodingKey {
        case assigner
        case isAssigned = "isAssigned"
        case parts = "parts"
        case sales = "sales"
        case startDate = "startDate"
        case taskCondition
        case taskName = "taskName"
        case taskNumber = "taskNumber"
        case taskMission = "task_mission"
        case workers
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        assigner = try ZZHAssigner(from: decoder)
        isAssigned = try values.decodeIfPresent(Bool.self, forKey: .isAssigned)
        parts = try values.decodeIfPresent([ZZHPart].self, forKey: .parts)
        sales = try values.decodeIfPresent([ZZHSale].self, forKey: .sales)
        startDate = try values.decodeIfPresent(String.self, forKey: .startDate)
        taskCondition = try ZZHTaskCondition(from: decoder)
        taskName = try values.decodeIfPresent(String.self, forKey: .taskName)
        taskNumber = try values.decodeIfPresent(Int.self, forKey: .taskNumber)
        taskMission = try values.decodeIfPresent(String.self, forKey: .taskMission)
        workers = try ZZHWorker(from: decoder)
    }
}
extension DateFormatter {
    static let customerFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter
    }()
}
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .formatted(DateFormatter.customerFormat)
do {
    let task = try decoder.decode(ZZHTask.self, from: jsonData)
    print("task : \(task)")
} catch  {
    print("error: \(error)")
}
//: [Next](@next)
