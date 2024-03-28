

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var cellSelect: String!
    var arrayCells = [ProfileSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        addCell()
        addUserName()
       
    }
    
    func addUserName() {
        if UD().getNameUser() == nil {
            //self.navigationController?.popToRootViewController(animated: true)
        }else{
            nameLbl.text = UD().getNameUser()
        }
    }

    
    
    func addCell() {
        arrayCells.append(ProfileSection(cell: ["sizing information", "payment information","account information", "address book", "style preferences"], nameSection: "MyAccount"))
        arrayCells.append(ProfileSection(cell: ["terms and conditions", "privacy policy","faqs"], nameSection: "Support"))
        arrayCells.append(ProfileSection(cell: ["currency choice", "apple Face ID", "communication preferences", "language"], nameSection: "General settings"))
        arrayCells.append(ProfileSection(cell: ["email"], nameSection: "Contact us"))
        tableView.reloadData()
    }
    


}
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.frame.size.width, height: 63.0))
        view.backgroundColor = .white
        let lbl = UILabel(frame: CGRect(x: 10.0, y: 0.0, width: view.frame.size.width, height: 63.0))
        lbl.text = arrayCells[section].nameSection
        lbl.textColor = .black
        view.addSubview(lbl)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCells[section].cell.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profile") as! ProfileTableViewCell
        let arrayCells2 = arrayCells[indexPath.section]
        cell.lbl.text = arrayCells2.cell[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellSelect = arrayCells[indexPath.section].cell[indexPath.row]
        performSegue(withIdentifier: "cellGo", sender: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayCells.count
    }
    

    
}

