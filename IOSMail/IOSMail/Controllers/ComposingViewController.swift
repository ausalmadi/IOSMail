//
//  ComposingViewController.swift
//  iosMail
//
//  Created by student on 2020-10-27.
//

import UIKit

class ComposingViewController: MainViewController, UITextViewDelegate {

    @IBOutlet var messageBody: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageBody.delegate = self
        addHint()
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            addHint()
        }
    }
    
    func addHint() {
        messageBody.text = "Type here..."
        messageBody.textColor = UIColor.lightGray
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
