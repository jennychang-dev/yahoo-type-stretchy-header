import UIKit

struct NewsItem {

    var category: Region
    var headline: String
    
    init(category: Region, headline: String) {
        self.category = category
        self.headline = headline
    }
    
    enum Region {
        case World
        case Europe
        case AsiaPacific
        case Africa
        case MiddleEast
        case Americas
        
        
        func convertRegionToString() -> String {
            switch self {
            case .World:
                return "World"
            case .Europe:
                return "Europe"
            case .AsiaPacific:
                return "Asia Pacific"
            case .Africa:
                return "Africa"
            case .MiddleEast:
                return "Middle East"
            case .Americas:
                return "Americas"
            }
            
        }
        
        func assignColourToEachRegion() -> UIColor {
            switch self {
            case .World:
                return UIColor.red
            case .Europe:
                return UIColor.green
            case .AsiaPacific:
                return UIColor.purple
            case .Africa:
                return UIColor.orange
            case .MiddleEast:
                return UIColor.yellow
            case .Americas:
                return UIColor.blue
            }
            
        }
        
    }
    
    
}
