package huatech.plugin.sso;

import android.app.Activity;
import android.content.Intent;

import com.wisedu.idsauthsdk.IdsAuthActivity;
import com.wisedu.idsauthsdk.IdsLogOutUtil;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaArgs;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;


public class SsoPlugin extends CordovaPlugin implements IdsLogOutUtil.OnLogOutListener {
    private static final String oauthUrl = "http://authserver.sxmu.edu.cn/authserver";//ids授权地址
    private static final String oauthAppId = "561180257";//学校appid
    private CallbackContext callbackContext;
    private static String token = "";
    private IdsLogOutUtil idsLogOutUtil;
    private static final int GET_TOKEN_REQUEST = 1;

    @Override
    public boolean execute(String action, CordovaArgs args, CallbackContext callbackContext) throws JSONException {

        this.callbackContext = callbackContext;

        if (action.equals("getSsoToken")) {
            Intent intent = new Intent(this.cordova.getActivity(), IdsAuthActivity.class);
            intent.putExtra("oauthUrl", oauthUrl);
            intent.putExtra("oauthAppId", oauthAppId);
            cordova.setActivityResultCallback(this);

            PluginResult pluginResult = new PluginResult(PluginResult.Status.NO_RESULT);
            pluginResult.setKeepCallback(true);
            callbackContext.sendPluginResult(pluginResult);
            cordova.startActivityForResult(SsoPlugin.this, intent, GET_TOKEN_REQUEST);
            return true;

        } else if (action.equals("logoutToken")) {
            if (!token.equals("")) {
                idsLogOutUtil = new IdsLogOutUtil();
                idsLogOutUtil.sendLogOut(oauthUrl, oauthAppId, token, SsoPlugin.this);
                return true;
            }
        }
        return false;

    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (resultCode == Activity.RESULT_OK) {
            switch (requestCode) {
                case GET_TOKEN_REQUEST:
                    String userProfileStr = data.getStringExtra("userProfile");
                    token = data.getStringExtra("token");
                    JSONArray array = new JSONArray();
                    array.put(userProfileStr);
                    array.put(token);
                    callbackContext.success(array);
                    break;
                default:
                    break;
            }
        }
    }

    /**
     * 注销返回参数  返回状态为1表示注销成功，其他表示未成功
     */
    @Override
    public void logOutAction(String callBackStr) {
        this.callbackContext.success(callBackStr);
    }

}
