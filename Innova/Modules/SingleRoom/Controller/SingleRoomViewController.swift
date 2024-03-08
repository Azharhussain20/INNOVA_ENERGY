import UIKit
import DropDown

class SingleRoomViewController: BaseViewController {
    
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var anchorDropDown: UIView!
    @IBOutlet weak var tblTemperatures: UITableView!
    
    //------------------------------------------
    //MARK: - Class Variables -
    let dropDown = DropDown()
    let data: [(imageName: String, text: String)] = [
        ("in_pencilTheme", "Edit name".localize()),
        ("in_settingFilter", "Edit device list".localize()),
        ("in_trash", "Delete room".localize())
    ]
    var temperatureData: Services = Services(sectionName: "", sectionData: [])
    var isRoomModifies: Bool = false {
        didSet {
            tblTemperatures.dragInteractionEnabled = isRoomModifies
        }
    }
    //------------------------------------------
    //MARK: - Memory Management -
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit
    {
        
    }
    //------------------------------------------
    //MARK: - View Life Cycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetup()
        xibRegistrations()
    }
    override func viewDidAppear(_ animated: Bool) {
        setupDropDown()
    }
    
    
    //------------------------------------------
    //MARK: - API Methods -
    
    //------------------------------------------
    //MARK: - Custom Methods -
    func xibRegistrations() {
        tblTemperatures.register(UINib(nibName: "TemperatureCell", bundle: nil), forCellReuseIdentifier: "TemperatureCell")
        tblTemperatures.dragDelegate = self
    }
    
    func navigationSetup() {
        configurationTitleAndBack(title: temperatureData.sectionName, imageName: "in_leftPrimary")
        navigationItem.rightBarButtonItems = [getbarButtons(image: "in_menuDots", setTag: 0)]
        backTapped = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    func getbarButtons(image:String, setTag: Int) -> UIBarButtonItem {
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: image), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(btnAlertTapped), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        button.tag = setTag
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }
    
    func setupDropDown(){
        dropDown.anchorView = navigationItem.rightBarButtonItem?.plainView
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)! + 16.0)
        dropDown.dataSource = ["Edit name".localize(), "Edit device list".localize(), "Delete room".localize()]
        dropDown.cellNib = UINib(nibName: "customDropDownCell", bundle: nil)
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? customDropDownCell else { return }
            // Setup your custom UI components
            cell.logoImageView.image = UIImage(named: self.data[index].imageName)
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            switch index {
            case 0:
                gotoNameModification()
            case 1:
                isRoomModifies = true
                tblTemperatures.reloadData()
            case 2:
                popupAlert(index: -1, title: "Delete the room".localize(), Message: "Are you sure you want to delete this room? \nOnce deleted, you won't be able to restore it.".localize(), buttonName: "Delete".localize())
            default:
                break;
            }
        }
        dropDown.cornerRadius = 12.0
        dropDown.width = UIScreen.main.bounds.width * 0.70
        dropDown.dismissMode = .onTap
        dropDown.direction = .bottom
        dropDown.dimmedBackgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().cellHeight = 44.0
    }
    
    func gotoMoveDevice(){
        let initiliazeVC : MoveDeviceToRoomViewController = Utilities.viewController(name: "MoveDeviceToRoomViewController", onStoryboard: "SingleRoom") as! MoveDeviceToRoomViewController
        initiliazeVC.hidesBottomBarWhenPushed = true
        navigationController!.pushViewController(initiliazeVC, animated: true)
    }
    
    func gotoNameModification(){
    }
    
    //------------------------------------------
    //MARK: - Action Methods -
    @objc func btnAlertTapped(sender: UIButton) {
        if sender.tag == 0 {
            dropDown.show()
        }
    }
}

//------------------------------------------
//MARK: - TableView Delegate Methods -
extension SingleRoomViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temperatureData.sectionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TemperatureCell", for: indexPath) as! TemperatureCell
        cell.touchUpInsideTrash = {
            self.popupAlert(index: indexPath.row, title: "Delete the device".localize(), Message: "Are you sure you want to delete this device? Once deleted, you'll need to reconfigure it to restore it.".localize(), buttonName: "Delete".localize())
        }
        cell.touchUpInsideWifi = {
            print("WiFi")
        }
        cell.touchUpInsideArrow = {
            print("Arrow")
            self.gotoMoveDevice()
        }
        
        let item = temperatureData.sectionData[indexPath.row]
        cell.lblTemprature.text = item.isSwitchOn ? item.temperature : "--°"
        cell.lblRoomName.text = item.roomName
        cell.lblDeviceName.text = item.deviceName
        
        if item.isSwitchOn {
            cell.gradientImage.image = UIImage(named: "in_tblGradientTheme")
            cell.temperatureSwitch.isHidden = false
            cell.lblTemprature.textColor = appConfig.appColors.themeColor
            cell.lblRoomName.textColor = appConfig.appColors.themeColor
            cell.lblDeviceName.textColor = appConfig.appColors.themeColor

            if item.isConnected {
                cell.btnWifi.isHidden = true
                cell.shieldView.image = item.isPaused ? UIImage(named: "in_themePause") : UIImage(named: "in_exclamationMark")
            } else {
                cell.btnWifi.isHidden = false
                cell.btnWifi.setImage(UIImage(named: "in_wifiSlash"), for: .normal)
                cell.shieldView.image = item.isPaused ? UIImage(named: "in_themePause") : UIImage(named: "in_exclamationMark")
            }
        } else {
            cell.gradientImage.image = UIImage(named: "in_tblGradientGray")
            cell.temperatureSwitch.isHidden = false
            cell.lblTemprature.textColor = appConfig.appColors.btnInActiveTextColor
            cell.lblRoomName.textColor = appConfig.appColors.btnInActiveTextColor
            cell.lblDeviceName.textColor = appConfig.appColors.btnInActiveTextColor
            cell.btnWifi.isHidden = true
            cell.btnWifi.setImage(UIImage(named: "in_wifiSlash"), for: .normal)
            cell.shieldView.image = item.isPaused ? UIImage(named: "in_grayPause") : UIImage(named: "in_exclamationMark")
        }
        if isRoomModifies {
            cell.temperatureSwitch.isHidden = true
            cell.hamburgerView.isHidden = false
            cell.btnTrash.isHidden = false
            cell.btnArrow.isHidden = false
        } else {
            cell.temperatureSwitch.isHidden = false
            cell.hamburgerView.isHidden = true
            cell.btnTrash.isHidden = true
            cell.btnArrow.isHidden = true
        }
        cell.temperatureSwitch.isOn = item.isSwitchOn
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func popupAlert(index : Int , title: String, Message:String, buttonName :String) {
        showAlert( title: title, message: Message, type: .twoButtons (
            button1: (
                title: "Cancel".localize(),
                style: .default,
                handler: {
                    print("\("Cancel".localize()) button tapped")
                }
            ),
            button2: (
                title: buttonName,
                style: .default,
                handler: { [self] in
                    if index >= 0 {
                        temperatureData.sectionData.remove(at: index)
                        isRoomModifies = false
                        tblTemperatures.reloadData()
                        AppInstance.showMessages(message: "Device deleted successfully".localize())
                    }
                }
            )
        ), viewController: self
        )
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return isRoomModifies
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = temperatureData.sectionData[sourceIndexPath.row]
        temperatureData.sectionData.remove(at: sourceIndexPath.row)
        temperatureData.sectionData.insert(movedObject, at: destinationIndexPath.row)
        tblTemperatures.reloadData()
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = temperatureData.sectionData[indexPath.row]
        return [ dragItem ]
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }
}
