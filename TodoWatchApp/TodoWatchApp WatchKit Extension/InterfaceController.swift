
import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBAction func addNewItem() {
        
        let suggestionsArray = ["Visit Neo", "Write Pusher article"]
        
        presentTextInputController(withSuggestions: suggestionsArray,allowedInputMode: WKTextInputMode.allowEmoji, completion: { (result) -> Void in
            
            guard let choice = result else {
                return
            }
            let newItem = choice[0] as! String
            
            print(newItem)
            self.postValue(value: newItem)
            
        })
    }
    
    func postValue(value:String){
        
        let parameters = ["value": value] as [String : Any]
        let url = URL(string: "http://127.0.0.1:5000/addItem")!
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }

}
