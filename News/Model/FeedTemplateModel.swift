

import Foundation
import ObjectMapper



struct FeedTemplateModel : Mappable {
    // MARK: - Change Category Name here ...
    var category1 : [Category1]?
    var category2 : [Category2]?
    var category3 : [Category3]?
//
//
//    var titleCategory1: String? = "Category 1"
//    var titleCategory2: String? = "Category 2"
//    var titleCategory3: String? = "Category 3"
	init?(map: Map) {
        
	}

	mutating func mapping(map: Map) {

		category1 <- map["Category 1"]
		category2 <- map["Category 2"]
		category3 <- map["Category 3"]
	}

}
