//
//  DetailViewController.swift
//  SlideshowApp
//
//  Created by Masaharu Hoshino (Work) on 2022/11/04.
//

import UIKit

class DetailViewController: UIViewController {
    
    // 拡大画像の接続
    @IBOutlet weak var enlargedImageView: UIImageView!
    // 表示する画像
    var enlargedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 遷移元で表示されていた画像を拡大表示する
        enlargedImageView.image = enlargedImage
    }
    
    // 画面の回転を止める
    override var shouldAutorotate: Bool {
        return false
    }
    // Portrait画面固定とする
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
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
