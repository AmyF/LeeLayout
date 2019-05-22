//
//  LayoutManage.swift
//  writer
//
//  Created by Lee on 2018/4/18.
//  Copyright © 2018年 Lee. All rights reserved.
//
import Foundation
#if os(macOS)
import Cocoa
public typealias LayoutManagePriority = NSLayoutConstraint.Priority
public typealias LayoutManageView = NSView
public typealias LayoutManageEdgeInsets = NSEdgeInsets
#elseif os(iOS) || os(tvOS)
import UIKit
public typealias LayoutManagePriority = UILayoutPriority
public typealias LayoutManageView = UIView
public typealias LayoutManageEdgeInsets = UIEdgeInsets
#endif

#if os(macOS)
extension NSView{
    /// 约束管理类
    open var layoutManage: LayoutManage{
        return LayoutManage(view: self);
    }
}
#elseif os(iOS) || os(tvOS)
@available(iOS 9.0, OSX 10.11, *)
extension UIView{
    /// 约束管理类
    open var layoutManage: LayoutManage{
        return LayoutManage(view: self);
    }
    
    //MARK: IOS11的约束点属性
    @available(iOS 11.0, *)
    open var safeWidthAnchor: NSLayoutDimension  { get { return safeAreaLayoutGuide.widthAnchor }}
    @available(iOS 11.0, *)
    open var safeHeightAnchor: NSLayoutDimension  { get {return safeAreaLayoutGuide.heightAnchor} }
    @available(iOS 11.0, *)
    open var safeTopAnchor: NSLayoutYAxisAnchor { get {return safeAreaLayoutGuide.topAnchor} }
    @available(iOS 11.0, *)
    open var safeBottomAnchor: NSLayoutYAxisAnchor { get {return safeAreaLayoutGuide.bottomAnchor} }
    @available(iOS 11.0, *)
    open var safeRightAnchor: NSLayoutXAxisAnchor { get {return safeAreaLayoutGuide.rightAnchor}}
    @available(iOS 11.0, *)
    open var safeLeftAnchor: NSLayoutXAxisAnchor { get {return safeAreaLayoutGuide.leftAnchor}}
    @available(iOS 11.0, *)
    open var safeCenterXAnchor: NSLayoutXAxisAnchor { get {return safeAreaLayoutGuide.centerXAnchor}}
    @available(iOS 11.0, *)
    open var safeCenterYAnchor: NSLayoutYAxisAnchor { get {return safeAreaLayoutGuide.centerYAnchor}}
    @available(iOS 11.0, *)
    open var safeLeadingAnchor: NSLayoutXAxisAnchor { get {return safeAreaLayoutGuide.leadingAnchor}}
    @available(iOS 11.0, *)
    open var safeTrailingAnchor: NSLayoutXAxisAnchor { get {return safeAreaLayoutGuide.trailingAnchor}}
}
#endif

/// 约束管理类
@available(iOS 9.0, OSX 10.11, *)
open class LayoutManage {
    /// 被管理的视图
    public let view: LayoutManageView!;
    
    /// 待执行的约束列表
    open var layoutConstraintList: [NSLayoutConstraint] = [];
    
    /// 初始化
    ///
    /// - Parameter view: 被管理的视图
    init(view: LayoutManageView) {
        self.view = view;
    }
    
    /// 边界约束
    ///
    /// - Parameters:
    ///   - aView: 相对视图（nil表示相对父对象）
    ///   - insets: 约束相对位置（nil表示铺满约束）
    /// - Returns: 约束管理对象
    open func setEdges(with aView: LayoutManageView? = nil, insets: LayoutManageEdgeInsets? = nil) -> LayoutManage {
        let tempInsets = (insets ?? LayoutManageEdgeInsets(top: 0, left: 0, bottom: 0, right: 0));
        if let tempView = aView ?? self.view.superview{// 被约束对象
            self.top(equalTo: tempView.topAnchor, constant: tempInsets.top).trailing(equalTo: tempView.trailingAnchor, constant: -tempInsets.right).leading(equalTo: tempView.leadingAnchor, constant: tempInsets.left).bottom(equalTo: tempView.bottomAnchor, constant: -tempInsets.bottom).end();
        }
        return self
    }
    
    /// 居中约束
    ///
    /// - Parameter aView: 相对的对象（nil表示相对父对象）
    open func setCenter(with aView: LayoutManageView? = nil) -> LayoutManage {
        if let tempView = aView ?? self.view.superview{
            self.centerX(equalTo: tempView.centerXAnchor).centerY(equalTo: tempView.centerYAnchor).end();
        }
        return self
    }
    
