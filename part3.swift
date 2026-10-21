import Playgrounds
import Foundation

protocol Purchasable {
    var price: Int { get }
    var discountRate: Double { get }
    var finalPrice: Int { get }
}

extension Purchasable {
    var finalPrice: Int { Int(Double(price) * (1 - discountRate))}
}

#Playground {
    /// 도전 프로젝트: 쇼핑몰 상품 관리
    
    enum Category: String, CaseIterable, Codable {
        case electronics = "전자기기"
        case clothing = "의류"
        case food = "식품"
        case books = "도서"
    }
    
    struct Product: Identifiable, Codable, Hashable, Purchasable {
        let id: UUID
        var name: String
        var price: Int
        var category: Category
        var stock: Int
    }
    
//    protocol Purchasable {
//        var price: Int { get }
//        var discountRate: Double { get }
//        var finalPrice: Int { get }
//    }
    
//    extension Purchasable {
//        var finalPrice: Int { Int(Double(price) * (1 - discountRate))}
//    }
    
    
    class ShoppingMall {
        func addProduct() {
            
        }
        
        func removeProduct() {
            
        }
        
        func searchCategory() {
            
        }
        
        func searchStock() {
            
        }
        
        func betweenPrice() {
            
        }
        
        
    }
}
