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
}

}
"""
var jsonData = jsonString.data(using: .utf8)!


var task = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)

if let taskdic = task as? Dictionary<String, Any> {
    taskdic["taskName"]
}

struct ZZHWorker {
    let workerID: String
    let workerName: String
}

extension ZZHWorker: Decodable {
    enum CodingKeys: String, CodingKey {
        case workerID = "id"
        case workerName = "name"
    }
    
    enum WorkerKey: CodingKey { case worker }
    
    init(from decoder: Decoder) throws {
        let rootKeys        = try decoder.container(keyedBy: WorkerKey.self)
        let workerContainer  = try rootKeys.nestedContainer(keyedBy: CodingKeys.self, forKey: .worker)
        workerID = try workerContainer.decode(String.self,
                                        forKey: .workerID )
        workerName = try workerContainer.decode(String.self,
                                          forKey: .workerName)
    }
}

struct ZZHCondition {
    let load: Int
    let temperature: Int
    let pressure: Int
}
extension ZZHCondition: Decodable {
    
}

struct ZZHTask {
    let taskName: String
    let taskNumber: Int
    let startDate: Date
    let isAssigned: Bool
    let taskMission: String
    let taskCondition: ZZHCondition
    let assigner: String
}

extension ZZHTask: Decodable {
    enum CodingKeys: String, CodingKey {
        case taskName
        case taskNumber
        case startDate
        case isAssigned
        case taskMission = "task_mission"
        case taskCondition
        case assigner
        
        enum AssignerKey: String, CodingKey {
            case csrName = "csr_name"
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        taskName = try container.decode(String.self, forKey: .taskName)
        taskNumber = try container.decode(Int.self, forKey: .taskNumber)
        startDate = try container.decode(Date.self, forKey: .startDate)
        isAssigned = try container.decode(Bool.self, forKey: .isAssigned)
        taskMission = try container.decode(String.self, forKey: .taskMission)
        taskCondition = try container.decode(ZZHCondition.self, forKey: .taskCondition)
        
        let assignContainer = try container.nestedContainer(keyedBy: CodingKeys.AssignerKey.self, forKey: .assigner)
        assigner = try assignContainer.decode(String.self, forKey: .csrName)
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
task = try decoder.decode(ZZHTask.self, from: jsonData)
print("task : \(task)")
//: [Next](@next)
