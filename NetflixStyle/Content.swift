

import UIKit

struct Content: Decodable{
    let sectionType: SectionType
    let sectionName: String
    let contentItem: [Item]
    
    ///String -> Type
    enum SectionType: String, Decodable{
        case basic
        case main
        case large
        case rank
    }
}


struct Item: Decodable{
    let description: String
    let imageName: String
    
    ///String -> image 로 변환
    var image: UIImage{
        return UIImage(named: imageName) ?? UIImage()
    }
}