    /// 约束视图的宽度
    ///
    /// - Parameters:
    ///   - width: 值
    ///   - priority: 优先级（nil表示默认）
    /// - Returns: 约束管理对象
    open func width(_ width: CGFloat, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.widthAnchor.constraint(equalToConstant: width).insert(self, priority);
        return self
    }
    
    /// 约束视图的高度
    ///
    /// - Parameters:
    ///   - width: 值
    ///   - priority: 优先级（nil表示默认）
    /// - Returns: 约束管理对象
    open func height(_ height: CGFloat, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.heightAnchor.constraint(equalToConstant: height).insert(self, priority);
        return self
    }
    
    //MARK: 约束的倍数、值以及优先级
    open func width(equalTo aAnchor: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.widthAnchor.constraint(equalTo: aAnchor, multiplier: multiplier, constant: constant).insert(self, priority);
        return self
    }
    open func height(equalTo aAnchor: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.heightAnchor.constraint(equalTo: aAnchor, multiplier: multiplier, constant: constant).insert(self, priority);
        return self
    }
    open func top(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.topAnchor.constraint(equalTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func bottom(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.bottomAnchor.constraint(equalTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func left(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.leftAnchor.constraint(equalTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func right(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.rightAnchor.constraint(equalTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func leading(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.leadingAnchor.constraint(equalTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func trailing(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.trailingAnchor.constraint(equalTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func centerX(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.centerXAnchor.constraint(equalTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func centerY(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.centerYAnchor.constraint(equalTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func firstBaseline(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.firstBaselineAnchor.constraint(equalTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func lastBaseline(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.lastBaselineAnchor.constraint(equalTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    
    //MARK: lessThanOrEqualTo 和 constant
    open func width(lessThanOrEqualTo aAnchor: NSLayoutDimension, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.widthAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func height(lessThanOrEqualTo aAnchor: NSLayoutDimension, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.heightAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func top(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.topAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func bottom(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.bottomAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func left(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.leftAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func right(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.rightAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func leading(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.leadingAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func trailing(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.trailingAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func centerX(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.centerXAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func centerY(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.centerYAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func firstBaseline(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.firstBaselineAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func lastBaseline(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.lastBaselineAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    
    //MARK: greaterThanOrEqualTo 和 constant
    open func width(greaterThanOrEqualTo aAnchor: NSLayoutDimension, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.widthAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func height(greaterThanOrEqualTo aAnchor: NSLayoutDimension, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.heightAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func top(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.topAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func bottom(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.bottomAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func left(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.leftAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func right(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.rightAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func leading(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.leadingAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func trailing(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.trailingAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func centerX(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.centerXAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func centerY(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.centerYAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func firstBaseline(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.firstBaselineAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    open func lastBaseline(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: LayoutManagePriority? = nil) -> LayoutManage {
        self.view.lastBaselineAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).insert(self, priority);
        return self
    }
    
    /// 析构方法
    deinit {
        self.end();// 设置活跃状态
    }
    
    /// 批量设置约束的活动状态
    open func activate() -> LayoutManage{
        if self.layoutConstraintList.count > 0{
            self.view.translatesAutoresizingMaskIntoConstraints = false;// 取消视图的自动约束
            NSLayoutConstraint.activate(self.layoutConstraintList);
            self.layoutConstraintList = [];
        }
        return self;
    }
    
    /// 结束约束
    open func end(){
        let _ = self.activate();
    }
    
    /// 空方法，不执行任何过程
    open func over(){}
}

@available(iOS 9.0, OSX 10.11, *)
extension NSLayoutConstraint {
    #if os(macOS)
    /// 反向插入到约束管理对象中
    ///
    /// - Parameters:
    ///   - layoutManage: 约束管理对象
    ///   - priority: 优先级
    open func insert(_ layoutManage: LayoutManage, _ priority: NSLayoutConstraint.Priority?) {
        if let _priority = priority{// 设置优先级
            self.priority = _priority;
        }
        layoutManage.layoutConstraintList.append(self);
    }
    #elseif os(iOS) || os(tvOS)
    /// 反向插入到约束管理对象中
    ///
    /// - Parameters:
    ///   - layoutManage: 约束管理对象
    ///   - priority: 优先级
    open func insert(_ layoutManage: LayoutManage, _ priority: UILayoutPriority?) {
        if let _priority = priority{// 设置优先级
            self.priority = _priority;
        }
        layoutManage.layoutConstraintList.append(self);
    }
    #endif
}
