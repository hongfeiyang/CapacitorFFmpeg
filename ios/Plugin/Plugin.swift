import Foundation
import Capacitor
import mobileffmpeg

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(FFmpeg)
public class FFmpeg: CAPPlugin, ExecuteDelegate {
    
    private var execCall: CAPPluginCall?
    
    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.success([
            "value": value
        ])
    }
    
    @objc func exec(_ call: CAPPluginCall) {
        let command = call.getString("command") ?? ""
        self.execCall = call
        MobileFFmpeg.executeAsync(command, withCallback: self)
    }
    
    public func executeCallback(_ executionId: Int, _ returnCode: Int32) {
        let output = MobileFFmpegConfig.getLastCommandOutput()
        var responseToUser: String
        var status: String
        if (returnCode == RETURN_CODE_SUCCESS) {
            responseToUser = "success out=\(output ?? "")"
            status = "SUCCESS"
        } else if (returnCode == RETURN_CODE_CANCEL) {
            responseToUser = "canceled"
            status = "CANCELED"
        } else {
            responseToUser = "failure code=\(returnCode) out=\(output ?? "")"
            status = "ERROR"
        }
        guard let call = execCall else { return }
        call.success([
            "result": responseToUser,
            "returnCode": returnCode,
            "status": status
        ])
        execCall = nil
    }
    
    
}
