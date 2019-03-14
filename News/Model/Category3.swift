
import Foundation
import ObjectMapper

struct Category3 : Mappable {
	var feed : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		feed <- map["feed"]
	}

}
