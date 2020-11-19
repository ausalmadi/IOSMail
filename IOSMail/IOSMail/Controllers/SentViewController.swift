//
//  SentViewController.swift
//  iosMail
//
//  Created by student on 2020-10-27.
//

import UIKit
import GoogleAPIClientForREST
import GoogleSignIn
import GTMSessionFetcher

class SentViewController: MainViewController {
//    let gmailService = GTLRGmailService.init()
//    var messageList = [GTLRGmail_Message]()
    @IBOutlet weak var tableView: UITableView!
    
    let data = ["To: ABC", "To: CDF","To: GBHDG","To: ABC", "To: CDF","To: GBHDG"]
    let date = ["Aug 1, 2020","Aug 12, 2020","Aug 16, 2020","Aug 17, 2020","Aug 20, 2020","Sep 1, 2020"]
    let subject = ["Subject: A", "Subject: B", "Subject: C", "Subject: D", "Subject: E", "Subject: F"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        listInboxMessages()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    func listInboxMessages() {
//       
//        let listQuery = GTLRGmailQuery_UsersMessagesList.query(withUserId: "me")
//        listQuery.labelIds = ["INBOX"]
//
//        let authorizer = GIDSignIn.sharedInstance()?.currentUser?.authentication?.fetcherAuthorizer()
//
//        gmailService.authorizer = authorizer
//        //gmailService.shouldFetchNextPages = true
//        listQuery.maxResults = 10
//        
//        gmailService.executeQuery(listQuery) { (ticket, response, error) in
//            if response != nil {
////                print("Response: ")
////                print(response)
//                self.getFirstMessageIdFromMessages(response: response as! GTLRGmail_ListMessagesResponse)
//            } else {
//                print("Error: ")
//                print(error)
//            }
//        }
//    }
//    
//    func getFirstMessageIdFromMessages(response: GTLRGmail_ListMessagesResponse) {
//        let messagesResponse = response as GTLRGmail_ListMessagesResponse
//        print("Latest Message: ")
//        print(messagesResponse.messages!.count as Any)
//        do {
//            try print(messagesResponse.messages!.forEach({ (msg) in
//                let query = GTLRGmailQuery_UsersMessagesGet.query(withUserId: "me", identifier: msg.identifier!)
//                gmailService.executeQuery(query) { [self] (ticket, response, error) in
//                    if response != nil {
////                        print(response)
//                        self.messageList.append(response as! GTLRGmail_Message)
//                        print("Message: ")
//                        self.messageList.forEach { (message) in
//                            //get the body of the email and decode it
//                            let mail = self.base64urlToBase64(base64url: message.payload!.parts![0].body!.data!)
//                            if let data = Data(base64Encoded: mail) {
//                                print(String(data: data, encoding: .utf8)!)
//                            }
//                     
//                    
//                        }
//                        
//                    } else {
//                        print("Error: ")
//                        print(error)
//                    }
//                }
////                print(msg.raw)
//                
//            }))
//        } catch{
//            print("error \(error)")
//        }
//             //identifier)
//    }
//
//    // MARK: - GIDSignInUIDelegate Delegates
//    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
////        //myActivityIndicator.stopAnimating()
////        name.text = GIDSignIn.sharedInstance()?.currentUser?.profile?.name
////        emailAddress.text = GIDSignIn.sharedInstance()?.currentUser?.profile?.email
//    }
//    
//    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
//        self.present(viewController, animated: true, completion: nil)
//    }
//    
//    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
//        self.dismiss(animated: true, completion: nil)
//    }
//
////    func parseJSON(_ maildata: Data) -> datamodel? {
////        let decoder = JSONDecoder()
////        do {
////            let decodedData = try decoder.decode(mailData.self, from: maildata)
////            //let id = decodedData.weather[0].id
////            //let temp = decodedData.main.temp
////            //let name = decodedData.name
////
////            //let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
////            let mail = datamodel(email: decodedData.emailAddress) //_id : "id01")
////            return mail
////
////        } catch {
////            //delegate?.didFailWithError(error: error)
////            return nil
////        }
////    }
//    
//    func base64urlToBase64(base64url: String) -> String {
//        var base64 = base64url
//            .replacingOccurrences(of: "-", with: "+")
//            .replacingOccurrences(of: "_", with: "/")
//        if base64.count % 4 != 0 {
//            base64.append(String(repeating: "=", count: 4 - base64.count % 4))
//        }
//        return base64
//    }
//    
//    
    
}

//MARK: Tableview delegate and datasource

extension SentViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as? TableViewCell {
            cell.tableLabel.text = self.data[indexPath.row]
            cell.tableDateLabel.text = self.date[indexPath.row]
            cell.tableSubjectLabel.text = self.subject[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }

}


