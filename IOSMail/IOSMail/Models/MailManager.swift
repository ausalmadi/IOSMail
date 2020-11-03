//
//  MailManager.swift
//  iosMail
//
//  Created by David Crispin on 2020-11-03.
//

import Foundation

protocol MailManagerDelegate {
	func didUpdateMail(_ mailManager: MailManager, mail: MailModel)
	func didFailWithError(error: Error)
}

struct MailManager {
	let userId = "burningman2k9@gmail.com"
	let apiKey = ""
	let mailURL = "https://gmail.googleapis.com/gmail/v1/users/"

	/*GET https://gmail.googleapis.com/gmail/v1/users/burningman2k9%40gmail.com/profile?key=[YOUR_API_KEY] HTTP/1.1

	Authorization: Bearer [YOUR_ACCESS_TOKEN]
	Accept: application/json*/

		//"https://api.openweathermap.org/data/2.5/weather?appid=e72ca729af228beabd5d20e3b7749713&units=metric"

	var delegate: MailManagerDelegate?

	func fetchMail(cityName: String) {
		let urlString = "\(self.userId)/profile/\(self.apiKey)"
		performRequest(with: urlString)
	}


	func performRequest(with urlString: String) {
		if let url = URL(string: urlString) {
			let session = URLSession(configuration: .default)
			let task = session.dataTask(with: url) { (data, response, error) in
				if error != nil {
					self.delegate?.didFailWithError(error: error!)
					return
				}
				if let safeData = data {
					if let _mail = self.parseJSON(safeData) {
						self.delegate?.didUpdateMail(self, mail: _mail)
					}
				}
			}
			task.resume()
		}
	}

	func parseJSON(_ maildata: Data) -> MailModel? {
		let decoder = JSONDecoder()
		do {
			let decodedData = try decoder.decode(mailData.self, from: maildata)
			//let id = decodedData.weather[0].id
			//let temp = decodedData.main.temp
			//let name = decodedData.name

			//let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
			let mail = MailModel(emailAddress: decodedData.emailAddress) //_id : "id01")
			return mail

		} catch {
			delegate?.didFailWithError(error: error)
			return nil
		}
	}



}
