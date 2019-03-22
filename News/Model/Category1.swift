

import Foundation
import ObjectMapper

struct Category1 : Mappable {
	var feed : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {
		feed <- map["feed"]
	}

}
