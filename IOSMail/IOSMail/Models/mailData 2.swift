//
//  mailData.swift
//  iosMail
//
//  Created by David Crispin on 2020-11-03.
//

import Foundation

struct mailData : Codable{


	/* let id : String,
	threadId: String,
	labelIds: [String],
	snippet : String,
	historyId: String,
	internalDate: String,
	payload: MessagePart,
	sizeEstimate : Int,
	raw : String */
	let emailAddress : String,
	messagesTotal : Int,
	threadsTotal: Int,
	historyId : Int

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
