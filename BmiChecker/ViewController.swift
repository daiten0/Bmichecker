//
//  ViewController.swift
//  BmiChecker
//
//  Created by daisuke on 2019/05/27.
//  Copyright © 2019 Daisuke Kojyou. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //プレースホルダーを設定
        heightText.placeholder = "身長を入力してください"
        //プレースホルダーを設定
        weightText.placeholder = "体重を入力してください"
        //delegateを設定
        heightText.delegate = self
        weightText.delegate = self
    }

    //身長を入力するフィールド
    @IBOutlet weak var heightText: UITextField!
    //体重を入力するフィールド
    @IBOutlet weak var weightText: UITextField!
    //BMI値を表示
    @IBOutlet weak var bmiResultLabel: UILabel!
    //アドバイスを表示
    @IBOutlet weak var adviceLabel: UILabel!
    //画像を表示
    @IBOutlet weak var imageView: UIImageView!
    //エラーメッセージを表示
    @IBOutlet weak var errorText: UILabel!
    
    //各身長、体重の入力で完了を押した場合にキーボードを閉じる処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        heightText.resignFirstResponder()
        weightText.resignFirstResponder()
        return true
    }
    
    //BMIを求めるメソッドを定義
    func bmi(height: Double, weight:Double) -> Double {
        let bmiValue = weight / pow((height * 0.1), 2) * 100
        return bmiValue
    }
    
    //BMIを求めるボタン
    @IBAction func tapBmiButton(_ sender: UIButton) {
        //String型のheightTextをDouble型に変換、Double型以外の場合はエラーメッセージを返す
        let heightString = heightText.text!
        guard let heightDouble = Double(heightString)  else {
            errorText.text = "BMIを求めることができません"
            return
        }
        //String型のweightTextをDouble型に変換し、Double型以外の場合はエラーメッセージを返す
        let weightString = weightText.text!
        guard let weightDouble = Double(weightString) else {
            errorText.text = "BMIを求めることができません"
            return
        }
        //上記変換が無事できた場合はエラーメッセージを削除
        errorText.text = ""
        let result = bmi(height: heightDouble, weight: weightDouble)
        let resultRound = round(result * 10)/10 //少数第二位で四捨五入
        bmiResultLabel.text = String(resultRound) + "です"
        //BMIの値ごとにアドバイス、画像を表示
        if result < 18.5 {
            adviceLabel.text = "痩せぎみです。食事の量を増やしましょう！"
            imageView.image = UIImage(named: "syokuji")
            
        } else if result < 25 {
            adviceLabel.text = "健康的です。この調子でいきましょう！"
            imageView.image = UIImage(named: "genki")
            
        } else {
            adviceLabel.text = "太りぎみです。運動しましょう!"
            imageView.image = UIImage(named: "undou")
        }
    }    
}



