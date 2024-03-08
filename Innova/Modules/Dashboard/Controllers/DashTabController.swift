import UIKit

class DashTabController: UITabBarController {
    //------------------------------------------
    //MARK: - Outlets -
    //------------------------------------------
    //MARK: - Class Variables -
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
        setTabbarAttributes()
        setTabBarItems()
    }
    
    //------------------------------------------
    //MARK: - Custom Methods -
    func setTabbarAttributes() {
        tabBar.layer.cornerRadius = 15
        tabBar.layer.masksToBounds = true
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        tabBar.layer.shadowRadius = 4
        tabBar.backgroundColor = appConfig.appColors.tabbarBackground
    }
    
    func setTabBarItems(){
        let myTabBarItem0 = (tabBar.items?[0])! as UITabBarItem
        myTabBarItem0.image = UIImage(named: "in_houseUnselected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem0.selectedImage = UIImage(named: "in_house")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem0.title = ""
        myTabBarItem0.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let myTabBarItem1 = (tabBar.items?[1])! as UITabBarItem
        myTabBarItem1.image = UIImage(named: "in_calendarUnselected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem1.selectedImage = UIImage(named: "in_calendar")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem1.title = ""
        myTabBarItem1.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let myTabBarItem2 = (tabBar.items?[2])! as UITabBarItem
        myTabBarItem2.image = UIImage(named: "in_personUnselected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.selectedImage = UIImage(named: "in_person")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.title = ""
        myTabBarItem2.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        tabBar.tintColor = UIColor.black
    }
    
    //------------------------------------------
    //MARK: - API Methods -
    //------------------------------------------
    //MARK: - Action Methods -
}
