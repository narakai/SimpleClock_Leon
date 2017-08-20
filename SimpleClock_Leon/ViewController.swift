//
//  ViewController.swift
//  SimpleClock_Leon
//
//  Created by lai leon on 2017/8/20.
//  Copyright © 2017 clem. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    //let 不变量
    let showLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: YHScreenRectWidth, height: YHScreenRectHeight / 2))
    let leftBtn = UIButton(frame: CGRect(x: 0.0, y: YHScreenRectHeight / 2, width: YHScreenRectWidth / 2, height: YHScreenRectHeight / 2))
    let rightBtn = UIButton(frame: CGRect(x: YHScreenRectWidth / 2, y: YHScreenRectHeight / 2, width: YHScreenRectWidth / 2, height: YHScreenRectHeight / 2))

    //var 变量
    var timer: Timer?
    var n = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //添加界面
        setupView()
    }


    private func setupView() {
        showLabel.backgroundColor = .cyan
        leftBtn.backgroundColor = .purple
        rightBtn.backgroundColor = .lightGray

        leftBtn.setTitle("开始", for: .normal)
        leftBtn.setTitle("结束", for: .selected)
        leftBtn.setTitleColor(.red, for: .selected)
        leftBtn.setTitleColor(.white, for: .normal)

        rightBtn.setTitle("暂停", for: .normal)
        rightBtn.setTitle("继续", for: .selected)
        rightBtn.setTitleColor(.red, for: .selected)
        rightBtn.setTitleColor(.white, for: .normal)

        [leftBtn, rightBtn].forEach {
            ($0.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside))
        }

        showLabel.text = "0"
        showLabel.textColor = .brown
        showLabel.font = UIFont.systemFont(ofSize: YHScreenRectHeight / 4)
        showLabel.textAlignment = .center

        view.addSubview(showLabel)
        view.addSubview(leftBtn)
        view.addSubview(rightBtn)


    }

    func buttonTapped(sender: UIButton) {
        switch sender {
        case leftBtn:
            leftBtn.isSelected = !leftBtn.isSelected
            leftBtn.isSelected ? begin() : stop()
        case rightBtn:
            if (!leftBtn.isSelected) {
                return
            }
            rightBtn.isSelected = !rightBtn.isSelected
            rightBtn.isSelected ? pause() : continueMe()
        default:
            break
        }
    }

    private func begin() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
    }

    private func stop() {
        showLabel.text = "0"
        timer?.invalidate()
        timer = nil
        rightBtn.isSelected = false
        n = 0
    }

    private func pause() {
        timer?.invalidate()
        timer = nil
    }

    private func continueMe() {
        begin()
    }


    func updateLabel() {
        n += 1
        showLabel.text = String(n)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
