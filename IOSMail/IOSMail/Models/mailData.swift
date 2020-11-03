//
//  mailData.swift
//  iosMail
//
//  Created by David Crispin on 2020-11-03.
//

import Foundation

struct mailData {
	var id : String,
	threadId: String,
	labelIds: [String],
	snippet : String,
	historyId: String,
	internalDate: String,
	payload: MessagePart,
	sizeEstimate : Int,
	raw : String

}

struct MessagePart {
	var partId : String,
	mimeType: String,
	filename: String,
	headers : [Header],
	body : MessageBodyPart,
	parts : [MessagePart]
}

struct Header {
	var name: String,
	value: String
}

struct MessageBodyPart {
	var attachmentId : String,
	size : Int,
	data : String
}
