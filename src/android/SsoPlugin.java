package huatech.plugin.sso;

import com.wisedu.idsauthsdk.IdsAuthActivity;
import com.wisedu.idsauthsdk.IdsLogOutUtil;

import org.apache.cordova.CordovaArgs;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONException;

import android.content.Intent;
import android.app.Activity;

import org.json.JSONArray;


public class SsoPlugin extends CordovaPlugin implements IdsLogOutUtil.OnLogOutListener {
    private static final String oauthUrl = "http://authserver.sxmu.edu.cn/authserver";//ids授权地址
    private static final String oauthAppId = "803934561";//学校appid
    private CallbackContext callbackContext;
    private String token = "";
    private IdsLogOutUtil idsLogOutUtil;

    @Override
    public boolean execute(String action, CordovaArgs args, CallbackContext callbackContext) throws JSONException {

        this.callbackContext = callbackContext;

        if (action.equals("getSsoToken")) {
            Intent intent = new Intent(this.cordova.getActivity(), IdsAuthActivity.class);
            intent.putExtra("oauthUrl", oauthUrl);
            intent.putExtra("oauthAppId", oauthAppId);
            this.cordova.getActivity().startActivityForResult(intent, 1);
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
                case 1:
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
//        userProfile.setText("注销：\n"+callBackStr);
    }

}
