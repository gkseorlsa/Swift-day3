import Playgrounds
import Foundation

//      String 익스텐션
extension String {
    //      이메일 유효성 검사
    var isValidEmail: Bool {
        contains("@") && contains(".") && count >= 5
    }
    
    //      앞뒤 공백 제거 후 빈 문자열 여부
    var isBlank: Bool {
        trimmingCharacters(in: .whitespaces).isEmpty
    }
        
    //      글자 수 제한 (초과 시 잘라서 "..." 추가)
    func truncated(to limit: Int) -> String {
        count <= limit ? self : String(prefix(limit)) + "..."
    }
}

protocol Playable {
    var title: String { get }
    var duration: Int { get }
    func play()
    var formattedDuration: String { get }
}

//      기본 구현 추가
extension Playable {
    var formattedDuration: String {
        let minutes = duration / 60
        let seconds = duration % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Playground {
    
    /// Part 1. 기본 문법 연습문제
    
    // 3-1. struct vs class
    
    struct Point {
        var x: Int
        var y: Int
    }
    
    class Circle {
        var radius: Double
        init(radius: Double) {
            self.radius = radius
        }
    }
    
    //      struct
    var p1 = Point(x: 1, y: 2)
    var p2 = p1
    p2.x = 10
    print(p1.x, p2.x)
    
    //      class
    var c1 = Circle(radius: 5)
    var c2 = c1
    c2.radius = 10
    print(c1.radius, c2.radius)
    
    //      참조 비교
    let c3 = Circle(radius: 5)
    print(c1 === c2)
    print(c1 === c3)
    
    
    
    // 3-2. 프로퍼티
    
    struct Rectangle {
        var width: Double {
            didSet { print("너비가 \(width)으로 변경됨") }
        }
        var height: Double
        
        var area: Double {
            width * height
        }
        
        var perimeter: Double {
            2 * (width + height)
        }
        
        static let unit = "cm"
        
        mutating func scale(by factor: Double) {
            width *= factor
            height *= factor
        }
        
    }
    
    var rect = Rectangle(width: 10, height: 5)
    print(rect.area)
    print(rect.perimeter)
    rect.width = 20
    print(Rectangle.unit)
    rect.scale(by: 2)
    print(rect.area)
    
    
    // 3-3. 이니셜라이저
    
    class BankAccount {
        var owner: String
        var balance: Double
        
//        init(owner: String, balance: Double) {
//            self.owner = owner
//            self.balance = balance
//        }
        
        convenience init?(owner: String) {
            self.init(owner: owner, balance: 0)
        }
        
        init?(owner: String, balance: Double) {
            guard balance >= 0 else { return nil }
            self.owner = owner
            self.balance = balance
        }
        
        deinit {
            print("\(owner) 계좌 해제")
        }
    }
    
    let a1 = BankAccount(owner: "홍길동", balance: 10000)
    let a2 = BankAccount(owner: "김철수")
    let a3 = BankAccount(owner: "이영희", balance: -1000)
    
    print(a1?.balance ?? 0)
    print(a2?.balance ?? 0)
    print(a3 == nil)
    
    
    // 3-4. 상속 & 오버라이딩
    class Vehicle {
        var speed: Int
        var name: String
        
        init(name: String, speed: Int) {
            self.name = name
            self.speed = speed
        }
        
        func describe() {
            print("\(name) - 최고속도 \(speed)km/h")
        }
    }
    
    class ElectricCar: Vehicle {
        var batteryLevel: Int
        
        //      이니셜라이저
        init(name: String, speed: Int, batteryLevel: Int) {
            self.batteryLevel = batteryLevel
            super.init(name: name, speed: speed)
        }
        
        //      describe() 오버라이드 - 부모 describe() 호출 후 "배터리 잔량: 00%" 추가 출력
        
        override func describe() {
            super.describe()
            print("배터리 잔량: \(batteryLevel)%")
        }
        
    }
    
    class SportsCar: Vehicle {
        //      describe() 오버라이드 - "스포츠카: 00, 최고속도 00km/h"
        override func describe() {
            print("스포츠카: \(name), 최고 속도: \(speed)km/h")
        }
    }
    
    let vehicles: [Vehicle] = [
        ElectricCar(name: "테슬라", speed: 250, batteryLevel: 80),
        SportsCar(name: "페라리", speed: 320),
        Vehicle(name: "버스", speed: 100)
    ]
    
    vehicles.forEach { $0.describe() }
    
    
    // 3-5. 접근제어 & 익스텐션
    
    struct PasswordManager {
        private var storedHash: String
        private(set) var attemptCount: Int = 0
        
        init(password: String) {
            self.storedHash = String(password.reversed())
        }
        
        private func hash(_ input: String) -> String {
            String(input.reversed())
        }
        
        func verify(password: String) -> Bool {
            hash(password) == storedHash
        }
    }
    
//    //      String 익스텐션
//    extension String {
//        //      이메일 유효성 검사
//        var isValidEmail: Bool {
//            contains("@") && contains(".") && count >= 5
//        }
//        
//        //      앞뒤 공백 제거 후 빈 문자열 여부
//        var isBlank: Bool {
//            trimmingCharacters(in: .whitespaces).isEmpty
//        }
//            
//        //      글자 수 제한 (초과 시 잘라서 "..." 추가)
//        func truncated(to limit: Int) -> String {
//            count <= limit ? self : String(prefix(limit)) + "..."
//        }
//    }
        
    
    print("user@email.com".isValidEmail)
    print("   ".isBlank)
    print("Swift Programming:".truncated(to: 5))
    
    
    // 3-6. 프로토콜
    
//    protocol Playable {
//        var title: String { get }
//        var duration: Int { get }
//        func play()
//        var formattedDuration: String { get }
//    }
    
//    //      기본 구현 추가
//    extension Playable {
//        var formattedDuration: String {
//            let minutes = duration / 60
//            let seconds = duration % 60
//            return String(format: "%02d:%02d", minutes, seconds)
//        }
//    }
    
    struct Song: Playable {
        var title: String
        var duration: Int
        var artist: String
        func play() { print("\(artist) - \(title) 재생 중") }
    }
    
    struct Podcast: Playable {
        var title: String
        var duration: Int
        func play() { print(" \(title) 재생 중") }
    }
    
    //      프로토콜 타입으로 배열
    let playlist: [Playable] = [
        Song(title: "Dynamite", duration: 202, artist: "BTS"),
        Podcast(title: "Swift 강의", duration: 3600),
        Song(title: "Butter", duration: 164, artist: "BTS")
    ]
    
    playlist.forEach {
        $0.play()
        print("     재생시간: \($0.formattedDuration)")
    }
    
    
    // 3-7. Codable & Identifiable
    
    //      JSON 데이터
    let json = """
        [
            {"id": 1, "user_name": "홍길동", "score": 95, "is_passed": true},
            {"id": 2, "user_name": "김철수", "score": 42, "is_passed": false},
            {"id": 3, "user_name": "이영희", "score": 88, "is_passed": true}
        ]
        """.data(using: .utf8)!
    
    //      Student 모델 작성
    struct Student: Codable, Identifiable {
        let id: Int
        let userName: String
        let score: Int
        let isPassed: Bool
        
        enum CodingKeys: String, CodingKey {
            case id
            case userName = "user_name"
            case score
            case isPassed = "is_passed"
        }
    }
    
    //      디코딩
    let students = try! JSONDecoder().decode([Student].self, from: json)
    
    //      합격자만 필터 후 이름 출력
    let passed = students.filter { $0.isPassed }.map { $0.userName }
    print(passed)
    
    //      평균 점수 출력
    let average = Double(students.map { $0.score }.reduce(0, +)) / Double(students.count)
    print(String(format: "평균: %.1f", average))
}
