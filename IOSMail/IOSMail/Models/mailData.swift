//
//  mailData.swift
//  iosMail
//
//  Created by David Crispin on 2020-11-03.
//

import Foundation

struct mailData : Codable{

	//init(_id : String){
		//self.id = _id
		//self.threadId = ""
		//self.labelIds = [""]
		//self.snippet = ""
		//self.historyId = ""
		//self.internalDate = ""
		//self.payload = MessagePart(from: <#Decoder#>)
		//self.sizeEstimate = 0
		//self.raw = ""
	//}

	let id : String,
	threadId: String,
	labelIds: [String],
	snippet : String,
	historyId: String,
	internalDate: String,
	payload: MessagePart,
	sizeEstimate : Int,
	raw : String

}

struct MessagePart : Codable{
	let partId : String,
	mimeType: String,
	filename: String,
	headers : [Header],
	body : MessageBodyPart,
	parts : [MessagePart]
}

struct Header : Codable {
	let name: String,
	value: String
}

struct MessageBodyPart : Codable{
	let attachmentId : String,
	size : Int,
	data : String
}
