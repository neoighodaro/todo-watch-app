
import UIKit
import PusherSwift


class ViewController: UITableViewController {

    
    var pusher: Pusher!
    var itemList = [String]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPusher()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // inflate each row
        let currentItem = itemList[indexPath.row]
        let todoCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableCell
        todoCell.setLabel(labelValue: currentItem)
        return todoCell
    }
    
    func setupPusher(){
        
        let options = PusherClientOptions(
            host: .cluster("PUSHER_CLUSTER")
        )
        
        pusher = Pusher(
            key: "PUSHER_KEY",
            options: options
        )
        
        // subscribe to channel and bind to event
        let channel = pusher.subscribe("todo")
        
        let _ = channel.bind(eventName: "addItem", callback: { (data: Any?) -> Void in
            if let data = data as? [String : AnyObject] {
                let value = data["text"] as! String
                //let newItem = TodoModel(item: value, completed: 0)
                self.itemList.append(value)
            }
        })
        
        pusher.connect()
        
    }

}

