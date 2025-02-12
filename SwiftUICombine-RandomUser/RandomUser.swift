//
//  RandomUser.swift
//  SwiftUICombine-RandomUser
//
//  Created by 黃柏嘉 on 2025/02/11.
//

import Foundation

struct RandomUser: Decodable {
    
    var results: [RandomUserResults]
    var info: RandomUserInfo?
    
    enum CodingKeys: CodingKey {
        case results
        case info
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decodeIfPresent([RandomUserResults].self, forKey: .results) ?? []
        self.info = try container.decodeIfPresent(RandomUserInfo.self, forKey: .info)
    }
}

struct RandomUserResults: Decodable {
    
    var gender: String
    var name: Name?
    var location: Location?
    var email: String
    var login: Login?
    var dob: Dob?
    var registered: Registered?
    var phone: String
    var cell: String
    var picture: Picture?
    var nat: String
    
    enum GenderType: String {
        case man = "男"
        case female = "女"
    }
    
    var genderType: GenderType {
        return gender == "male" ? .man : .female
    }
    var fullName: String {
        if let name = name {
            return name.first + "." + name.last
        }
        return ""
    }
    
    enum CodingKeys: CodingKey {
        case gender
        case name
        case location
        case email
        case login
        case dob
        case registered
        case phone
        case cell
        case picture
        case nat
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.gender = try container.decodeIfPresent(String.self, forKey: .gender) ?? ""
        self.name = try container.decodeIfPresent(Name.self, forKey: .name)
        self.location = try container.decodeIfPresent(Location.self, forKey: .location)
        self.email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        self.login = try container.decodeIfPresent(Login.self, forKey: .login)
        self.dob = try container.decodeIfPresent(Dob.self, forKey: .dob)
        self.registered = try container.decodeIfPresent(Registered.self, forKey: .registered)
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? ""
        self.cell = try container.decodeIfPresent(String.self, forKey: .cell) ?? ""
        self.picture = try container.decodeIfPresent(Picture.self, forKey: .picture)
        self.nat = try container.decodeIfPresent(String.self, forKey: .nat) ?? ""
    }
}

struct RandomUserInfo: Decodable {
    
    var seed: String
    var results: Int
    var page: Int
    var version: String
    
    enum CodingKeys: CodingKey {
        case seed
        case results
        case page
        case version
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.seed = try container.decodeIfPresent(String.self, forKey: .seed) ?? ""
        self.results = try container.decodeIfPresent(Int.self, forKey: .results) ?? 0
        self.page = try container.decodeIfPresent(Int.self, forKey: .page) ?? 0
        self.version = try container.decodeIfPresent(String.self, forKey: .version) ?? ""
    }
}

struct Name: Decodable {
    
    var title: String
    var first: String
    var last: String
    
    enum CodingKeys: CodingKey {
        case title
        case first
        case last
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.first = try container.decodeIfPresent(String.self, forKey: .first) ?? ""
        self.last = try container.decodeIfPresent(String.self, forKey: .last) ?? ""
    }
}

struct Location: Decodable {
    
    var street: Street?
    var city: String
    var state: String
    var country: String
    var postcode: Int
    var coordinates: Coordinates?
    var timezone: Timezone?
    
    enum CodingKeys: CodingKey {
        case street
        case city
        case state
        case country
        case postcode
        case coordinates
        case timezone
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.street = try container.decodeIfPresent(Street.self, forKey: .street)
        self.city = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
        self.state = try container.decodeIfPresent(String.self, forKey: .state) ?? ""
        self.country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
        self.postcode = try container.decodeIfPresent(Int.self, forKey: .postcode) ?? 0
        self.coordinates = try container.decodeIfPresent(Coordinates.self, forKey: .coordinates)
        self.timezone = try container.decodeIfPresent(Timezone.self, forKey: .timezone)
    }
}

struct Street: Decodable {
    var number: Int
    var name: String
    
    enum CodingKeys: CodingKey {
        case number
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.number = try container.decodeIfPresent(Int.self, forKey: .number) ?? 0
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}

struct Coordinates: Decodable {
    
    var latitude: String
    var longitude: String
    
    enum CodingKeys: CodingKey {
        case latitude
        case longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try container.decodeIfPresent(String.self, forKey: .latitude) ?? ""
        self.longitude = try container.decodeIfPresent(String.self, forKey: .longitude) ?? ""
    }
}

struct Timezone: Decodable {
    
    var offset: String
    var description: String
    
    enum CodingKeys: CodingKey {
        case offset
        case description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.offset = try container.decodeIfPresent(String.self, forKey: .offset) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
    }
}

struct Login: Decodable {
    
    var uuid: String
    var username: String
    var password: String
    var salt: String
    var md5: String
    var sha1: String
    var sha256: String
    
    enum CodingKeys: CodingKey {
        case uuid
        case username
        case password
        case salt
        case md5
        case sha1
        case sha256
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uuid = try container.decodeIfPresent(String.self, forKey: .uuid) ?? ""
        self.username = try container.decodeIfPresent(String.self, forKey: .username) ?? ""
        self.password = try container.decodeIfPresent(String.self, forKey: .password) ?? ""
        self.salt = try container.decodeIfPresent(String.self, forKey: .salt) ?? ""
        self.md5 = try container.decodeIfPresent(String.self, forKey: .md5) ?? ""
        self.sha1 = try container.decodeIfPresent(String.self, forKey: .sha1) ?? ""
        self.sha256 = try container.decodeIfPresent(String.self, forKey: .sha256) ?? ""
    }
}

struct Dob: Decodable {
    var date: String
    var age: Int
    
    enum CodingKeys: CodingKey {
        case date
        case age
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decodeIfPresent(String.self, forKey: .date) ?? ""
        self.age = try container.decodeIfPresent(Int.self, forKey: .age) ?? 0
    }
}

struct Registered: Decodable {
    
    var date: String
    var age: Int
    
    enum CodingKeys: CodingKey {
        case date
        case age
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decodeIfPresent(String.self, forKey: .date) ?? ""
        self.age = try container.decodeIfPresent(Int.self, forKey: .age) ?? 0
    }
}

struct Id: Decodable {
    
    var name: String
    var value: String
    
    enum CodingKeys: CodingKey {
        case name
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.value = try container.decodeIfPresent(String.self, forKey: .value) ?? ""
    }
}

struct Picture: Decodable {
    
    var large: String
    var medium: String
    var thumbnail: String
    
    enum CodingKeys: CodingKey {
        case large
        case medium
        case thumbnail
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.large = try container.decodeIfPresent(String.self, forKey: .large) ?? ""
        self.medium = try container.decodeIfPresent(String.self, forKey: .medium) ?? ""
        self.thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail) ?? ""
    }
}
