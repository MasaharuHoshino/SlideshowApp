//
//  ViewController.swift
//  SlideshowApp
//
//  Created by Masaharu Hoshino (Work) on 2022/11/04.
//

import UIKit

class ViewController: UIViewController {
    
    // 画像の接続
    @IBOutlet weak var imageView: UIImageView!
    // 進むボタンの接続
    @IBOutlet weak var forwardButton: UIButton!
    // 戻るボタンの接続
    @IBOutlet weak var backButton: UIButton!
    // 再生/停止ボタンの接続
    @IBOutlet weak var playOrStopButton: UIButton!
    
    // 使用画像の配列
    var imageArray:[UIImage] = [
        UIImage(named: "image1")!,
        UIImage(named: "image2")!,
        UIImage(named: "image3")!,
        UIImage(named: "image4")!
    ]
    
    // 使用画像の配列に指定するインデックス番号を初期化
    var currentIndex = 0
    
    // スライドショーのタイマー
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // インデックス番号0の画像を表示する
        imageView.image = imageArray[currentIndex]
    }
    
    // 画面タップでのアクション IBAction
    @IBAction func tapAction(_ sender: Any) {
        if self.timer != nil {  // タイマーが存在する場合の処理
            // タイマーを停止する
            self.timer.invalidate()

            // playOrStop() の self.timer == nil で判断するために、 self.timer = nil としておく
            self.timer = nil

            // 停止ボタンの表示名を「再生」に変更する
            self.playOrStopButton.setTitle("再生", for: .normal)

            // 進むボタンを有効化する
            self.forwardButton.isEnabled = true

            // 戻るボタンを有効化する
            self.backButton.isEnabled = true
        }
        // 画面遷移のsegueを実行
        performSegue(withIdentifier: "toDetailView", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueから遷移先のDetailViewControllerを取得する
        let detailViewController:DetailViewController = segue.destination as! DetailViewController
        // 遷移先のDetailViewControllerで宣言しているenlargedImageViewに、現在表示されている画像を渡す
        detailViewController.enlargedImage = imageArray[currentIndex]
    }
    
    // 進むボタン IBAction
    @IBAction func goForward(_ sender: Any) {
        // 画像を昇順で切り替える
        self.changeImageAscendingly()
    }
    
    // 戻るボタン IBAction
    @IBAction func goBack(_ sender: Any) {
        // 画像を昇順で切り替える
        self.changeImageDescendingly()
    }
    
    // 再生/停止ボタン IBAction
    @IBAction func playOrStop(_ sender: Any) {
        if self.timer == nil{   // タイマーが存在しない場合の処理
            // 再生ボタンを押すとタイマー作成、始動
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeImageAscendingly), userInfo: nil, repeats: true)
            
            // 再生ボタンの表示名を「停止」に変更する
            self.playOrStopButton.setTitle("停止", for: .normal)
            
            // 進むボタンを無効化する
            self.forwardButton.isEnabled = false
            
            // 戻るボタンを無効化する
            self.backButton.isEnabled = false
        }else{  // タイマーが存在する場合の処理
            // タイマーを停止する
            self.timer.invalidate()
            
            // playOrStop() の self.timer == nil で判断するために、 self.timer = nil としておく
            self.timer = nil
            
            // 停止ボタンの表示名を「再生」に変更する
            playOrStopButton.setTitle("再生", for: .normal)
            
            // 進むボタンを有効化する
            forwardButton.isEnabled = true
            
            // 戻るボタンを有効化する
            backButton.isEnabled = true
        }
    }
    
    // selector: #selector(changeImage(_:)) で指定された関数
    // 画像を切り替える関数（インデックス番号昇順）
    @objc func changeImageAscendingly(){
        // 画像のインデックス番号を更新する
        currentIndex += 1
        
        // 最後の画像が表示されていた場合はインデックス番号を0に戻す
        if currentIndex == imageArray.count {
            currentIndex = 0
        }
        
        // インデックス番号に該当する画像を表示する
        imageView.image = imageArray[currentIndex]
    }
    
    // 画像を切り替える関数（インデックス番号降順）
    func changeImageDescendingly(){
        if currentIndex == 0 {  // 最初の画像が表示されていた場合はインデックス番号を最後の画像のものにする
            currentIndex = imageArray.count - 1
        }else{
            // 画像のインデックス番号を更新する
            currentIndex -= 1
        }
        
        // インデックス番号に該当する画像を表示する
        imageView.image = imageArray[currentIndex]
    }
    
    // 遷移先から戻るsegue
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
    // 画面の回転を止める
    override var shouldAutorotate: Bool {
        return false
    }
    
    // Portrait画面固定とする
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
}

