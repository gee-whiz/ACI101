import UIKit

class EntriesTableViewController: UITableViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return AppDelegate.entries.read().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let entry = AppDelegate.entries.read()[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell")!

        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy @h:mm a"
        let dateString = formatter.string(from: entry.createdDate)

        //
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = dateString
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction.init(style: UIContextualAction.Style.destructive, title: "Delete", handler: { (action, view, completion) in

            let entry = AppDelegate.entries.read()[indexPath.row]
            AppDelegate.entries.delete(entry)

            completion(true)
        })
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "EditEntrySegue"
        {
            let index = tableView.indexPathForSelectedRow?.row
            
            let destination = segue.destination as? EditEntryViewController
        
            destination?.entry = AppDelegate.entries.read()[index!]
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        tableView.reloadData()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
