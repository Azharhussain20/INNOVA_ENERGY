import UIKit
struct Item {
    let image: UIImage
    let title: String
}
class IntroductionScreen: UIViewController {
    
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var introductionCollection: UICollectionView!
    @IBOutlet weak var btnLoginWithGoogle: WhiteButtonWithImage!
    @IBOutlet weak var btnLoginWithApple: WhiteButtonWithImage!
    @IBOutlet weak var btnRegistration: GreenThemeButton!
    @IBOutlet weak var btnLogin: PlainTextButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //------------------------------------------
    //MARK: - Class Variables -
    var items: [Item] = []
    
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
    //MARK: - API Methods -
    //------------------------------------------
    
    //------------------------------------------
    //MARK: - View Life Cycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        introductionCollectionSetup()
        globalActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
    }
    
    //------------------------------------------
    //MARK: - Custom Methods -
    func introductionCollectionSetup() {
        let item1 = Item(image: UIImage(named: "in_transperant")!, title: "Welcome to Innova! To start using the app, you need to create a home or be invited to an existing home".localize())
        let item2 = Item(image: UIImage(named: "in_addRoom")!, title: "Choose in which room to place your devices and organize your virtual home in a few steps".localize())
        let item3 = Item(image: UIImage(named: "in_emptyDashboard")!, title: "It looks like there are no devices in this home".localize())
        
        items.append(item1)
        items.append(item2)
        items.append(item3)
        
        introductionCollection.register(UINib(nibName: "IntroductionCell", bundle: nil), forCellWithReuseIdentifier: "IntroductionCell")
        introductionCollection.delegate = self
        introductionCollection.dataSource = self
    }
    
    func updatePageControl() {
        let currentPage = Int(introductionCollection.contentOffset.x / introductionCollection.frame.size.width)
        pageControl.currentPage = currentPage
    }
    
    //MARK: - Action Methods -
    @IBAction func btnOkAction(_ sender: UIButton) {
    }
    
    func globalActions() {
        btnLoginWithGoogle.touchUpInside = {
            print("btnLoginWithGoogle")
        }
        btnLoginWithApple.touchUpInside = {
            print("btnLoginWithApple")
        }
        btnRegistration.touchUpInside = {
            print("btnRegistration")
        }
        btnLogin.touchUpInside = {
            print("btnLogin")
            let initiliazeVC : CreateHomeViewController = Utilities.viewController(name: "CreateHomeViewController", onStoryboard: "Introduction") as! CreateHomeViewController
            self.navigationController!.pushViewController(initiliazeVC, animated: true)
        }
    }
}

//------------------------------------------
//MARK: - Collection Delegates -
extension IntroductionScreen : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntroductionCell", for: indexPath) as! IntroductionCell
        let item = items[indexPath.item]
        cell.lblTitle.text = item.title
        cell.imgIntro.image = item.image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updatePageControl()
    }
}
