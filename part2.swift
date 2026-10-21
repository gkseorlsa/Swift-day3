import Playgrounds
import Foundation

class Animal {
    var name: String
    var age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    func describe() {
        print("\(name) (\(age)살)")
    }
}

protocol Feedable {
    var favoriteFood: String { get }
    func feed()
}

extension Feedable where Self: Animal {
    func feed() { print("\(name)에게 \(favoriteFood) 급여")}
}

protocol Trainable {
    var tricks: [String] { get }
    func perform()
}

extension Trainable where Self: Animal {
    func perform() { print("\(name) 공연: \(tricks.joined(separator: ", "))")}
}

#Playground {
    /// Part 2. 종합 프로젝트
    
    // 1. 도서관 시스템
    
    struct Book: Codable, Identifiable, Hashable {
        let id: UUID
        var title: String
        var author: String
        var isAvailable: Bool
    }
    
    protocol LibraryManageable {
        var books: [Book] { get }
        mutating func addBook(_ book: Book)
        mutating func removeBook(id: UUID)
        func findBooks(by author: String) -> [Book]
        var availableCount: Int { get }
    }
    
    struct Library: LibraryManageable {
        private(set) var books: [Book] = []
        
        mutating func addBook(_ book: Book) {
            books.append(book)
        }
        
        mutating func removeBook(id: UUID) {
            books.removeAll { $0.id == id }
        }
        
        func findBooks(by author: String) -> [Book] {
            books.filter { $0.author == author }
        }
        
        var availableCount: Int {
            books.filter { $0.isAvailable }.count
        }
        
        //      대출 기능 추가 (이미 대출중이면 false)
        mutating func checkout(id: UUID) -> Bool {
            guard let index = books.firstIndex(where: { $0.id == id }),
                  books[index].isAvailable else { return false }
            
            books[index].isAvailable = false
            return true
        }
        
        //      반납 기능 추가
        mutating func returnBook(id: UUID) {
            guard let index = books.firstIndex(where: { $0.id == id }) else { return }
            books[index].isAvailable = true
        }
    }
    
    var library = Library()
    let b1 = Book(
                id: UUID(),
                title: "Swift 프로그래밍",
                author: "Apple",
                isAvailable: true
            )
    
    let b2 = Book(
                id: UUID(),
                title: "클린코드",
                author: "Robert Martin",
                isAvailable: true
            )
    
    let b3 = Book(
                id: UUID(),
                title: "iOS 개발",
                author: "Apple",
                isAvailable: true
            )
    
    library.addBook(b1)
    library.addBook(b2)
    library.addBook(b3)
    
    print("전체: \(library.books.count)권")
    print("대출 가능: \(library.availableCount)권")
    
    library.checkout(id: b1.id)
    print("대출 후 가능: \(library.availableCount)권")
    
    library.returnBook(id: b1.id)
    print("반납 후 가능: \(library.availableCount)권")
    
    let appleBooks = library.findBooks(by: "Apple")
    print("Apple 도서: \(appleBooks.map { $0.title })")
    
    
    
    
    // 2. 동물원 시스템
    
//    class Animal {
//        var name: String
//        var age: Int
//        init(name: String, age: Int) {
//            self.name = name
//            self.age = age
//        }
//        func describe() {
//            print("\(name) (\(age)살)")
//        }
//    }
    
//    protocol Feedable {
//        var favoriteFood: String { get }
//        func feed()
//    }
    
//    extension Feedable where Self: Animal {
//        func feed() { print("\(name)에게 \(favoriteFood) 급여")}
//    }
    
//    protocol Trainable {
//        var tricks: [String] { get }
//        func perform()
//    }
//    
//    extension Trainable where Self: Animal {
//        func perform() { print("\(name) 공연: \(tricks.joined(separator: ", "))")}
//    }
    
    class Dog: Animal, Feedable, Trainable {
        var favoriteFood = "사료"
        var tricks: [String]
        init(name: String, age: Int, tricks: [String]) {
            self.tricks = tricks
            super.init(name: name, age: age)
        }
    }
    
    class Cat: Animal, Feedable {
        var favoriteFood = "참치"
    }
    
    class Dolphin: Animal, Feedable, Trainable {
        var favoriteFood = "물고기"
        var tricks: [String]
        init(name: String, age: Int, tricks: [String]) {
            self.tricks = tricks
            super.init(name: name, age: age)
        }
    }
    
    let zoo: [Animal] = [
        Dog(name: "멍멍이", age: 3, tricks: ["앉아", "악수", "누워"]),
        Cat(name: "나비", age: 5),
        Dolphin(name: "돌돌이", age: 7, tricks: ["점프", "공굴리기"])
    ]
    
    print("=== 동물 목록 ===")
    zoo.forEach { $0.describe() }
    
    print("=== 먹이 주기 ===")
    zoo.compactMap { $0 as? Feedable }.forEach { $0.feed() }
    
    print("=== 공연 ===")
    zoo.compactMap { $0 as? Trainable }.forEach { $0.perform() }
}
