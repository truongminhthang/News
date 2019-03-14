

import Foundation
import ObjectMapper

struct FeedTemplateModel : Mappable {
	var category1 : [Category1]?
	var category2 : [Category2]?
	var category3 : [Category3]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		category1 <- map["Category 1"]
		category2 <- map["Category 2"]
		category3 <- map["Category 3"]
	}

}
