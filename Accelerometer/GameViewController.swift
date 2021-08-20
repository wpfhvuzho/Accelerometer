//
//  GameViewController.swift
//  Accelerometer
//
//  Created by 高橋　龍 on 2021/08/20.
//

import UIKit
import CoreMotion

class GameViewController: UIViewController {
    
    @IBOutlet var awaImageView: UIImageView!
    
    let motionManager = CMMotionManager()
    var acclerationX: Double = 0.0
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultViewController:ResultViewController = segue.destination as! ResultViewController
        resultViewController.accelerationX = self.acclerationX
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //加速度計が使えるかどうか判定
        if motionManager.isAccelerometerAvailable {
            //加速度の取得間隔を設定
            motionManager.accelerometerUpdateInterval = 0.01
            //加速度が更新された時に呼ばれる関数
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { data, error in
                
                //現在の加速度に基づき、awaImageViewの座標を更新
                self.acclerationX = (data?.acceleration.x)!
                self.awaImageView.center.x += CGFloat(self.acclerationX*20)
                
                //水平器からはみ出さないよう、限界を設定
                if self.awaImageView.frame.origin.x < 40 {
                    self.awaImageView.frame.origin.x = 40
                }
                if self.awaImageView.frame.origin.x > 260 {
                    self.awaImageView.frame.origin.x = 260
                }
            }
        }

        // Do any additional setup after loading the view.
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
