//
//  ConversationManager.swift
//  tencent_im_sdk_plugin
//
//  Created by 林智 on 2020/12/24.
//

import Foundation
import ImSDK_Plus

class SignalingManager {
	var channel: FlutterMethodChannel

	private var signalingListener = SignalingListener();
	
	init(channel: FlutterMethodChannel) {
		self.channel = channel
	}

	public func invite(call: FlutterMethodCall, result: @escaping FlutterResult) {
		let v2TIMOfflinePushInfo = CommonUtils.getV2TIMOfflinePushInfo(call: call, result: result)

		if var invitee = CommonUtils.getParam(call: call, result: result, param: "invitee") as? String,
			let data = CommonUtils.getParam(call: call, result: result, param: "data") as? String,
			let timeout = CommonUtils.getParam(call: call, result: result, param: "timeout") as? Int32,
			let onlineUserOnly = CommonUtils.getParam(call: call, result: result, param: "onlineUserOnly") as? Bool {
			var inviteID = ""
			//	invitee为""crash，" "可以走到fail
			invitee = (invitee == "") ? " " : invitee
			inviteID = V2TIMManager.sharedInstance().invite(invitee, data: data, onlineUserOnly: onlineUserOnly, offlinePushInfo: v2TIMOfflinePushInfo, timeout: timeout, succ: {
				() -> Void in
				CommonUtils.resultSuccess(call: call, result: result, data: inviteID)
			}, fail: TencentImUtils.returnErrorClosures(call: call, result: result))
		}
	}

	public func inviteInGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
		if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String,
			let inviteeList = CommonUtils.getParam(call: call, result: result, param: "inviteeList") as? Array<String>,
			let data = CommonUtils.getParam(call: call, result: result, param: "data") as? String,
			let timeout = CommonUtils.getParam(call: call, result: result, param: "timeout") as? Int32,
			let onlineUserOnly = CommonUtils.getParam(call: call, result: result, param: "onlineUserOnly") as? Bool {
			var inviteID = ""
			//	inviteeList为空数组crash，非空可以走到fail
			if inviteeList.count == 0 {
				return CommonUtils.resultFailed(desc: "InviteeList can not be empty", code: -1, call: call, result: result)
			}
			inviteID = V2TIMManager.sharedInstance().invite(inGroup: groupID, inviteeList: inviteeList, data: data, onlineUserOnly: onlineUserOnly, timeout: timeout, succ: {
				() -> Void in
				CommonUtils.resultSuccess(call: call, result: result, data: inviteID)
			}, fail: TencentImUtils.returnErrorClosures(call: call, result: result))
		}
	}

	public func cancel(call: FlutterMethodCall, result: @escaping FlutterResult) {
		if let inviteID = CommonUtils.getParam(call: call, result: result, param: "inviteID") as? String,
			let data = CommonUtils.getParam(call: call, result: result, param: "data") as? String {

			V2TIMManager.sharedInstance().cancel(inviteID, data: data, succ: {
				() -> Void in
				CommonUtils.resultSuccess(call: call, result: result, data: "ok");
			}, fail: TencentImUtils.returnErrorClosures(call: call, result: result))
		}
	}

	public func accept(call: FlutterMethodCall, result: @escaping FlutterResult) {
		if let inviteID = CommonUtils.getParam(call: call, result: result, param: "inviteID") as? String,
			let data = CommonUtils.getParam(call: call, result: result, param: "data") as? String {
				
			V2TIMManager.sharedInstance().accept(inviteID, data: data, succ: {
				() -> Void in
				CommonUtils.resultSuccess(call: call, result: result, data: "ok");
			}, fail: TencentImUtils.returnErrorClosures(call: call, result: result))
		}
	}

	public func reject(call: FlutterMethodCall, result: @escaping FlutterResult) {
		if let inviteID = CommonUtils.getParam(call: call, result: result, param: "inviteID") as? String,
			let data = CommonUtils.getParam(call: call, result: result, param: "data") as? String {
				
			V2TIMManager.sharedInstance().reject(inviteID, data: data, succ: {
				() -> Void in
				CommonUtils.resultSuccess(call: call, result: result, data: "ok");
			}, fail: TencentImUtils.returnErrorClosures(call: call, result: result))
		}
	}

	// TODO:待原生sdk和安卓开发完成再行添加
	public func getSignallingInfo(call: FlutterMethodCall, result: @escaping FlutterResult) {
		// if let nextSeq = CommonUtils.getParam(call: call, result: result, param: "nextSeq") as? UInt64,
		// 	let count = CommonUtils.getParam(call: call, result: result, param: "count") as? Int32 {
		// 	V2TIMManager.sharedInstance().getSignallingInfo(nextSeq, count: count, succ: {
		// 		conversations, nextSeq, finished in
				
		// 		let dict = V2ConversationResultEntity.init(conversations: conversations!, nextSeq: nextSeq, finished: finished).getDict();
		// 		CommonUtils.resultSuccess(call: call, result: result, data: dict);
		// 	}, fail: TencentImUtils.returnErrorClosures(call: call, result: result))
		// }
	}
	
	// TODO:待原生sdk和安卓开发完成再行添加
	public func addInvitedSignaling(call: FlutterMethodCall, result: @escaping FlutterResult) {
		// if let nextSeq = CommonUtils.getParam(call: call, result: result, param: "nextSeq") as? UInt64,
		// 	let count = CommonUtils.getParam(call: call, result: result, param: "count") as? Int32 {
		// 	V2TIMManager.sharedInstance().addInvitedSignaling(nextSeq, count: count, succ: {
		// 		conversations, nextSeq, finished in
				
		// 		let dict = V2ConversationResultEntity.init(conversations: conversations!, nextSeq: nextSeq, finished: finished).getDict();
		// 		CommonUtils.resultSuccess(call: call, result: result, data: dict);
		// 	}, fail: TencentImUtils.returnErrorClosures(call: call, result: result))
		// }
	}


}
