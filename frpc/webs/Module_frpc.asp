﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- version: 2.1.4 -->
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<meta HTTP-EQUIV="Expires" CONTENT="-1"/>
<link rel="shortcut icon" href="images/favicon.png"/>
<link rel="icon" href="images/favicon.png"/>
<title>软件中心 - Frp内网穿透</title>
<link rel="stylesheet" type="text/css" href="index_style.css"/> 
<link rel="stylesheet" type="text/css" href="form_style.css"/>
<link rel="stylesheet" type="text/css" href="css/element.css">
<script language="JavaScript" type="text/javascript" src="/state.js"></script>
<script language="JavaScript" type="text/javascript" src="/help.js"></script>
<script language="JavaScript" type="text/javascript" src="/general.js"></script>
<script language="JavaScript" type="text/javascript" src="/popup.js"></script>
<script language="JavaScript" type="text/javascript" src="/client_function.js"></script>
<script language="JavaScript" type="text/javascript" src="/validator.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/switcherplugin/jquery.iphone-switch.js"></script>
<script type="text/javascript" src="/dbconf?p=frpc&v=<% uptime(); %>"></script>
<style> .Bar_container {
    width:85%;
    height:20px;
    border:1px inset #999;
    margin:0 auto;
    margin-top:20px \9;
    background-color:#FFFFFF;
    z-index:100;
}
#proceeding_img_text {
    position:absolute;
    z-index:101;
    font-size:11px;
    color:#000000;
    line-height:21px;
    width: 83%;
}
#proceeding_img {
    height:21px;
    background:#C0D1D3 url(/images/ss_proceding.gif);
}

