<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/6/11 0011
  Time: 21:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<h1 style="text-align: center">UserCrud</h1>
<input type='button' data-toggle='modal' data-target='#addUserModel' value='添加' class='btn btn-primary btn-large'>
<table class="table table-bordered" id="tab">
    <thead>
    <tr class="success">
        <th>编号</th>
        <th>姓名</th>
        <th>邮箱</th>
        <th>座右铭</th>
        <th colspan="3">操作</th>
    </tr>
    </thead>
</table>
<script>
   $.ajax({
        url:'/selectAllUserJson',
        success:function (data) {
            console.log(data);
            var users = eval('('+data+')');
/*
            var users=JSON.parse(data);
*/
            console.log(data);
            console.log(users);
            var str="";
           for(var i=0;i<users.length;i++){
             str+="<tr>";
             str+="<td>"+users[i].id+"</td>";
             str+="<td>"+users[i].userName+"</td>";
             str+="<td>"+users[i].email+"</td>";
             str+="<td>"+users[i].sign+"</td>";
             str+="<td><input type='button' value='删除' class='btn btn-primary btn-xs' onclick='del("+users[i].id+")'>";
             str+="&nbsp&nbsp";
             str+="<input type='button'  value='更新' data-toggle='modal' data-target='#updDUserModel' onclick='selectUser("+users[i].id+")' class='btn btn-primary btn-xs'>";
               str+="&nbsp&nbsp";
               str+="<input type='button' data-toggle='modal' data-target='#updUserModel' value='查看' onclick='selectUserById("+users[i].id+")' class='btn btn-primary btn-xs'></td>";
               str+="</tr>";
         }+
           $("#tab").append(str);
        }
    })
    function del(uid) {
        $.ajax({
            url:"/deleteUser/"+uid,
/*
            data:'{id:'+uid+'}',
*/
            type:'get',
            success:function (data) {
                console.log(data);
                if(data==1){
                    window.location.reload();
                }else{
                    alert("删除失败");
                }
            }
        })
    }
    function addUser() {
        var username=$('#userName').val();
        var userpassword=$('#userPassword').val();
        var email=$('#email').val();
        var sign=$('#sign').val();
        $.ajax({
            url:'${pageContext.request.contextPath}/saveUser',
            type:'post',
            data: "userName=" + username + "&userPassword=" + userpassword + "&email=" + email+"&sign="+sign,
            success:function (data) {
                if (data==1) {
                  window.location.reload();
                }else{
                       alert("添加失败");
                }
            }
        })
    }
    function selectUserById(uid) {

        $.ajax({
            url:'${PageContext.request.contextPath}/selectUserById/'+uid,
            success:function (data) {
                console.log(data);
                var res=eval('('+data+')');
                $('#updname').val(res.userName);
                $('#updpassword').val(res.userPassword);
                $('#updemail').val(res.email);
                $('#updsign').val(res.sign);

            }
        })

    }
    function  updateUser() {
/*
        var user=new FormData($('#updDuserForm')[0])
*/       var userId=$('#updDId').val();
        var username=$('#updDname').val();
        var userpassword=$('#updDpassword').val();
        var email=$('#updDemail').val();
        var sign=$('#updDsign').val();
        $.ajax({
            url:'/updateUser',
            data: "id="+userId+"&userName=" + username + "&userPassword=" + userpassword + "&email=" + email+"&sign="+sign,
            type:'post',
            success:function (data) {
                if(data==1){
                    alert("更新成功");
                    window.location.reload();
                }else{
                    alert("更新失败");
                    window.location.reload();
                }
            }
        })
    }
    function selectUser(uid) {
        $.ajax({
            url:'${PageContext.request.contextPath}/selectUserById/'+uid,
            /*
                        data:dataid,
            */
            success:function (data) {
                console.log(data);
                var res=eval('('+data+')');
                $('#updDId').val(res.id);
                $('#updDname').val(res.userName);
                $('#updDpassword').val(res.userPassword);
                $('#updDemail').val(res.email);
                $('#updDsign').val(res.sign);
            }
        })

    }
</script>
<div class="modal fade" id="addUserModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                   用户添加   </h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" id="adduserForm">
                    <div class="form-group">
                        <label for="userName" class="col-sm-2 control-label">名字</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="userName" id="userName"
                                   placeholder="请输入名字">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="userPassword" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" name="userPassword" id="userPassword"
                                   placeholder="请输入密码">
                        </div>
                    </div>
                    <div class="form-group">
                    <label for="email" class="col-sm-2 control-label">邮箱</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" name="email" id="email"
                               placeholder="请输入邮箱">
                    </div>
                </div>
                    <div class="form-group">
                        <label for="sign" class="col-sm-2 control-label">口号</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="sign" id="sign"
                                   placeholder="请输入口号">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" onclick="checkNull()">
                    添加
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="updDUserModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="updDmyModalLabel">
                    用户更新   </h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" id="updDuserForm">
                    <div class="form-group">
                        <div class="col-sm-10">
                            <input type="hidden" class="form-control" name="id" id="updDId">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="updDname" class="col-sm-2 control-label">名字</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="userName" id="updDname"
                                   placeholder="请输入名字">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="updDpassword" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" name="userPassword" id="updDpassword"
                                   placeholder="请输入密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="updDemail" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="updDemail"
                                   placeholder="请输入邮箱">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="updDsign" class="col-sm-2 control-label">口号</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="sign" id="updDsign"
                                   placeholder="请输入口号">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" onclick="clearForm()">清空
                </button>
                <button type="button" class="btn btn-primary" onclick="checkUNull()">
                    更新
                </button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="updUserModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="updmyModalLabel">
                    用户查看   </h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" id="upduserForm">
                    <div class="form-group">
                        <label for="updname" class="col-sm-2 control-label">名字</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="userName" id="updname"
                                   placeholder="请输入名字">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="updpassword" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" name="userPassword" id="updpassword"
                                   placeholder="请输入密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="updemail" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="updemail"
                                   placeholder="请输入邮箱">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="updsign" class="col-sm-2 control-label">口号</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="sign" id="updsign"
                                   placeholder="请输入口号">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    function checkUNull() {
        if ($("#updDname").val() == ""
            || $("#updDpassword").val() == ""||$("#updDemail").val()==""||$("#updDsign").val()=="") {
            alert("       '" + $(this).attr("placeholder") + "' 不能为空！\r\n");
            return false;
        } else {
            updateUser();
            return true;
        }
    }
    function checkNull() {
        if ($("#userName").val() == ""
            || $("#userPassword").val() == ""||$("#email").val()==""||$("#sign").val()=="") {
            alert("       '" + $(this).attr("placeholder") + "' 不能为空！\r\n");
            return false;
        } else {
            addUser();
            return true;
        }
    }
    //清空表单
    function clearForm(){
        $('#updname').val("");
        $('#updpassword').val("");
        $('#updemail').val("");
        $("#updsign").val("");
    }
</script>
</html>
