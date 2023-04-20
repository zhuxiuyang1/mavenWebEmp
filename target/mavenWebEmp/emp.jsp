<%--
  Created by IntelliJ IDEA.
  User: 86173
  Date: 2023/4/13
  Time: 17:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title></title>
    <!--引入easy支持-->
    <link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
    <script type="text/javascript" src="easyui/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">
      //***************页面加载原始数据*****************
      $(function (){
        $('#winemp').window('close');  // open a window
        //基本数据获取
        $.getJSON("doinit_Emp.do",function (map){
          var lsdep = map.lsdep;
          var lswf = map.lswf;
          //福利复选框
          for(var i = 0;i<lswf.length;i++){
              var wf = lswf[i];
              $("#wf").append("<input type='checkbox' name='wids' value='"+wf.wid+"'/>"+wf.wname);
          }
          //部门的下拉列表
          $('#cc').combobox({
            data:lsdep,
            valueField:'depid',
            textField:'depname',
            value:1,
            panelHeight:140
          });
        });
      });
      //****************************************
      //***************员工列表******************
      $(function () {
        $('#dg').datagrid({
          url: 'findPageAll_Student.do',
          width: 1000,
          striped: true,
          pagination: true,
          singleSelect: true,
          pageSize: 5,
          pageList: [1, 2, 3, 4, 5, 6],
          columns: [[
            {field: 'eid', title: '编号', width: 100, align: 'center'},
            {field: 'ename', title: '姓名', width: 100, align: 'center'},
            {field: 'sex', title: '性别', width: 100, align: 'center'},
            {field: 'address', title: '地址', width: 100, align: 'center'},
            {field: 'sdate', title: '生日', width: 100, align: 'center'},
            {field: 'photo', title: '照片', width: 100, align: 'center',
              formatter: function (value, row, index) {
                return '<img  id="myphoto" src=uppic/'+row.photo+' width="50" height="60">';
                  }
              },
            {field: 'depname', title: '部门', width: 100, align: 'center'},
            {
              field: 'opt', title: '操作', width: 240, align: 'center',
              formatter: function (value, row, index) {
                 var bt1 = '<input type="button" value="删除" onclick="dodelById(' + row.eid + ')">';
                 var bt2 = '<input type="button" value="编辑" onclick="findById(' + row.eid + ')">';
                 var bt3 = '<input type="button" value="详细" onclick="findDetail(' + row.eid + ')">';
                return bt1 + '&nbsp;' + bt2 + '&nbsp;' + bt3;
              }
            }
          ]]
        });
        //****************************************
        //***************删除与查找*****************
        dodelById = function (eid){
          $.messager.confirm('确认','您确认想要删除记录吗？',function(r){
            if (r){
              $.get('delById_Emp.do?eid='+eid,function (code){
                if (code == "1"){
                  $.messager.alert('提示', '删除成功');
                  $('#dg').datagrid('reload');    //重新载入当前页面数据
                } else {
                  $.messager.alert('警告', '删除失败');
                }
              });
            }
          });
        }
        findById = function (eid){
            $.getJSON('findById_Emp.do?eid='+eid,function (oldEmp){
                //删除复选框所有选中
                $(":checkbox[name='wids']").each(function (){
                    $(this).prop("checked",false);
                });
                //写入普通文本
              $('#ffemp').form('load',{
                eid:oldEmp.eid,
                ename:oldEmp.ename,
                sex:oldEmp.sex,
                address:oldEmp.address,
                sdate:oldEmp.sdate,
                depid:oldEmp.depid,
                emoney:oldEmp.emoney,
              });
              //处理照片
              $("#imgg").attr('src','uppic/'+oldEmp.photo);
              //设置复选框中
              var wids = oldEmp.wids;
              $(":checkbox[name='wids']").each(function (){
                for(var i = 0;i<wids.length;i++){
                    if($(this).val()==wids[i]){
                        $(this).prop("checked",true);
                    }
                }
              });
            });
        }


        findDetail = function (eid){
          $.getJSON('findById_Emp.do?eid='+eid,function (oldEmp){
            //写入普通文本
                      $("#eidtxt").html(oldEmp.eid);
                      $("#enametxt").html(oldEmp.ename);
                      $("#sextxt").html(oldEmp.sex);
                      $("#addresstxt").html(oldEmp.address);
                      $("#sdatetxt").html(oldEmp.sdate);
                      $("#depnametxt").html(oldEmp.depname);
                      $("#emoneytxt").html(oldEmp.emoney);
                      $("#phototxt").html(oldEmp.photo);
            //处理照片
            $("#imggt").attr('src','uppic/'+oldEmp.photo);
            //设置复选框中
            var lswf = oldEmp.lswf;
            var wnames = [];
              for(var i = 0;i<lswf.length;i++){
                var wf = lswf[i];
                wnames.push(wf.wname);
              }
              var stewf = wnames.join(',');
            $("#wftxt").html(stewf);
            $('#winemp').window('open');  // 隐藏状态
            });
        }

        //****************************************
        //***************保存与修改*****************
        $(function () {
          $("#btsave").click(function () {
            $.messager.progress();	// 显示进度条
            $('#ffemp').form('submit', {
              url: 'save_Emp.do',
              onSubmit: function () {
                var isValid = $(this).form('validate');
                if (!isValid) {
                  $.messager.progress('close');	// 如果表单是无效的则隐藏进度条
                }
                return isValid;	// 返回false终止表单提交
              },
              success: function (code) {
                if (code == "1") {
                  $.messager.alert('提示', '添加成功');
                  $('#dg').datagrid('reload');    //重新载入当前页面数据
                } else {
                  $.messager.alert('警告', '添加失败');
                }
                $.messager.progress('close');	// 如果提交成功则隐藏进度条
              }
            });
          });
        });
      });
      $(function () {
        $("#btupdate").click(function () {
          $.messager.progress();	// 显示进度条
          $('#ffemp').form('submit', {
            url: 'update_Emp.do',
            onSubmit: function () {
              var isValid = $(this).form('validate');
              if (!isValid) {
                $.messager.progress('close');	// 如果表单是无效的则隐藏进度条
              }
              return isValid;	// 返回false终止表单提交
            },
            success: function (code) {
              if (code == "1") {
                $.messager.alert('提示', '修改成功');
                $('#dg').datagrid('reload');    //重新载入当前页面数据
              } else {
                $.messager.alert('警告', '修改失败');
              }
              $.messager.progress('close');	// 如果提交成功则隐藏进度条
            }
          });
        });
      });
      //****************************************
    </script>
  </head>
  <body>
  <!--员工展示-->
  <p align="center">员工列表</p>
  <hr>
  <table id="dg"></table>
  <!--员工管理-->
  <form action="" id="ffemp" name="ffemp" method="post" enctype="multipart/form-data">
    <table align="center" width="550px" border="1px">
      <tr align="center" bgcolor="#FFFFCC">
        <td colspan="3">员工管理</td>
      </tr>
      <tr>
        <td>姓名</td>
        <td>
          <input type="text" id="ename" name="ename" class="easyui-validatebox" data-options="required:true">
        </td>
        <td rowspan="7">
          <img id="imgg" src="uppic/default.jpg" width="160" height="150" />
        </td>
      </tr>
      <tr>
        <td>性别</td>
        <td>
         <input type="radio" id="sex" name="sex" value="男" checked="checked">男
          <input type="radio" id="sex" name="sex" value="女">女
        </td>
      </tr>
      <tr>
        <td>地址</td>
        <td>
          <input type="text" id="address" name="address" class="easyui-validatebox" data-options="required:true">
        </td>
      </tr>
      <tr>
        <td>生日</td>
        <td>
          <input type="date" id="sdate" name="sdate" value="2001-09-01">
        </td>
      </tr>
      <tr>
        <td>上传照片</td>
        <td>
          <input type="file" id="pic" name="pic">
        </td>
      </tr>
      <tr>
        <td>部门</td>
        <td >
          <input type="text" id="cc" name="depid">
        </td>
      </tr>
      <tr>
        <td>薪资</td>
        <td>
          <input type="text" id="emoney" name="emoney" value="2000">
        </td>
      </tr>
      <tr>
        <td>福利</td>
        <td colspan="2">
          <span id="wf"></span>
        </td>
      </tr>
      <tr align="center" bgcolor="#FFFFCC">
        <td colspan="3">
          <input type="hidden" id="eid" name="eid">
          <input type="button" id="btsave" value="添加">
          <input type="button" id="btupdate" value="修改">
          <input type="reset" value="重置">
        </td>
      </tr>
    </table>
  </form>
  <!--详情弹窗-->
  <div id="winemp" class="easyui-window" title="员工详细信息" style="width:600px;height:400px"
       data-options="iconCls:'icon-save',modal:true">
    <table align="center" width="550px" border="1px" height="350px">
      <tr>
        <td>编号</td>
        <td>
          <span id="eidtxt"></span>
        </td>
      </tr>
      <tr>
        <td>姓名</td>
        <td>
          <span id="enametxt"></span>
        </td>
        <td rowspan="7" width="200px">
          <img id="imggt" src="uppic/default.jpg" width="160" height="150" />
        </td>
      </tr>
      <tr>
        <td>性别</td>
        <td>
          <span id="sextxt"></span>
        </td>
      </tr>
      <tr>
        <td>地址</td>
        <td>
          <span id="addresstxt"></span>
        </td>
      </tr>
      <tr>
        <td>生日</td>
        <td>
          <span id="sdatetxt"></span>
        </td>
      </tr>
      <tr>
        <td>照片</td>
        <td>
          <span id="phototxt"></span>
        </td>
      </tr>
      <tr>
        <td>部门</td>
        <td >
          <span id="depnametxt"></span>
        </td>
      </tr>
      <tr>
        <td>薪资</td>
        <td>
          <span id="emoneytxt"></span>
        </td>
      </tr>
      <tr>
        <td>福利</td>
        <td colspan="2">
          <span id="wftxt"></span>
        </td>
      </tr>
    </table>
  </div>
  </body>
  </body>
</html>