.frpc_btn {
    border: 1px solid #222;
    background: linear-gradient(to bottom, #003333  0%, #000000 100%); /* W3C */
    font-size:10pt;
    color: #fff;
    padding: 5px 5px;
    border-radius: 5px 5px 5px 5px;
    width:16%;
}
.frpc_btn:hover {
    border: 1px solid #222;
    background: linear-gradient(to bottom, #27c9c9  0%, #279fd9 100%); /* W3C */
    font-size:10pt;
    color: #fff;
    padding: 5px 5px;
    border-radius: 5px 5px 5px 5px;
    width:16%;
}

input[type=button]:focus {
    outline: none;
}
</style>
<script>
var noChange_status = 0;
var _responseLen;
var Base64;
if(typeof btoa == "Function") {
   Base64 = {encode:function(e){ return btoa(e); }, decode:function(e){ return atob(e);}};
} else {
   Base64 ={_keyStr:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",encode:function(e){var t="";var n,r,i,s,o,u,a;var f=0;e=Base64._utf8_encode(e);while(f<e.length){n=e.charCodeAt(f++);r=e.charCodeAt(f++);i=e.charCodeAt(f++);s=n>>2;o=(n&3)<<4|r>>4;u=(r&15)<<2|i>>6;a=i&63;if(isNaN(r)){u=a=64}else if(isNaN(i)){a=64}t=t+this._keyStr.charAt(s)+this._keyStr.charAt(o)+this._keyStr.charAt(u)+this._keyStr.charAt(a)}return t},decode:function(e){var t="";var n,r,i;var s,o,u,a;var f=0;e=e.replace(/[^A-Za-z0-9\+\/\=]/g,"");while(f<e.length){s=this._keyStr.indexOf(e.charAt(f++));o=this._keyStr.indexOf(e.charAt(f++));u=this._keyStr.indexOf(e.charAt(f++));a=this._keyStr.indexOf(e.charAt(f++));n=s<<2|o>>4;r=(o&15)<<4|u>>2;i=(u&3)<<6|a;t=t+String.fromCharCode(n);if(u!=64){t=t+String.fromCharCode(r)}if(a!=64){t=t+String.fromCharCode(i)}}t=Base64._utf8_decode(t);return t},_utf8_encode:function(e){e=e.replace(/\r\n/g,"\n");var t="";for(var n=0;n<e.length;n++){var r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r)}else if(r>127&&r<2048){t+=String.fromCharCode(r>>6|192);t+=String.fromCharCode(r&63|128)}else{t+=String.fromCharCode(r>>12|224);t+=String.fromCharCode(r>>6&63|128);t+=String.fromCharCode(r&63|128)}}return t},_utf8_decode:function(e){var t="";var n=0;var r=c1=c2=0;while(n<e.length){r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r);n++}else if(r>191&&r<224){c2=e.charCodeAt(n+1);t+=String.fromCharCode((r&31)<<6|c2&63);n+=2}else{c2=e.charCodeAt(n+1);c3=e.charCodeAt(n+2);t+=String.fromCharCode((r&15)<<12|(c2&63)<<6|c3&63);n+=3}}return t}}
}

function E(e) {
    return (typeof(e) == 'string') ? document.getElementById(e) : e;
}

function init() {
    show_menu(menu_hook);
    get_status();
    conf_to_obj();
    buildswitch();
    toggle_switch();
    version_show();
}

function get_status() {
    $.ajax({
        url: 'apply.cgi?current_page=Module_frpc.asp&next_page=Module_frpc.asp&group_id=&modified=0&action_mode=+Refresh+&action_script=&action_wait=&first_time=&preferred_lang=CN&SystemCmd=frpc_status.sh',
        dataType: 'html',
        error: function(xhr) {
            alert("error");
        },
        success: function(response) {
            //alert("success");
            setTimeout("check_FRPC_status();", 1000);
        }
    });
}


function check_FRPC_status() {
    $.ajax({
        url: '/res/frpc_check.html',
        dataType: 'html',

        error: function(xhr) {
            setTimeout("check_FRPC_status();", 1000);
        },
        success: function(response) {
            var _cmdBtn = E("cmdBtn");
            if (response.search("XU6J03M6") != -1) {
                frpc_status = response.replace("XU6J03M6", " ");
                //alert(frpc_status);
                E("status").innerHTML = frpc_status;
                return true;
            }

            if (_responseLen == response.length) {
                noChange_status++;
            } else {
                noChange_status = 0;
            }
            if (noChange_status > 100) {
                noChange_status = 0;
                //refreshpage();
            } else {
                setTimeout("check_FRPC_status();", 400);
            }
            _responseLen = response.length;
        }
    });
}

function toggle_switch() {
    var rrt = E("switch");
    if (document.form.frpc_enable.value != "1") {
        rrt.checked = false;
    } else {
        rrt.checked = true;
    }
}

function buildswitch() {
    $("#switch").click(
        function() {
            if (E('switch').checked) {
                document.form.frpc_enable.value = 1;
            } else {
                document.form.frpc_enable.value = 0;
            }
        });
}

function conf_to_obj() {
    if (typeof db_frpc != "undefined") {
        for (var field in db_frpc) {
            var el = E(field);
            if (el != null) {
                if (field == "frpc_config") {
                    el.value = Base64.decode(db_frpc[field]);
                } else {
                    el.value = db_frpc[field];
                }
            }
        }
    }
}
function qj2bj(str){
    var tmp = "";
    for(var i=0;i<str.length;i++){
        if(str.charCodeAt(i) >= 65281 && str.charCodeAt(i) <= 65374){
            tmp += String.fromCharCode(str.charCodeAt(i)-65248)
        }else if(str.charCodeAt(i) == 12288){
            tmp += ' ';
        }else{
            tmp += str[i];
        }
    }
    return tmp;
}
function validForm() {
    var temp_frpc = ["frpc_config"];
    for(var i = 0; i < temp_frpc.length; i++) {
        var temp_str = qj2bj(E(temp_frpc[i]).value);
        E(temp_frpc[i]).value = Base64.encode(temp_str);
    }
    return true;
}
function onSubmitCtrl(o, s) {
    var _form_addTr = document.form;
    if(trim(_form_addTr.frpc_config.value)==""){
        alert("提交的表单不能为空!");
        return false;
    }
    showSSLoadingBar(5);
    document.form.action_mode.value = s;
    if (validForm()) {
        updateOptions();
    }
}

function done_validating(action) {
    return true;
}

function updateOptions() {
    document.form.enctype = "";
    document.form.encoding = "";
    document.form.action = "/applydb.cgi?p=frpc_";
    document.form.SystemCmd.value = "config-frpc.sh";
    document.form.submit();
}

function menu_hook(title, tab) {
    var enable_ss = "<% nvram_get("enable_ss"); %>";
    var enable_soft = "<% nvram_get("enable_soft"); %>";
    if (enable_ss == "1" && enable_soft == "1") {
        tabtitle[tabtitle.length - 2] = new Array("", "Frp内网穿透");
        tablink[tablink.length - 2] = new Array("", "Module_frpc.asp");
    } else {
        tabtitle[tabtitle.length - 1] = new Array("", "Frp内网穿透");
        tablink[tablink.length - 1] = new Array("", "Module_frpc.asp");
    }
}

function showSSLoadingBar(seconds) {
    if (window.scrollTo)
        window.scrollTo(0, 0);

    disableCheckChangedStatus();

    htmlbodyforIE = document.getElementsByTagName("html"); //this both for IE&FF, use "html" but not "body" because <!DOCTYPE html PUBLIC.......>
    htmlbodyforIE[0].style.overflow = "hidden"; //hidden the Y-scrollbar for preventing from user scroll it.

    winW_H();

    var blockmarginTop;
    var blockmarginLeft;
    if (window.innerWidth)
        winWidth = window.innerWidth;
    else if ((document.body) && (document.body.clientWidth))
        winWidth = document.body.clientWidth;

    if (window.innerHeight)
        winHeight = window.innerHeight;
    else if ((document.body) && (document.body.clientHeight))
        winHeight = document.body.clientHeight;

    if (document.documentElement && document.documentElement.clientHeight && document.documentElement.clientWidth) {
        winHeight = document.documentElement.clientHeight;
        winWidth = document.documentElement.clientWidth;
    }

    if (winWidth > 1050) {
        winPadding = (winWidth - 1050) / 2;
        winWidth = 1105;
        blockmarginLeft = (winWidth * 0.3) + winPadding - 150;
    } else if (winWidth <= 1050) {
        blockmarginLeft = (winWidth) * 0.3 + document.body.scrollLeft - 160;
    }

    if (winHeight > 660)
        winHeight = 660;

    blockmarginTop = winHeight * 0.5

    E("loadingBarBlock").style.marginTop = blockmarginTop + "px";
    E("loadingBarBlock").style.marginLeft = blockmarginLeft + "px";
    E("loadingBarBlock").style.width = 770 + "px";
    E("LoadingBar").style.width = winW + "px";
    E("LoadingBar").style.height = winH + "px";

    loadingSeconds = seconds;
    progress = 100 / loadingSeconds;
    y = 0;
    LoadingLocalProgress(seconds);
}


function LoadingLocalProgress(seconds) {
    E("LoadingBar").style.visibility = "visible";
    if (document.form.frpc_enable.value != "1") {
        E("loading_block3").innerHTML = "Frpc关闭中 ..."
    } else {
        E("loading_block3").innerHTML = "Frpc启用中 ..."
    }

    y = y + progress;
    if (typeof(seconds) == "number" && seconds >= 0) {
        if (seconds != 0) {
            E("proceeding_img").style.width = Math.round(y) + "%";
            E("proceeding_img_text").innerHTML = Math.round(y) + "%";

            if (E("loading_block1")) {
                E("proceeding_img_text").style.width = E("loading_block1").clientWidth;
                E("proceeding_img_text").style.marginLeft = "175px";
            }
            --seconds;
            setTimeout("LoadingLocalProgress(" + seconds + ");", 1000);
        } else {
            E("proceeding_img_text").innerHTML = "完成";
            y = 0;
            setTimeout("hideSSLoadingBar();", 1000);
            refreshpage();
        }
    }
}

function reload_Soft_Center() {
    location.href = "/Main_Soft_center.asp";
}

function version_show() {
    $.ajax({
        url: 'https://koolshare.ngrok.wang/frpc/config.json.js',
        type: 'GET',
        dataType: 'jsonp',
        success: function(res) {
            if (typeof(res["version"]) != "undefined" && res["version"].length > 0) {
                if (res["version"] == db_frpc["frpc_version"]) {
                    $("#frpc_version_show").html("插件版本：" + res["version"]);
                } else if (res["version"] > db_frpc["frpc_version"]) {
                    $("#frpc_version_show").html("<font color=\"#66FF66\">有新版本：" + res.version + "</font>");
                }
            }
        }
    });
}
</script>
</head>
<body onload="init();">
    <div id="TopBanner"></div>
    <div id="Loading" class="popup_bg"></div>
    <div id="LoadingBar" class="popup_bar_bg">
        <table cellpadding="5" cellspacing="0" id="loadingBarBlock" class="loadingBarBlock" align="center">
            <tr>
                <td height="100">
                    <div id="loading_block3" style="margin:10px auto;width:85%; font-size:12pt;"></div>
                    <div id="loading_block1" class="Bar_container"> <span id="proceeding_img_text"></span>
                        <div id="proceeding_img"></div>
                    </div>
                    <div id="loading_block2" style="margin:10px auto; width:85%;">进度条走动过程中请勿刷新网页，请稍后...</div>
                </td>
            </tr>
        </table>
    </div>
    <iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>
    <form method="POST" name="form" action="/applydb.cgi?p=frpc_" target="hidden_frame">
        <input type="hidden" name="current_page" value="Module_frpc.asp">
        <input type="hidden" name="next_page" value="Module_frpc.asp">
        <input type="hidden" name="group_id" value="">
        <input type="hidden" name="modified" value="0">
        <input type="hidden" name="action_mode" value="">
        <input type="hidden" name="action_script" value="">
        <input type="hidden" name="action_wait" value="8">
        <input type="hidden" name="first_time" value="">
        <input type="hidden" name="preferred_lang" id="preferred_lang" value="<% nvram_get(" preferred_lang "); %>">
        <input type="hidden" name="SystemCmd" onkeydown="onSubmitCtrl(this, ' Refresh ')" value="">
        <input type="hidden" name="firmver" value="<% nvram_get(" firmver "); %>">
        <input type="hidden" id="frpc_enable" name="frpc_enable" value='<% dbus_get_def("frpc_enable", "0"); %>' />
        <table class="content" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td width="17">&nbsp;</td>
                <td valign="top" width="202">
                    <div id="mainMenu"></div>
                    <div id="subMenu"></div>
                </td>
                <td valign="top">
                    <div id="tabMenu" class="submenuBlock"></div>
                    <table width="98%" border="0" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                            <td align="left" valign="top">
                                <table width="760px" border="0" cellpadding="5" cellspacing="0" bordercolor="#6b8fa3" class="FormTitle" id="FormTitle">
                                    <tr>
                                        <td bgcolor="#4D595D" colspan="3" valign="top">
                                            <div>&nbsp;</div>
                                            <div class="formfonttitle">软件中心 - Frpc内网穿透</div>
                                            <div style="float:right; width:15px; height:25px;margin-top:-20px">
                                                <img id="return_btn" onclick="reload_Soft_Center();" align="right" style="cursor:pointer;position:absolute;margin-left:-30px;margin-top:-25px;" title="返回软件中心" src="/images/backprev.png" onMouseOver="this.src='/images/backprevclick.png'" onMouseOut="this.src='/images/backprev.png'"></img>
                                            </div>
                                            <div style="margin-left:5px;margin-top:10px;margin-bottom:10px">
                                                <img src="/images/New_ui/export/line_export.png">
                                            </div>
                                            <div class="SimpleNote">
                                                <i>* 为了Frpc稳定运行，请开启虚拟内存功能！！！</i>&nbsp;&nbsp;&nbsp;&nbsp;【<a href="http://koolshare.cn/thread-65379-1-1.html"  target="_blank"><i>服务器搭建教程</i></a>】
                                            </div>
                                            <table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable">
                                                <thead>
                                                    <tr>
                                                        <td colspan="2">Frpc - 高级设置</td>
                                                    </tr>
                                                </thead>
                                                <tr id="switch_tr">
                                                    <th style="width:20%;">
                                                        <label>开关</label>
                                                    </th>
                                                    <td colspan="2">
                                                        <div class="switch_field" style="display:table-cell;float: left;">
                                                            <label for="switch">
                                                                <input id="switch" class="switch" type="checkbox" style="display: none;">
                                                                <div class="switch_container">
                                                                    <div class="switch_bar"></div>
                                                                    <div class="switch_circle transition_style">
                                                                        <div></div>
                                                                    </div>
                                                                </div>
                                                            </label>
                                                        </div>
                                                        <div id="frpc_version_show" style="padding-top:5px;margin-left:30px;margin-top:0px;float: left;">
                                                            插件版本：<% dbus_get_def( "frpc_version", "未知"); %>
                                                        </div>
                                                        <div id="frpc_changelog_show" style="padding-top:5px;margin-right:50px;margin-top:0px;float: right;">
                                                            <a type="button" class="frpc_btn" style="cursor:pointer" href="https://raw.githubusercontent.com/koolshare/merlin_frpc/master/Changelog.txt" target="_blank">更新日志</a> <a type="button" class="frpc_btn" style="cursor:pointer" target="_blank" href="https://github.com/fatedier/frp/blob/master/README_zh.md">配置帮助</a>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr id="frpc_status">
                                                    <th width="20%">运行状态</th>
                                                    <td><span id="status">获取中...</span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th width="20%">DDNS显示</th>
                                                    <td>
                                                        <select id="frpc_ddns" name="frpc_ddns" style="margin:0px 0px 0px 2px;" class="input_option">
                                                            <option value="2" selected="selected">不做更改</option>
                                                            <option value="1">开启</option>
                                                            <option value="0">关闭</option>
                                                        </select>
                                                        <input type="text" class="input_ss_table" id="frpc_domain" name="frpc_domain" maxlength="255" value="" placeholder="填入要显示的域名，如:router.xxx.com" style="width:330px;margin-top: 3px;" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th width="20%">定时注册服务(<i>0为关闭</i>)</th>
                                                    <td>
                                                        每 <input type="text" id="frpc_cron_time" name="frpc_cron_time" class="input_3_table" maxlength="2" value="30" placeholder="" />
                                                        <select id="frpc_cron_hour_min" name="frpc_cron_hour_min" style="width:60px;margin:3px 2px 0px 2px;" class="input_option">
                                                            <option value="min" selected="selected">分钟</option>
                                                            <option value="hour">小时</option>
                                                        </select> 重新注册一次服务
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th style="width:20%;">Frpc配置</th>
                                                    <td>
                                                        <textarea placeholder="[common]&#13;&#10;server_addr = 127.0.0.1&#13;&#10;server_port = 7000&#10;&#10;[ssh]&#10;type = tcp&#10;local_ip = 127.0.0.1&#10;local_port = 22&#10;remote_port = 6000" cols="50" rows="20" id="frpc_config" name="frpc_config" style="width:99%; font-family:'Lucida Console'; font-size:12px;background:#475A5F;color:#FFFFFF;text-transform:none;margin-top:5px;" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false"></textarea>
                                                    </td>
                                                </tr>
                                            </table>
                                            <div id="warning" style="font-size:14px;margin:20px auto;"></div>
                                            <div class="apply_gen">
                                                <input class="button_gen" id="cmdBtn" onClick="onSubmitCtrl(this, ' Refresh ')" type="button" value="提交" />
                                            </div>
                                            <div style="margin-left:5px;margin-top:10px;margin-bottom:10px">
                                                <img src="/images/New_ui/export/line_export.png">
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="10" align="center" valign="top"></td>
            </tr>
        </table>
    </form>
    <div id="footer"></div>
</body>
</html>

